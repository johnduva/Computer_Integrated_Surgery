%% PA5: Extend the ICP program of assignments 3 and 4 to perform a simple deformable registration
%  Authors: John D'Uva and Vivian Looi

% Files:
%   - mesh: A 3D bone surface, represented as a mesh of triangles. Includes the 
%           coordinates of the vertices of this mesh in CT coordinates. 
%           
%   - modes: m(row,col) where m = 'vertex_displacements'
%           An atlas file giving the modes of variation for the model.
%           "Mode(0,:)" represents the average vertex (i.e. shape provided in the 
%           mesh file). If vector 'm(m,k)' represents a 3D value associated 
%           with vertex 'k' and mode 'm', then the actual coordinate of
%           vertex 'k' will be given by:  m(k)  =  m(0,k) + sum( lambda * m(m,k) )
                         
%% Create OUTPUT directory for results
clear
if ~exist('../OUTPUT', 'dir')
    mkdir('../OUTPUT/');
end

%% Compose file name
addpath('functions')
filepath = '../INPUT/';
file_alphabet = input('Enter a letter from "a" to "k" (except i) to specify a dataset: ', 's');

if char(file_alphabet) >= 'a' && char(file_alphabet) <= 'f'
    str = '-Debug-SampleReadingsTest.txt';
elseif char(file_alphabet) >= 'g' && char(file_alphabet) <= 'h' || char(file_alphabet) == 'j' || char(file_alphabet) == 'k'
    str = '-Unknown-SampleReadingsTest.txt';
else
    error("Invalid letter")
end

filename_bodyA = strcat(filepath, 'Problem5-BodyA.txt');
filename_bodyB = strcat(filepath, 'Problem5-BodyB.txt');
filename_mesh = strcat(filepath, 'Problem5MeshFile.sur');
filename_modes = strcat(filepath, 'Problem5Modes.txt');
filename_sample = strcat(filepath, 'PA5-', upper(file_alphabet), str);

%% Read from files
[a_set, a_tip] = read_from_body(filename_bodyA);
[b_set, b_tip] = read_from_body(filename_bodyB);
[v_set, triangle_v_set] = read_from_mesh(filename_mesh);
[A_sample, B_sample, num_modes] = read_from_sample(filename_sample, length(a_set), length(b_set));
m = read_from_modes(filename_modes);

%% Verify that vertices of mesh are same as first row of 'm'
if verify(m, v_set, .01)

    %% Compute F_A and F_B
    F_A = find_frame_transformation(a_set, A_sample);
    F_B = find_frame_transformation(b_set, B_sample);

    %% Compute d
    d_set = [];
    for i = 1:length(F_A)
        d_set = [d_set inv(F_B(i)) * F_A(i) * a_tip];    
    end
    N = length(d_set);

    %% Initialization (step 0)
    n = 0;
    count = 0;
    r = Rotation;
    r.value = eye(3);
    F_reg = Frame(r, Vector(0, 0, 0)); % Guess F_reg = I
    threshold = 100; % initial threshold for match closeness
    all_E = [];
    E = []; % residual erros b - F*a
    sigma = [];
    epsilon_max = [];
    epsilon_avg = [];
    s_set_prev = [];
    s_set_curr = [];
    c_set_prev = [];
    c_set_curr = [];
    idxs_prev = [];
    idxs_curr = [];
    m_lams_diff_curr = 1;
    m_lams = [];
    count_mm = [];
    m_lams_curr = zeros(num_modes, 1);
    
    for n = 1:100
        fprintf('%s%d%s\n', 'Starting iteration ', n + 1, '...')
        for p = 1:30
            %% Start model matching iteration: find new c_k(t+1)
            A = [];
            B = [];
            E = [];
            s_set_prev = s_set_curr;
            s_set_curr = [];
            c_set_prev = c_set_curr;
            c_set_curr = [];
            idxs_prev = idxs_curr;
            idxs_curr = [];
            v_set_curr = [];
            
            % update surface model vertices
            for i = 1:length(v_set)
                [new, ~] = get_deformed_coord(m, i, m_lams_curr);
                v_set_curr = [v_set_curr new];
            end
            
            for k = 1:N
                if n == 0
                    bound = intmax;
                else
                    bound = norm(c_set_prev(k) - s_set_prev(k));
                end
                
                % Compute s
                s_set_curr = [s_set_curr F_reg * d_set(k)];
                % Compute c
                if n == 0
                    [c, idx] = find_closest_point_on_mesh(bound, 0, s_set_curr(k), v_set_curr, triangle_v_set, 0);            
                else           
                    [c, idx] = find_closest_point_on_mesh(bound, c_set_prev(k), s_set_curr(k), v_set_curr, triangle_v_set, idxs_prev(k));
                end
                c_set_curr = [c_set_curr c];
                idxs_curr = [idxs_curr; idx];

                % compare the distance ||c - F*q|| to the threshold
                dist = norm(c_set_curr(k) - s_set_curr(k));
                if  dist < threshold
                    A = [A d_set(k)];
                    B = [B c_set_curr(k)];
                    % residual error
                    E = [E dist];
                else
                    count = count + 1;
                end
            end

            %% Find coordinates of vertices that c_k is on in the deformed mesh       
            Q = []; C = [];    
            for ck = 1 : N      
                [s,t,u] = deal(triangle_v_set(idxs_curr(ck),1), triangle_v_set(idxs_curr(ck),2), triangle_v_set(idxs_curr(ck),3));

                % Build m_s
                [m_s, m_ms] = get_deformed_coord(m, s + 1, m_lams_curr);

                % Build m_t
                [m_t, m_mt] = get_deformed_coord(m, t + 1, m_lams_curr);

                % Build m_u
                [m_u, m_mu] = get_deformed_coord(m, u + 1, m_lams_curr);

                %% Find coordinates of c_k in the deformed mesh
                [lambda, mu, v] = get_barycentric_coord(c_set_curr(ck), m_s, m_t, m_u);

                % Use weights to gets 1's
                q_0k = (lambda * m(1,s + 1)) + (mu * m(1,t + 1)) + (v * m(1,u + 1));
                q_mk = (lambda * m_ms) + (mu * m_mt) + (v * m_mu);

                % Calculate coordinates in deformed mesh
                ck_deformed = q_0k.value(1:3)' + sum(m_lams_curr .* q_mk);
                c_set_curr(ck) = Vector(ck_deformed(1), ck_deformed(2), ck_deformed(3));

                % Build matrices over iterations for least squares
                C = [C; (s_set_curr(k).value(1:3) - q_0k.value(1:3))];
                Q = [Q; q_mk'];
            end

            %% Solve for the corresponding least squares problem for mode weights
            m_lams = [m_lams [count; m_lams_curr]];
            m_lams_prev = m_lams_curr;
            m_lams_diff_prev = m_lams_diff_curr;
            m_lams_curr = Q\C;
            m_lams_diff_curr = m_lams_curr - m_lams_prev;
            ratio = abs(m_lams_diff_curr ./ m_lams_diff_prev);
            if length(find(abs(m_lams_diff_curr) < 0.1)) == num_modes || (mean(ratio) > 0.9 && mean(ratio) < 1.1) || m_lams_curr(1, 1) == 30
                count_mm = count_mm + 1;
            end
            if count_mm == 5
                break
            end
        end


        %% Transformation update
        % After this iteration converges, keep the model vertices fixed and use
        % the method of PA#4 to re-estimate F_reg (p.11)
        F_reg = registration3dTo3d(A, B);
        sigma = [sigma sqrt(sum(E.^2))/length(E)];
        epsilon_max = [epsilon_max max(sqrt(E.^2))];
        epsilon_avg = [epsilon_avg sum(E.^2)/length(E)];

        %% Adjustment
        all_E = [all_E E];
        threshold = prctile(all_E, 95);

        f = figure;
        histogram(all_E);
        hold on
        xline(threshold);
        title(sprintf('Distribution of error when n = %d', n))
        saveas(f,[file_alphabet,'-', num2str(n), '-error', '.png']);
        close(f)
        fprintf('%d\n', count);
    end  
    
    save(strcat(file_alphabet, '_sigma.mat'), 'sigma');
    save(strcat(file_alphabet, '_epsilon_max.mat'), 'epsilon_max');
    save(strcat(file_alphabet, '_epsilon_avg.mat'), 'epsilon_avg');
    
    %% Files:
    %   - F_reg: transformation of rigid body B into CT space ("rigid" transformation)
    %   - d(k):  A_tip in rigid body B coordinate space
    %   - s(k):  current est of sample coordinates (A_tip in mesh/CT space over iters 't')
    %   - c(k):  current est of closest point on deformed surface (v_set) to transformed 
    %            sample point, s(k), on some triangle 

    %% Output
    filepath = '../OUTPUT/';
    output_filename = strcat(filepath, 'pa5-', file_alphabet, '-Output.txt');
    write_result(output_filename, s_set_curr, c_set_curr, m_lams_curr);

    fig = figure;
    hold on
    plot(1:n, epsilon_avg)
    title(strcat("Dataset ", file_alphabet))
    ylabel("Average magnitude difference (mm)")
    xlabel("Number of iterations")
    hold off
    saveas(fig,strcat(filepath, 'pa5-', file_alphabet, '.png'));

    fprintf('%s\n', ['Results written to: ' output_filename])
end