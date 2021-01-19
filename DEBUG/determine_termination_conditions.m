clear all
%% Load data
mat = dir('Data_for_100_iterations/*.mat');
for i = 1:size(mat, 1)
    load(['Data_for_100_iterations/' mat(i).name])
end

sigma_diff = max([a_sigma(99) - a_sigma(100) b_sigma(99) - b_sigma(100) c_sigma(99) - c_sigma(100) d_sigma(99) - d_sigma(100) e_sigma(99) - e_sigma(100) f_sigma(99) - f_sigma(100) g_sigma(99) - g_sigma(100) h_sigma(99) - h_sigma(100) j_sigma(99) - j_sigma(100) k_sigma(99) - k_sigma(100)]);
epsilon_max_diff = max([a_epsilon_max(99) - a_epsilon_max(100) b_epsilon_max(99) - b_epsilon_max(100) c_epsilon_max(99) - c_epsilon_max(100) d_epsilon_max(99) - d_epsilon_max(100) e_epsilon_max(99) - e_epsilon_max(100) f_epsilon_max(99) - f_epsilon_max(100) g_epsilon_max(99) - g_epsilon_max(100) h_epsilon_max(99) - h_epsilon_max(100) j_epsilon_max(99) - j_epsilon_max(100) k_epsilon_max(99) - k_epsilon_max(100)]);
epsilon_avg_diff = max([a_epsilon_avg(99) - a_epsilon_avg(100) b_epsilon_avg(99) - b_epsilon_avg(100) c_epsilon_avg(99) - c_epsilon_avg(100) d_epsilon_avg(99) - d_epsilon_avg(100) e_epsilon_avg(99) - e_epsilon_avg(100) f_epsilon_avg(99) - f_epsilon_avg(100) g_epsilon_avg(99) - g_epsilon_avg(100) h_epsilon_avg(99) - h_epsilon_avg(100) j_epsilon_avg(99) - j_epsilon_avg(100) k_epsilon_avg(99) - k_epsilon_avg(100)]);

%% Find most significant decimal place for the smallest data
sigma_d = 0;
while sigma_diff < 1
    sigma_d = sigma_d - 1;
    sigma_diff = sigma_diff * 10;
end

epsilon_max_d = 0;
while epsilon_max_diff < 1
    epsilon_max_d = epsilon_max_d - 1;
    epsilon_max_diff = epsilon_max_diff * 10;
end

epsilon_avg_d = 0;
while epsilon_avg_diff < 1
    epsilon_avg_d = epsilon_avg_d - 1;
    epsilon_avg_diff = epsilon_avg_diff * 10;
end


%% Find threshold for sigma
a_sigma_bool = zeros(1, 100);
b_sigma_bool = zeros(1, 100);
c_sigma_bool = zeros(1, 100);
d_sigma_bool = zeros(1, 100);
e_sigma_bool = zeros(1, 100);
f_sigma_bool = zeros(1, 100);
g_sigma_bool = zeros(1, 100);
h_sigma_bool = zeros(1, 100);
j_sigma_bool = zeros(1, 100);
k_sigma_bool = zeros(1, 100);
for i = 2:100
    if a_sigma(i - 1) - a_sigma(i) < 10^(sigma_d - 1)
        a_sigma_bool(i) = 1;
    end
    if b_sigma(i - 1) - b_sigma(i) < 10^(sigma_d - 1)
        b_sigma_bool(i) = 1;
    end
    if c_sigma(i - 1) - c_sigma(i) < 10^(sigma_d - 1)
        c_sigma_bool(i) = 1;
    end
    if d_sigma(i - 1) - d_sigma(i) < 10^(sigma_d - 1)
        d_sigma_bool(i) = 1;
    end
    if e_sigma(i - 1) - e_sigma(i) < 10^(sigma_d - 1)
        e_sigma_bool(i) = 1;
    end
    if f_sigma(i - 1) - f_sigma(i) < 10^(sigma_d - 1)
        f_sigma_bool(i) = 1;
    end
    if g_sigma(i - 1) - g_sigma(i) < 10^(sigma_d - 1)
        g_sigma_bool(i) = 1;
    end
    if h_sigma(i - 1) - h_sigma(i) < 10^(sigma_d - 1)
        h_sigma_bool(i) = 1;
    end
    if j_sigma(i - 1) - j_sigma(i) < 10^(sigma_d - 1)
        j_sigma_bool(i) = 1;
    end
    if k_sigma(i - 1) - k_sigma(i) < 10^(sigma_d - 1)
        k_sigma_bool(i) = 1;
    end
end

a_sigma_threshold = 0;
b_sigma_threshold = 0;
c_sigma_threshold = 0;
d_sigma_threshold = 0;
e_sigma_threshold = 0;
f_sigma_threshold = 0;
g_sigma_threshold = 0;
h_sigma_threshold = 0;
j_sigma_threshold = 0;
k_sigma_threshold = 0;

for i = 2:100
    if a_sigma_threshold == 0 && length(find(a_sigma_bool(i:100))) == 100 - i + 1
        a_sigma_threshold = a_sigma(i);
    end
    if b_sigma_threshold == 0 && length(find(b_sigma_bool(i:100))) == 100 - i + 1
        b_sigma_threshold = b_sigma(i);
    end
    if c_sigma_threshold == 0 && length(find(c_sigma_bool(i:100))) == 100 - i + 1
        c_sigma_threshold = c_sigma(i);
    end
    if d_sigma_threshold == 0 && length(find(d_sigma_bool(i:100))) == 100 - i + 1
        d_sigma_threshold = d_sigma(i);
    end
    if e_sigma_threshold == 0 && length(find(e_sigma_bool(i:100))) == 100 - i + 1
        e_sigma_threshold = e_sigma(i);
    end
    if f_sigma_threshold == 0 && length(find(f_sigma_bool(i:100))) == 100 - i + 1
        f_sigma_threshold = f_sigma(i);
    end
    if g_sigma_threshold == 0 && length(find(g_sigma_bool(i:100))) == 100 - i + 1
        g_sigma_threshold = g_sigma(i);
    end
    if h_sigma_threshold == 0 && length(find(h_sigma_bool(i:100))) == 100 - i + 1
        h_sigma_threshold = h_sigma(i);
    end
    if j_sigma_threshold == 0 && length(find(j_sigma_bool(i:100))) == 100 - i + 1
        j_sigma_threshold = j_sigma(i);
    end
    if k_sigma_threshold == 0 && length(find(k_sigma_bool(i:100))) == 100 - i + 1
        k_sigma_threshold = k_sigma(i);
    end
end

array = [a_sigma_threshold, b_sigma_threshold, c_sigma_threshold, d_sigma_threshold, e_sigma_threshold, f_sigma_threshold, g_sigma_threshold, h_sigma_threshold, j_sigma_threshold, k_sigma_threshold];
sigma_threshold = mean(array(find(array ~= 0)));
%[~, centroid] = kmeans(array(find(array ~= 0))', 2);
% if centroid(1) < centroid(2)
%     sigma_threshold = centroid(1);
% else
%     sigma_threshold = centroid(2);
% end
%% Find threshold for epsilon_max
a_epsilon_max_bool = zeros(1, 100);
b_epsilon_max_bool = zeros(1, 100);
c_epsilon_max_bool = zeros(1, 100);
d_epsilon_max_bool = zeros(1, 100);
e_epsilon_max_bool = zeros(1, 100);
f_epsilon_max_bool = zeros(1, 100);
g_epsilon_max_bool = zeros(1, 100);
h_epsilon_max_bool = zeros(1, 100);
j_epsilon_max_bool = zeros(1, 100);
k_epsilon_max_bool = zeros(1, 100);
for i = 2:100
    if a_epsilon_max(i - 1) - a_epsilon_max(i) < 10^(epsilon_max_d - 1)
        a_epsilon_max_bool(i) = 1;
    end
    if b_epsilon_max(i - 1) - b_epsilon_max(i) < 10^(epsilon_max_d - 1)
        b_epsilon_max_bool(i) = 1;
    end
    if c_epsilon_max(i - 1) - c_epsilon_max(i) < 10^(epsilon_max_d - 1)
        c_epsilon_max_bool(i) = 1;
    end
    if d_epsilon_max(i - 1) - d_epsilon_max(i) < 10^(epsilon_max_d - 1)
        d_epsilon_max_bool(i) = 1;
    end
    if e_epsilon_max(i - 1) - e_epsilon_max(i) < 10^(epsilon_max_d - 1)
        e_epsilon_max_bool(i) = 1;
    end
    if f_epsilon_max(i - 1) - f_epsilon_max(i) < 10^(epsilon_max_d - 1)
        f_epsilon_max_bool(i) = 1;
    end
    if g_epsilon_max(i - 1) - g_epsilon_max(i) < 10^(epsilon_max_d - 1)
        g_epsilon_max_bool(i) = 1;
    end
    if h_epsilon_max(i - 1) - h_epsilon_max(i) < 10^(epsilon_max_d - 1)
        h_epsilon_max_bool(i) = 1;
    end
    if j_epsilon_max(i - 1) - j_epsilon_max(i) < 10^(epsilon_max_d - 1)
        j_epsilon_max_bool(i) = 1;
    end
    if k_epsilon_max(i - 1) - k_epsilon_max(i) < 10^(epsilon_max_d - 1)
        k_epsilon_max_bool(i) = 1;
    end
end

a_epsilon_max_threshold = 0;
b_epsilon_max_threshold = 0;
c_epsilon_max_threshold = 0;
d_epsilon_max_threshold = 0;
e_epsilon_max_threshold = 0;
f_epsilon_max_threshold = 0;
g_epsilon_max_threshold = 0;
h_epsilon_max_threshold = 0;
j_epsilon_max_threshold = 0;
k_epsilon_max_threshold = 0;

for i = 2:100
    if a_epsilon_max_threshold == 0 && length(find(a_epsilon_max_bool(i:100))) == 100 - i + 1
        a_epsilon_max_threshold = a_epsilon_max(i);
    end
    if b_epsilon_max_threshold == 0 && length(find(b_epsilon_max_bool(i:100))) == 100 - i + 1
        b_epsilon_max_threshold = b_epsilon_max(i);
    end
    if c_epsilon_max_threshold == 0 && length(find(c_epsilon_max_bool(i:100))) == 100 - i + 1
        c_epsilon_max_threshold = c_epsilon_max(i);
    end
    if d_epsilon_max_threshold == 0 && length(find(d_epsilon_max_bool(i:100))) == 100 - i + 1
        d_epsilon_max_threshold = d_epsilon_max(i);
    end
    if e_epsilon_max_threshold == 0 && length(find(e_epsilon_max_bool(i:100))) == 100 - i + 1
        e_epsilon_max_threshold = e_epsilon_max(i);
    end
    if f_epsilon_max_threshold == 0 && length(find(f_epsilon_max_bool(i:100))) == 100 - i + 1
        f_epsilon_max_threshold = f_epsilon_max(i);
    end
    if g_epsilon_max_threshold == 0 && length(find(g_epsilon_max_bool(i:100))) == 100 - i + 1
        g_epsilon_max_threshold = g_epsilon_max(i);
    end
    if h_epsilon_max_threshold == 0 && length(find(h_epsilon_max_bool(i:100))) == 100 - i + 1
        h_epsilon_max_threshold = h_epsilon_max(i);
    end
    if j_epsilon_max_threshold == 0 && length(find(j_epsilon_max_bool(i:100))) == 100 - i + 1
        j_epsilon_max_threshold = j_epsilon_max(i);
    end
    if k_epsilon_max_threshold == 0 && length(find(k_epsilon_max_bool(i:100))) == 100 - i + 1
        k_epsilon_max_threshold = k_epsilon_max(i);
    end
end

array = [a_epsilon_max_threshold, b_epsilon_max_threshold, c_epsilon_max_threshold, d_epsilon_max_threshold, e_epsilon_max_threshold, f_epsilon_max_threshold, g_epsilon_max_threshold, h_epsilon_max_threshold, j_epsilon_max_threshold, k_epsilon_max_threshold];
epsilon_max_threshold = mean(array(find(array ~= 0)));
% [~, centroid] = kmeans(array(find(array ~= 0))', 2);
% if centroid(1) < centroid(2)
%     epsilon_max_threshold = centroid(1);
% else
%     epsilon_max_threshold = centroid(2);
% end
%% Find threshold for epsilon_avg
a_epsilon_avg_bool = zeros(1, 100);
b_epsilon_avg_bool = zeros(1, 100);
c_epsilon_avg_bool = zeros(1, 100);
d_epsilon_avg_bool = zeros(1, 100);
e_epsilon_avg_bool = zeros(1, 100);
f_epsilon_avg_bool = zeros(1, 100);
g_epsilon_avg_bool = zeros(1, 100);
h_epsilon_avg_bool = zeros(1, 100);
j_epsilon_avg_bool = zeros(1, 100);
k_epsilon_avg_bool = zeros(1, 100);
for i = 2:100
    if a_epsilon_avg(i - 1) - a_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        a_epsilon_avg_bool(i) = 1;
    end
    if b_epsilon_avg(i - 1) - b_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        b_epsilon_avg_bool(i) = 1;
    end
    if c_epsilon_avg(i - 1) - c_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        c_epsilon_avg_bool(i) = 1;
    end
    if d_epsilon_avg(i - 1) - d_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        d_epsilon_avg_bool(i) = 1;
    end
    if e_epsilon_avg(i - 1) - e_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        e_epsilon_avg_bool(i) = 1;
    end
    if f_epsilon_avg(i - 1) - f_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        f_epsilon_avg_bool(i) = 1;
    end
    if g_epsilon_avg(i - 1) - g_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        g_epsilon_avg_bool(i) = 1;
    end
    if h_epsilon_avg(i - 1) - h_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        h_epsilon_avg_bool(i) = 1;
    end
    if j_epsilon_avg(i - 1) - j_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        j_epsilon_avg_bool(i) = 1;
    end
    if k_epsilon_avg(i - 1) - k_epsilon_avg(i) < 10^(epsilon_avg_d - 1)
        k_epsilon_avg_bool(i) = 1;
    end
end

a_epsilon_avg_threshold = 0;
b_epsilon_avg_threshold = 0;
c_epsilon_avg_threshold = 0;
d_epsilon_avg_threshold = 0;
e_epsilon_avg_threshold = 0;
f_epsilon_avg_threshold = 0;
g_epsilon_avg_threshold = 0;
h_epsilon_avg_threshold = 0;
j_epsilon_avg_threshold = 0;
k_epsilon_avg_threshold = 0;

for i = 2:100
    if a_epsilon_avg_threshold == 0 && length(find(a_epsilon_avg_bool(i:100))) == 100 - i + 1
        a_epsilon_avg_threshold = a_epsilon_avg(i);
    end
    if b_epsilon_avg_threshold == 0 && length(find(b_epsilon_avg_bool(i:100))) == 100 - i + 1
        b_epsilon_avg_threshold = b_epsilon_avg(i);
    end
    if c_epsilon_avg_threshold == 0 && length(find(c_epsilon_avg_bool(i:100))) == 100 - i + 1
        c_epsilon_avg_threshold = c_epsilon_avg(i);
    end
    if d_epsilon_avg_threshold == 0 && length(find(d_epsilon_avg_bool(i:100))) == 100 - i + 1
        d_epsilon_avg_threshold = d_epsilon_avg(i);
    end
    if e_epsilon_avg_threshold == 0 && length(find(e_epsilon_avg_bool(i:100))) == 100 - i + 1
        e_epsilon_avg_threshold = e_epsilon_avg(i);
    end
    if f_epsilon_avg_threshold == 0 && length(find(f_epsilon_avg_bool(i:100))) == 100 - i + 1
        f_epsilon_avg_threshold = f_epsilon_avg(i);
    end
    if g_epsilon_avg_threshold == 0 && length(find(g_epsilon_avg_bool(i:100))) == 100 - i + 1
        g_epsilon_avg_threshold = g_epsilon_avg(i);
    end
    if h_epsilon_avg_threshold == 0 && length(find(h_epsilon_avg_bool(i:100))) == 100 - i + 1
        h_epsilon_avg_threshold = h_epsilon_avg(i);
    end
    if j_epsilon_avg_threshold == 0 && length(find(j_epsilon_avg_bool(i:100))) == 100 - i + 1
        j_epsilon_avg_threshold = j_epsilon_avg(i);
    end
    if k_epsilon_avg_threshold == 0 && length(find(k_epsilon_avg_bool(i:100))) == 100 - i + 1
        k_epsilon_avg_threshold = k_epsilon_avg(i);
    end
end

array = [a_epsilon_avg_threshold, b_epsilon_avg_threshold, c_epsilon_avg_threshold, d_epsilon_avg_threshold, e_epsilon_avg_threshold, f_epsilon_avg_threshold, g_epsilon_avg_threshold, h_epsilon_avg_threshold, j_epsilon_avg_threshold, k_epsilon_avg_threshold];
epsilon_avg_threshold = mean(array(find(array ~= 0)));
% [~, centroid] = kmeans(array(find(array ~= 0))', 2);
% if centroid(1) < centroid(2)
%     epsilon_avg_threshold = centroid(1);
% else
%     epsilon_avg_threshold = centroid(2);
% end
%% Plot
figure 
hold on
plot(1:100, a_sigma)
plot(1:100, b_sigma)
plot(1:100, c_sigma)
plot(1:100, d_sigma)
plot(1:100, e_sigma)
plot(1:100, f_sigma)
plot(1:100, g_sigma)
plot(1:100, h_sigma)
plot(1:100, j_sigma)
plot(1:100, k_sigma)
yline(sigma_threshold, ':r', 'LineWidth', 2)
title('Sigma')

figure 
hold on
plot(1:100, a_epsilon_max)
plot(1:100, b_epsilon_max)
plot(1:100, c_epsilon_max)
plot(1:100, d_epsilon_max)
plot(1:100, e_epsilon_max)
plot(1:100, f_epsilon_max)
plot(1:100, g_epsilon_max)
plot(1:100, h_epsilon_max)
plot(1:100, j_epsilon_max)
plot(1:100, k_epsilon_max)
yline(epsilon_max_threshold, ':r', 'LineWidth', 2)
title('Epsilon_{max}')

figure 
hold on
plot(1:100, a_epsilon_avg)
plot(1:100, b_epsilon_avg)
plot(1:100, c_epsilon_avg)
plot(1:100, d_epsilon_avg)
plot(1:100, e_epsilon_avg)
plot(1:100, f_epsilon_avg)
plot(1:100, g_epsilon_avg)
plot(1:100, h_epsilon_avg)
plot(1:100, j_epsilon_avg)
plot(1:100, k_epsilon_avg)
yline(epsilon_avg_threshold, ':r', 'LineWidth', 2)
title('Epsilon_{avg}')

%% Find the number of iterations which the conditions should be satisfied for termination
a_terminate = zeros(1, 151);
b_terminate = zeros(1, 151);
c_terminate = zeros(1, 151);
d_terminate = zeros(1, 151);
e_terminate = zeros(1, 151);
f_terminate = zeros(1, 151);
g_terminate = zeros(1, 151);
h_terminate = zeros(1, 151);
j_terminate = zeros(1, 151);
k_terminate = zeros(1, 151);
for i = 2:100
    if (a_sigma(i) < sigma_threshold || a_epsilon_max(i) < epsilon_max_threshold || a_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (a_epsilon_avg(i) / a_epsilon_avg(i-1)) && (a_epsilon_avg(i) / a_epsilon_avg(i-1)) <= 1
        a_terminate(i) = 1;
    end
    if (b_sigma(i) < sigma_threshold || b_epsilon_max(i) < epsilon_max_threshold || b_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (b_epsilon_avg(i) / b_epsilon_avg(i-1)) && (b_epsilon_avg(i) / b_epsilon_avg(i-1)) <= 1
        b_terminate(i) = 1;
    end
    if (c_sigma(i) < sigma_threshold || c_epsilon_max(i) < epsilon_max_threshold || c_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (c_epsilon_avg(i) / c_epsilon_avg(i-1)) && (c_epsilon_avg(i) / c_epsilon_avg(i-1)) <= 1
        c_terminate(i) = 1;
    end
    if (d_sigma(i) < sigma_threshold || d_epsilon_max(i) < epsilon_max_threshold || d_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (d_epsilon_avg(i) / d_epsilon_avg(i-1)) && (d_epsilon_avg(i) / d_epsilon_avg(i-1)) <= 1
        d_terminate(i) = 1;
    end
    if (e_sigma(i) < sigma_threshold || e_epsilon_max(i) < epsilon_max_threshold || e_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (e_epsilon_avg(i) / e_epsilon_avg(i-1)) && (e_epsilon_avg(i) / e_epsilon_avg(i-1)) <= 1
        e_terminate(i) = 1;
    end
    if (f_sigma(i) < sigma_threshold || f_epsilon_max(i) < epsilon_max_threshold || f_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (f_epsilon_avg(i) / f_epsilon_avg(i-1)) && (f_epsilon_avg(i) / f_epsilon_avg(i-1)) <= 1
        f_terminate(i) = 1;
    end
    if (g_sigma(i) < sigma_threshold || g_epsilon_max(i) < epsilon_max_threshold || g_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (g_epsilon_avg(i) / g_epsilon_avg(i-1)) && (g_epsilon_avg(i) / g_epsilon_avg(i-1)) <= 1
        g_terminate(i) = 1;
    end
    if (h_sigma(i) < sigma_threshold || h_epsilon_max(i) < epsilon_max_threshold || h_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (h_epsilon_avg(i) / h_epsilon_avg(i-1)) && (h_epsilon_avg(i) / h_epsilon_avg(i-1)) <= 1
        h_terminate(i) = 1;
    end
    if (j_sigma(i) < sigma_threshold || j_epsilon_max(i) < epsilon_max_threshold || j_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (j_epsilon_avg(i) / j_epsilon_avg(i-1)) && (j_epsilon_avg(i) / j_epsilon_avg(i-1)) <= 1
        j_terminate(i) = 1;
    end
    if (k_sigma(i) < sigma_threshold || k_epsilon_max(i) < epsilon_max_threshold || k_epsilon_avg(i) < epsilon_avg_threshold) && ...
        0.95 <= (k_epsilon_avg(i) / k_epsilon_avg(i-1)) && (k_epsilon_avg(i) / k_epsilon_avg(i-1)) <= 1
        k_terminate(i) = 1;
    end
end

a_onset = find(diff(a_terminate) == 1);
a_offset = find(diff(a_terminate) == -1);
a_count = a_offset - a_onset;
b_onset = find(diff(b_terminate) == 1);
b_offset = find(diff(b_terminate) == -1);
b_count = b_offset - b_onset;
c_onset = find(diff(c_terminate) == 1);
c_offset = find(diff(c_terminate) == -1);
c_count = c_offset - c_onset;
d_onset = find(diff(d_terminate) == 1);
d_offset = find(diff(d_terminate) == -1);
d_count = d_offset - d_onset;
e_onset = find(diff(e_terminate) == 1);
e_offset = find(diff(e_terminate) == -1);
e_count = e_offset - e_onset;
f_onset = find(diff(f_terminate) == 1);
f_offset = find(diff(f_terminate) == -1);
f_count = f_offset - f_onset;
g_onset = find(diff(g_terminate) == 1);
g_offset = find(diff(g_terminate) == -1);
g_count = g_offset - g_onset;
h_onset = find(diff(h_terminate) == 1);
h_offset = find(diff(h_terminate) == -1);
h_count = h_offset - h_onset;
j_onset = find(diff(j_terminate) == 1);
j_offset = find(diff(j_terminate) == -1);
j_count = j_offset - j_onset;
k_onset = find(diff(k_terminate) == 1);
k_offset = find(diff(k_terminate) == -1);
k_count = k_offset - k_onset;

n = max([a_count(1:length(a_count) - 1) b_count(1:length(b_count) - 1) c_count(1:length(c_count) - 1) d_count(1:length(d_count) - 1) e_count(1:length(e_count) - 1) f_count(1:length(f_count) - 1) g_count(1:length(g_count) - 1) h_count(1:length(h_count) - 1) j_count(1:length(j_count) - 1) k_count(1:length(k_count) - 1)]);