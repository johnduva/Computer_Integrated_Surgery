
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
