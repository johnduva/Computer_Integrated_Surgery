classdef Frame
    properties
        type = 'F';
        % 4x4 matrix
        value
    end
    
    methods (Access = private)
        
        function result = frame_times_vec(frame, vec)
            product = frame.value * vec.value;
            result = Vector(product(1), product(2), product(3));
        end
    end
    
    methods
        % Constructor
        function obj = Frame(param_rot, param_p)
            if exist('param_rot', 'var') && exist('param_p', 'var')
                obj.value = [[param_rot.value; 0 0 0] param_p.value];
            end
        end
        
        % '*' operator overload
        function result = mtimes(obj1, obj2)
            if obj1.type == 'F' && obj2.type == 'F'
                % Compute F * F
                obj = Frame;
                obj.value = obj1.value * obj2.value;
                result = obj;
            elseif obj1.type == 'F' && obj2.type == 'V'
                % Compute a vector transformed by the given frame
                product = obj1.value * obj2.value;
                result = Vector(product(1), product(2), product(3));
            else
                error('Undefined operation');
            end
        end
        
        % Compute the inverse of a frame
        function result = inv(frame)
            obj = Frame;
            obj.value = inv(frame.value);
            result = obj;
        end
    end
end