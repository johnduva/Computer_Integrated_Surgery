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
