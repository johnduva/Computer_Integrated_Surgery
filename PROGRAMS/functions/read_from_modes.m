function vertex_displacements = read_from_modes(filename)
    fileID = fopen(filename, 'r');
    fscanf(fileID, '%c', 28);
    num_vertices = fscanf(fileID, '%f', 1);
    fscanf(fileID, '%c', 8);
    num_modes = fscanf(fileID, '%f', 1);
    
    fgetl(fileID);
    
    vertex_displacements = [];
    for i = 1:num_modes + 1
        fgetl(fileID);
        vertex_displacements = [vertex_displacements; form_vector_set(num_vertices, fileID)];
    end
end
