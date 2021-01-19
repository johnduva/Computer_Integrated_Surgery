function frame = registration3dTo3d(a, b)
    [~, num_vec_a] = size(a);
    [~, num_vec_b] = size(b);
    
    % Validate the two given sets
    if num_vec_a ~= num_vec_b
        error('The number of points in the two sets must be equal')
    end
    
    num_vec = num_vec_a;
    
    % Compute the average of all vectors in a and b respectively
    a_bar = avg(a);
    b_bar = avg(b);
    
    % Compute a and b relative to the local coordinate system
    for i = 1 : num_vec
        a(i) = a(i) - a_bar;
        b(i) = b(i) - b_bar;
    end
    
    H = zeros(3);
    for i = 1 : num_vec
        H = H + a(i).value(1:3) * transpose(b(i).value(1:3));
    end
    
%     %% SVD
%     [U, ~, V] = svd(H);
%     rot = V * transpose(U);
%     
%     if (det(rot) - 1 < 0.0001)
%         R = Rotation;
%         R.value = rot;
%         
%         p = b_bar - R * a_bar;
%         frame = Frame(R, p);
%     else
%         error('Operation failed');
%     end
    
    %% Quaternion
    delta = [H(2, 3) - H(3, 2); H(3, 1) - H(1, 3); H(1, 2) - H(2, 1)];
    G = [trace(H) transpose(delta); delta H + transpose(H) - trace(H) * eye(3)];
    
    [V, D] = eigs(G);
    [~, i] = max(max(D));
    
    R = Rotation;
    R.value = quat2rotm(transpose(V(:, i))); 
    
    p = b_bar - R * a_bar;
    
    frame = Frame(R, p);
end