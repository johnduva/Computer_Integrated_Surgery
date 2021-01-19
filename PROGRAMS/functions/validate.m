function validate(fileID, filename)
    parts = strsplit(filename, '/');
    if (fgetl(fileID) ~= char(parts(3)))
        error('Invalid file');
    end
end