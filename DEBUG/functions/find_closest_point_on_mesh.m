function [c, idx] = find_closest_point_on_mesh (bound, c_prev, a, v_set, triangle_v_set, idx)
    node_set = [];
    adj_m = zeros(size(triangle_v_set, 1));

    for i = 1 : size(triangle_v_set, 1)
        ind_1 = triangle_v_set(i, 1) + 1;
        ind_2 = triangle_v_set(i, 2) + 1;
        ind_3 = triangle_v_set(i, 3) + 1;
        point = find_closest_point_on_triangle(a, v_set(ind_1), v_set(ind_2), v_set(ind_3));
        if bound >= norm(point - a)
            [node_set, adj_m] = insert(node_set, adj_m, point, i);
        end
    end
    
    if isempty(node_set)
        c = c_prev;
    else
        node = nearest_neighbor(node_set, adj_m, 1, a);
        c = Vector(node(1), node(2), node(3));
        idx = node(6);
    end
end

% Insert a node into the tree 
function [node_set, adj_m] = insert(node_set, adj_m, vec, idx)
    % add vec as an x-aligned node if tree is empty
    if isempty(node_set)
        node_set = [node_set [vec.value;0;idx]];
    else
        % find the position where vec should be inserted in the
        % tree
        i = 1;
        while i <= length(node_set)
            node = node_set(:, i);

            % 1 = 'x', 2 = 'y', 3 = 'z'
            aligned = mod(node(5), 3) + 1;   

            if vec.value(aligned) < node(aligned)
                % left
                [i, node_set, adj_m] = add_or_traverse(i, node_set, adj_m, 'l', vec, node, idx);
                if ~i
                    break;
                end
            else
                % right
                [i, node_set, adj_m] = add_or_traverse(i, node_set, adj_m, 'r', vec, node, idx);
                if ~i
                    break;
                end
            end
        end
    end
end

function ind = node_exist(i, adj_m, direction)
    ind = find(adj_m(i, :) == direction, 1);
    if isempty(ind)
        ind = 0;
    end
end

function [ind, node_set, adj_m] = add_or_traverse(i, node_set, adj_m, direction, vec, curr, idx)
    ind = node_exist(i, adj_m, direction);
    if ~ind
        % if there isn't a node in the direction where the traverse should be
        % done, add vec to tree
        adj_m(i, size(node_set, 2) + 1) = direction;
        node_set = [node_set [vec.value; mod(curr(5) + 1, 3); idx]];
    end
end

function best_node = nearest_neighbor(node_set, adj_m, i, a)
    if i == 0
        best_node = [];
    else           
        curr_node = node_set(:, i);

        % 1 = 'x', 2 = 'y', 3 = 'z'
        aligned = mod(curr_node(5), 3) + 1;

        if a.value(aligned) < curr_node(aligned)
            next_node_ind = node_exist(i, adj_m, 'l');
            other_node_ind = node_exist(i, adj_m, 'r');
        else
            next_node_ind = node_exist(i, adj_m, 'r');
            other_node_ind = node_exist(i, adj_m, 'l');
        end

        temp_node = nearest_neighbor(node_set, adj_m, next_node_ind, a);
        best_node = closest(temp_node, curr_node, a);

        radius = norm(a.value(1:3) - best_node(1:3));

        dist = abs(a.value(aligned) - curr_node(aligned));

        if radius >= dist
            temp_node = nearest_neighbor(node_set, adj_m, other_node_ind, a);
            best_node = closest(temp_node, best_node, a);
        end
    end
end

% Determine which of the two given node is nearer to the given
% point
function closer_node = closest(node1, node2, a)
    if isempty(node1)
        closer_node = node2;
    elseif isempty(node2)
        closer_node = node1;
    else
        if norm(a.value(1:3) - node1(1:3)) < norm(a.value(1:3) - node2(1:3))
            closer_node = node1;
        else
            closer_node = node2;
        end
    end
end
