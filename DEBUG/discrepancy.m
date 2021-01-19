%% Read from file
filepath_input = '../INPUT/';
filepath_output = '../OUTPUT/';
file_alphabet = input('Enter a letter from "a" to "k" to specify a dataset: ', 's');

if char(file_alphabet) >= 'a' && char(file_alphabet) <= 'f'
    str = '-Debug-';
elseif char(file_alphabet) >= 'g' && char(file_alphabet) <= 'h' || char(file_alphabet) == 'j' || char(file_alphabet) == 'k'
    str = '-Unknown-';
else
    error("Invalid letter")
end

filename_ans = strcat(filepath_input, 'PA5-', upper(file_alphabet), str, 'Answer.txt');
filename_mine = strcat(filepath_output, 'pa5-', lower(file_alphabet), '-Output.txt');

[m_lams_ans, s_set_ans, c_set_ans, diff_ans] = read(filename_ans);
[m_lams_mine, s_set_mine, c_set_mine, diff_mine] = read(filename_mine);

error_m_lams = [];
error_s = [];
error_c = [];
error_diff = [];

for i = 1:size(m_lams_ans)
    error_m_lams = [error_m_lams m_lams_ans(i) - m_lams_mins(i)];
end

for i = 1:size(c_set_ans, 2)
    s_diff = s_set_ans(i) - s_set_mine(i);
    c_diff = c_set_ans(i) - c_set_mine(i);
    diff_diff = diff_ans(i) - diff_mine(i);

    error_s = [error_s; s_diff.value(1), s_diff.value(2), s_diff.value(3)];
    error_c = [error_c; c_diff.value(1), c_diff.value(2), c_diff.value(3)];
    error_diff = [error_diff diff_diff];
end

m_lams_average_error = mean(abs(error_m_lams), 'all');
s_average_error = mean(abs(error_s), 'all');
c_average_error = mean(abs(error_c),'all');
diff_average_error = mean(abs(error_diff), 'all');

fig_lams = figure;
hold on
bar(abs(error_m_lams))
title(strcat("File", upper(file_alphabet), ": Discrepancy in mode weights"))
yline(m_lams_average_error)
hold off

fig_s = figure;
hold on
bar(abs(error_s))
title(strcat("File", upper(file_alphabet), ": Discrepancy in s"))
yline(s_average_error)
ylim([0,0.11])
legend('x','y','z')
hold off

fig_c = figure;
hold on
bar(abs(error_c))
title(strcat("File", upper(file_alphabet), ": Discrepancy in c"))
yline(c_average_error)
ylim([0,0.11])
legend('x','y','z')
hold off

fig_diff = figure;
hold on
bar(abs(error_diff))
title(strcat("File", upper(file_alphabet), ": Discrepancy in the magnitude difference between s and c"))
yline(diff_average_error)
ylim([0,0.11])
hold off

intersect = zeros(size(error_c, 1), 3);
s_only = zeros(size(error_s, 1), 3);
c_only = zeros(size(error_c, 1), 3);
c = abs(error_c);
s = abs(error_s);
for i = 1:3
    for j = 1:size(error_c, 1)
        if c(j, i) == s(j, i) && c(j, i) ~= 0
            intersect(j, i) = c(j, i);
        elseif c(j, i) == 0 && s(j, i) ~= 0
            s_only(j, i) = s(j, i);
        elseif s(j, i) == 0 && c(j, i) ~= 0
            c_only(j, i) = c(j, i);
        end
    end
end
fig_compare = figure;
hold on
bar(intersect, 'k')
bar(c_only, 'c')
bar(s_only, 'm')
title(strcat("File", upper(file_alphabet), ": Comparing discrepancies in s and c"))
ylim([0,0.11])
hold off

saveas(fig_c,strcat(file_alphabet, '_c.png'));
saveas(fig_s,strcat(file_alphabet, '_s.png'));

%% Helper functions
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
    end
end

function [m_lams, s, c, diff] = read(filename)
    fileID = fopen(filename, 'r');

    % Get the number of markers
    num = get_num(fileID, 2);
    
    parts = strsplit(filename, '/');
    fscanf(fileID, '%c', length(char(parts(3))) + 1);
    num_modes = get_num(fileID, 1);

    fgetl(fileID);
    
    m_lams = zeros(1, num_modes);
    for i = 1:num_modes
        fscanf(fileID, '%[ ]', Inf);
        m_lams(i) = fscanf(fileID, '%f', 1);
    end
    
    s = [];
    c = [];
    diff = [];
    for i = 1:num
        % Form a set of Vector objects c
        s = [s form_vector_set(1, fileID)];
        % Form a set of Vector objects d
        c = [c form_vector_set(1, fileID)];
        % get diff
        fscanf(fileID, '%[ ]', Inf);
        diff = [diff fscanf(fileID, '%f', 1)];
        fgetl(fileID);
    end
    fclose(fileID);
end
