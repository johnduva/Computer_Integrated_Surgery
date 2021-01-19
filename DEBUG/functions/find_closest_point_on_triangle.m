function c = find_closest_point_on_triangle(a, p, q, r)
    c = Vector;
    % Construct A
    A = [q.value - p.value, r.value - p.value];
    
    % Construct b
    b = a.value - p.value;
    
    % Set up the least squares problem and solve it
    x = A\b;
    
    c.value = [p.value + x(1) * (q.value - p.value) + x(2) * (r.value - p.value)];
    
    if x(1) < 0
        c.value = project_on_segment(c, r, p);
    elseif x(2) < 0
        c.value = project_on_segment(c, p, q);
    elseif (x(1) + x(2)) > 1
        c.value = project_on_segment(c, q, r);
    end
end

function x = project_on_segment(c, p, q)
    lambda = dot(c.value - p.value, q.value - p.value) / dot(q.value - p.value, q.value - p.value);
    seg_lambda = max(0, min(lambda, 1));
    x = p.value + seg_lambda .* (q.value - p.value);
end