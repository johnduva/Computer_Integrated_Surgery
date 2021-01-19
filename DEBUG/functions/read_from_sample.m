function [A_sample, B_sample, num_modes] = read_from_sample(filename, num_a, num_b)
    fileID = fopen(filename, 'r');

    % Get the number of markers
    num_led = get_num(fileID, 2);
    num_sample = get_num(fileID, 2);
    
    parts = strsplit(filename, '/');
    fscanf(fileID, '%c', length(char(parts(3))) + 1);
    num_modes = get_num(fileID, 1);

    fgetl(fileID);
    
    A_sample = [];
    B_sample = [];
    D_sample = [];
    for i = 1:num_sample
        % Form a set of Vector objects a
        A_sample = [A_sample; form_vector_set(num_a, fileID)];
        % Form a set of Vector objects b
        B_sample = [B_sample; form_vector_set(num_b, fileID)];
        
        D_sample = [D_sample; form_vector_set(num_led - num_a - num_b, fileID)];
    end
    fclose(fileID);
end