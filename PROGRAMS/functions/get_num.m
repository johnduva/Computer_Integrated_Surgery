%% Functions for reading from file
function num = get_num(fileID, num_discard)
    num = fscanf(fileID, '%f', 1);
    fscanf(fileID, '%c', num_discard);
end
