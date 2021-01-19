classdef Rotation
    properties
        type = 'R';
        % 3x3 rotation matrix
        value
    end
    
    methods
        % Constructor
        function obj = Rotation(param_axis, param_angle)
            if exist('param_axis', 'var') && exist('param_angle', 'var')
                if lower(param_axis) == 'x'
                    obj.value = [1 0 0; 0 cos(param_angle) -sin(param_angle); 0 sin(param_angle) cos(param_angle)];
                elseif lower(param_axis) == 'y'
                    obj.value = [cos(param_angle) 0 sin(param_angle); 0 1 0; -sin(param_angle) 0 cos(param_angle)];
                elseif lower(param_axis) == 'z'
                    obj.value = [cos(param_angle) -sin(param_angle) 0; sin(param_angle) cos(param_angle) 0; 0 0 1];
                else
                    error('Invalid parameter for axis');
                end
            end
        end
        
        % '*' operator overload
        function result = mtimes(obj1, obj2)
            if obj1.type == 'R' && obj2.type == 'R'
                % Computed R * R
                obj = Rotation;
                obj.value = obj1.value * obj2.value;
                result = obj;
            elseif obj1.type == 'R' && obj2.type == 'V'
                % Compute a rotated vector
                product = [obj1.value [0;0;0]; 0 0 0 1] * [obj2.value];
                result = Vector(product(1), product(2), product(3));
            else
                error('Undefined operation');
            end
            
        end
        
        % Compute the inverse of a rotation matrix
        function result = inv(rot)
            obj = Rotation;
            obj.value = inv(rot.value);
            result = obj;
        end
    end
end