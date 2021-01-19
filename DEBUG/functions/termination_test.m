%% Function for deciding when to terminate the ICP iterations
function count = termination_test(sigma, epsilon_max, epsilon_avg, n, count)
    SIGMA_THRESHOLD = 0.00025795;
    EPSILON_MAX_THRESHOLD = 0.0105;
    EPSILON_AVG_THRESHOLD = 0.000013279;
    
    if (n~= 0 && n~= 1) && (sigma(n) < SIGMA_THRESHOLD || epsilon_max(n) < EPSILON_MAX_THRESHOLD || epsilon_avg(n) < EPSILON_AVG_THRESHOLD)
        ratio = epsilon_avg(n) / epsilon_avg(n-1);
        if 0.95 <= ratio && ratio <= 1
            count = count + 1;
        end     
    end
    
    if n == 75
        count = 7;
    end
end
