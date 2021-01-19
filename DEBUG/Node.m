classdef Node
    properties
        vec
        aligned
    end
    
    methods
        % Constructor
        function obj = Node(v, x)
            obj.vec = v;
            obj.aligned = x;
        end
        
                
        % Determine which of the two given node is nearer to the given
        % point
        function closer_node = closest(node1, node2, a)
            if isempty(node1)
                closer_node = node2;
            elseif isempty(node2)
                closer_node = node1;
            elseif norm(a - node1.vec) < norm(a - node2.vec)
                closer_node = node1;
            else
                closer_node = node2;
            end
        end
    end
end