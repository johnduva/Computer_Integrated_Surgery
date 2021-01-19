classdef Vector
    properties
        type = 'V';
        % 4x1 vector
        value
    end
    
    methods
        % Constructor
        function obj = Vector(param_x, param_y, param_z)
            if exist('param_x','var') && exist('param_y','var') && exist('param_z','var')
                obj.value = [param_x;param_y;param_z;1];
            end
        end
        
        % Compute the dot product of two vectors
        function result = dot(obj1, obj2)
            result = obj1.value(1) * obj2.value(1) + obj1.value(2) * obj2.value(2) + obj1.value(3) * obj2.value(3);
        end
        
        % Compute the norm of the vector 
        function result = norm(obj)
            result = norm([obj.value(1); obj.value(2); obj.value(3)]);
        end
        
        % Compute the average of all vectors in a given set
        function obj = avg(set)
            [~, num_vec] = size(set);
            obj = Vector;
            obj.value = set(1).value;
            
            for i = 2:num_vec
                obj = obj + set(i);
            end
            
            obj.value = [obj.value(1:3) / num_vec; 1];
        end
        
        % Return the vectors with the maximum individual components in a given set
        function obj = max(set)
            [~, num_vec] = size(set);
            x = set(1).value(1);
            y = set(1).value(2);
            z = set(1).value(3);
            
            for i = 2:num_vec
                if x < set(i).value(1)
                    x = set(i).value(1);
                end
                if y < set(i).value(2)
                    y = set(i).value(2);
                end
                if z < set(i).value(3)
                    z = set(i).value(3);
                end
            end
            
            obj = Vector(x, y, z);
        end
        
        % Return the vectors with the maximum individual components in a given set
        function obj = min(set)
            [~, num_vec] = size(set);
            x = set(1).value(1);
            y = set(1).value(2);
            z = set(1).value(3);
            
            for i = 2:num_vec
                if x > set(i).value(1)
                    x = set(i).value(1);
                end
                if y > set(i).value(2)
                    y = set(i).value(2);
                end
                if z > set(i).value(3)
                    z = set(i).value(3);
                end
            end
            
            obj = Vector(x, y, z);
        end
        
        % '*' operator overload
        function result = mtimes(obj1, obj2)
            if isscalar(obj1) && obj2.type == 'V'
                obj = Vector;
                obj.value = [obj2.value(1:3) .* obj1; 1];
                result = obj;
            elseif obj1.type == 'V' && obj2.type == 'R'
                % Construct a frame
                result = Frame(obj2, obj1);
            elseif obj1.type == 'V' && obj2.type == 'V'
                % Compute the sum of 2 vectors
                obj = Vector;
                obj.value = [[eye(3);0 0 0] obj2.value] * obj1.value;
                result = obj;
            else
                error('Undefined operation');
            end
        end
        
        % '+' operator overload
        function result = plus(obj1, obj2)
            if obj1.type == 'V' && obj2.type == 'V'
                % Compute the sum of 2 vectors
                obj = Vector;
                obj.value = [[eye(3);0 0 0] obj2.value] * obj1.value;
                result = obj;
            else
                error('Undefined operation');
            end
        end
        
        % '-' operator overload
        function result = minus(obj1, obj2)
            % Compute the difference between 2 vectors
            if obj1.type == 'V' && obj2.type == 'V'
                obj = Vector;
                obj.value = obj1.value - obj2.value;
                obj.value(4) = 1;
                result = obj;
            else
                error('Undefined operation');
            end
        end
        
        % '/' operator overload
        function obj = mrdivide(obj1, obj2)
            if obj1.type == 'V' && obj2.type == 'V'
                x = obj1.value(1) / obj2.value(1);
                y = obj1.value(2) / obj2.value(2);
                z = obj1.value(3) / obj2.value(3);
                obj = Vector(x, y, z);
            else
                error('Undefined operation');
            end
        end
        
        % isscalar() overload
        function result = isscalar(obj)
            result = 0;
        end
        
    end
end

