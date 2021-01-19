function [set, tip] = read_from_body(filename)
    fileID = fopen(filename, 'r');

    % Get the number of markers
    num = get_num(fileID, 1);

    % Validate file
    validate(fileID, filename);

    % Read coordinates of markers to form Vector objects
    set = form_vector_set(num, fileID);
    % Read coordinates of tip in body coordinate
    tip = form_vector_set(1, fileID);
    
    fclose(fileID);
end