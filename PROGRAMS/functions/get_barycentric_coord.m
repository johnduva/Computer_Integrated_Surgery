function [lambda, mu, v] = get_barycentric_coord(c, m_s, m_t, m_u)
    v0 = m_t - m_s; 
    v1 = m_u - m_s;
    v2 = c - m_s;
    d00 = dot(v0, v0);
    d01 = dot(v0, v1);
    d11 = dot(v1, v1);
    d20 = dot(v2, v0);
    d21 = dot(v2, v1);
    denom = d00 * d11 - d01 * d01;

    % Use vars to get weights
    mu = (d11 * d20 - d01 * d21) / denom;
    v = (d00 * d21 - d01 * d20) / denom;
    lambda = 1 - v - mu;
end
        