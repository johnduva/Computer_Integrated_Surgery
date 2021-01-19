classdef K3Tree
    properties
        node_set
        adjacency_matrix
    end
    
    methods
        % Constructor
        function obj = K3Tree(size)
            obj.adjacency_matrix = zeros(size);
        end
        
        % Insert a node into the tree 
        function tree = insert(tree, vec)
            % add vec as an x-aligned node if tree is empty
            if isempty(tree.node_set)
                tree.node_set = [tree.node_set Node(vec, 0)];
            else
                % find the position where vec should be inserted in the
                % tree
                i = 1;
                while i <= length(tree.node_set)
                    node = tree.node_set(i);
                    
                    % 1 = 'x', 2 = 'y', 3 = 'z'
                    aligned = mod('x' + node.aligned, 3) + 1;   
                    
                    if vec.value(aligned) < node.vec.value(aligned)
                        % left
                        [i, tree] = add_or_traverse(i, tree, 'l', vec);
                        if ~i
                            break;
                        end
                    else
                        % right
                        [i, tree] = add_or_traverse(i, tree, 'r', vec);
                        if ~i
                            break;
                        end
                    end
                end
            end
        end
        
        function ind = node_exist(i, tree, direction)
            ind = find(tree.adjacency_matrix(i, :) == direction, 1);
            if isempty(ind)
                ind = 0;
            end
        end
        
        function [ind, tree] = add_or_traverse(i, tree, direction, vec)
            ind = node_exist(i, tree, direction);
            if ~ind
                % if there isn't a node in the direction where the traverse should be
                % done, add vec to tree
                tree.adjacency_matrix(i, length(tree.node_set) + 1) = direction;
                tree.node_set = [tree.node_set Node(vec, mod(tree.node_set(i).aligned + 1, 3))];
            end
        end
        
        function best_node = nearest_neighbor(tree, i, a)
            if i == 0
                best_node = [];
            else           
                curr_node = tree.node_set(i);

                % 1 = 'x', 2 = 'y', 3 = 'z'
                aligned = mod('x' + curr_node.aligned, 3) + 1;   

                if a.value(aligned) < curr_node.vec.value(aligned)
                    next_node_ind = node_exist(i, tree, 'l');
                    other_node_ind = node_exist(i, tree, 'r');
                else
                    next_node_ind = node_exist(i, tree, 'r');
                    other_node_ind = node_exist(i, tree, 'l');
                end

                temp_node = nearest_neighbor(tree, next_node_ind, a);
                best_node = closest(temp_node, curr_node, a);

                radius = norm(a - best_node.vec);

                dist = abs(a.value(aligned) - curr_node.vec.value(aligned));

                if radius >= dist
                    temp_node = nearest_neighbor(tree, other_node_ind, a);
                    best_node = closest(temp_node, best_node, a);
                end
            end
        end
    end
end

