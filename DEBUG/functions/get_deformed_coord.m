function [m_new, m_m] = get_deformed_coord(m, vertex, m_lams)
    m_m = [];
    m0 = m(1,vertex).value(1:3);
    for j = 2 : size(m)
        m_m = [m_m; m(j,vertex).value(1:3)'];
    end
    tmp = m0 + sum(m_lams .* m_m)';
    m_new = Vector(tmp(1), tmp(2), tmp(3));
end