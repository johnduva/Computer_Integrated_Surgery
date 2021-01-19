%% Functions for writing to file
function write_result(filename, s_set, c_set, m_lams)
    % Open file to be written to
    fileID = fopen(filename, 'w');

    parts = strsplit(filename, '/');
    num_sample = length(c_set);
    num_modes = length(m_lams);
    % Print the number of samples and file name on the first line
    fprintf(fileID, '%s\n', [num2str(num_sample), ', ', char(parts(3)), ',', num2str(num_modes)]);

    % print modes
    for i = 1:size(m_lams)
        fprintf(fileID, '  %.4f', m_lams(i));
    end
    fprintf(fileID, '\n');
       
    % Format for each line
    format = '  %6.2f,   %6.2f,   %6.2f       %6.2f,   %6.2f,   %6.2f     %6.3f\n';

    % Print s, c, and norm(s - c)
    for i = 1:num_sample
        s = s_set(i).value;
        c = c_set(i).value;
        diff = norm(s_set(i) - c_set(i));
        fprintf(fileID, format, s(1), s(2), s(3), c(1), c(2), c(3), diff);
    end

    % Close file
    fclose(fileID);
end
