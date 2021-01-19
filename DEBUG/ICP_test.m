clear all
filepath = '../INPUT/';
filename_mesh = strcat(filepath, 'Problem4MeshFile.sur');
[v_set, triangle_v_set] = read_from_mesh(filename_mesh);
num_triangles = str2double(input('Enter the number of data points you wish to select: ', 's'));
noise = str2double(input('How much noise do you want to add to the set of data points created? (0-100%): ', 's'));
fprintf('Starting the test...\n');

%% Randomly select the number of triangles speicified
triangle_ind = randi([1,length(triangle_v_set)],num_triangles,1);

%% Randmly select a point on each triangles on the mesh
datapoints = [];
x = [];
y = [];
z = [];
for i = 1:length(triangle_ind)
    vertices = triangle_v_set(i, :);
    p = v_set(vertices(1) + 1);
    q = v_set(vertices(2) + 1);
    r = v_set(vertices(3) + 1);
    
    datapoints = [datapoints random_point(p, q, r)];
    x = [x datapoints(i).value(1)];
    y = [y datapoints(i).value(2)];
    z = [z datapoints(i).value(3)];
end

%% Add noise if needed
num_noise = round(num_triangles * (noise / 100)) ;
if num_noise >= 1
    for i = 1:num_noise
        datapoints(i) = Vector(max(x) + 100*rand, max(y) + 100*rand, max(z) + 100*rand);
    end
end

%% Create a random transformation
r = Rotation;
r.value = eye(3);
F_reg_expected = Frame(r, Vector(0, 0, 0));
F_reg_expected.value = F_reg_expected.value - [- 0.01 + 0.02*rand(3, 4) ; 0 0 0 0];

%% Apply the transformations to the data points
transformation = inv(F_reg_expected);
d_set = [];
for i = 1:length(datapoints)
    d_set = [d_set transformation * datapoints(i)];
end
N = length(d_set);

%% Try to recover c_set using the ICP code
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

while count < 7
    fprintf('%s%d%s\n', 'Starting iteration ', n + 1, '...')
    %% Matching (step 1)
    A = [];
    B = [];
    E = [];
    s_set_prev = s_set_curr;
    s_set_curr = [];
    c_set_prev = c_set_curr;
    c_set_curr = [];
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
            c_set_curr = [c_set_curr find_closest_point_on_mesh(bound, 0, s_set_curr(k), v_set, triangle_v_set)];
        else
            c_set_curr = [c_set_curr find_closest_point_on_mesh(bound, c_set_prev(k), s_set_curr(k), v_set, triangle_v_set)];
        end
        
        % compare the distance ||c - F*q|| to the threshold
        dist = norm(c_set_curr(k) - s_set_curr(k));
        if  dist < threshold
            A = [A d_set(k)];
            B = [B c_set_curr(k)];
            % residual error
            E = [E dist];
        end
    end
   
    %% Transformation update (step 2)
    n = n + 1;
    F_reg = registration3dTo3d(A, B);
    sigma = [sigma sqrt(sum(E.^2))/length(E)];
    epsilon_max = [epsilon_max max(sqrt(E.^2))];
    epsilon_avg = [epsilon_avg sum(E.^2)/length(E)];
    
    %% Adjustment (step 3)
    all_E = [all_E E];
    threshold = prctile(all_E, 95);
    
    count = termination_test(sigma, epsilon_max, epsilon_avg, n, count);
end  

%% Show plot
filepath = '../OUTPUT/';
fig = figure;
hold on
plot(1:n, epsilon_avg)
ylabel("Average magnitude difference (mm)")
xlabel("Number of iterations")
hold off

passed = 1;
if epsilon_avg(n) > 1
    passed = 0;
end

if passed
    fprintf('passed!\n');
else
    fprintf('failed!\n');
end

%% Termination test
function count = termination_test(sigma, epsilon_max, epsilon_avg, n, count)
    SIGMA_THRESHOLD = 0.00025795;
    EPSILON_MAX_THRESHOLD = 0.0105;
    EPSILON_AVG_THRESHOLD = 0.000013279;
    
    if (n~= 0 && n~= 1) && (sigma(n) < SIGMA_THRESHOLD || epsilon_max(n) < EPSILON_MAX_THRESHOLD || epsilon_avg(n) < EPSILON_AVG_THRESHOLD)
        ratio = epsilon_avg(n) / epsilon_avg(n-1);
        if 0.95 <= ratio && ratio <= 1
            count = count + 1;
        end     
    end
    
    if n == 75
        count = 7;
    end
end

%% Function for choosing a random point in the triangle
function vec = random_point(p, q, r)
    lambda = rand;
    mu = 1 - lambda;
    vec = p + lambda*(q - p) + mu*(r - p);
end

%% Functions for reading from mesh file
function num = get_num(fileID, num_discard)
    num = fscanf(fileID, '%f', 1);
    fscanf(fileID, '%c', num_discard);
end

function set = form_vector_set(num, fileID)
    set = [];
    for i = 1:num
        fscanf(fileID, '%[ ]', Inf);
        x = fscanf(fileID, '%f', 1);
        fscanf(fileID, '%c', 1);
        fscanf(fileID, '%[ ]', Inf);
        y = fscanf(fileID, '%f', 1);
        fscanf(fileID, '%c', 1);
        fscanf(fileID, '%[ ]', Inf);
        z = fscanf(fileID, '%f', 1);
        set = [set Vector(x, y, z)];
        fgetl(fileID);
    end
end

function [v_set, triangle_v_set] = read_from_mesh(filename)
    fileID = fopen(filename, 'r');

    % Get the number of vertices
    num = get_num(fileID, 1);

    % Read coordinates of vertices in CT coordinates
    v_set = form_vector_set(num, fileID);
    
    % Get the number of triangles
    num = get_num(fileID, 1);
    
    % Read vertex indices of triangle
    triangle_v_set = [];
    for i = 1:num
        i1 = fscanf(fileID, '%f', 1);
        fscanf(fileID, '%[ ]', Inf);
        i2 = fscanf(fileID, '%f', 1);
        fscanf(fileID, '%[ ]', Inf);
        i3 = fscanf(fileID, '%f', 1);
        triangle_v_set = [triangle_v_set; [i1 i2 i3]];
        fgetl(fileID);
    end
        
    fclose(fileID);
end
