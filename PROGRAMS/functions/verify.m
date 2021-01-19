function bool = verify(m, v_set, thresh) 
    if ~exist('thresh', 'var')
        thresh = .01;
    end
        
    count = 0;
    for i = 1 : length(m)
        % Confirm all three differences are smaller than 'thresh'
        if all( -thresh < m(1,i).value(1:3) - v_set(1,i).value(1:3) ) ...
                && all( m(1,i).value(1:3) - v_set(1,i).value(1:3) < thresh )
            continue
        else
            disp(['Values are index ', num2str(i), ' are too far from each other.'])
            count = count + 1;
        end
    end

    % Output results
    if count > 0
        disp([num2str(count), ' values are too far.'])
        bool = 0;
    else
        disp([newline,'Vertices of mesh meet similarity requirements.'])
        bool = 1;
    end
end