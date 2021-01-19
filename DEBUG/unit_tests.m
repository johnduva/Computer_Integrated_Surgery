warning('off', 'all');
clear all
%% Vector Class functions
fprintf("Testing Vector Class functions... ");
passed = 1;

vec1 = Vector(0, 0, 0);
vec2 = Vector(1, 2, 3);
vec3 = Vector(4, 5, 6);

% Constructor
if vec1.value ~= [0; 0; 0; 1]
    passed = 0;
elseif vec2.value ~= [1; 2; 3; 1]
    passed = 0;
elseif vec3.value ~= [4; 5; 6; 1]
    passed = 0;
end

% Dot product
if dot(vec1, vec2) ~= 0
    passed = 0;
elseif dot(vec2, vec2) ~= 14
    passed = 0;
elseif dot(vec2, vec3) ~= 32
    passed = 0;
end

% Average of a set of Vector
if avg([vec1, vec2]).value ~= Vector(0.5, 1, 1.5).value
    passed = 0;
elseif avg([vec3, vec2]).value ~= Vector(2.5, 3.5, 4.5).value
    passed = 0;
elseif avg([vec1, vec3]).value ~= Vector(2, 2.5, 3).value
    passed = 0;
elseif avg([vec1, vec2, vec3]).value ~= Vector(2.5, 3.5, 4.5).value
    passed = 0;
end

% Max
vec4 = Vector(1, 9, 0);
if max([vec1, vec2]).value ~= vec2.value
    passed = 0;
elseif max([vec3, vec2]).value ~= max([vec1, vec2, vec3]).value
    passed = 0;
elseif max([vec1, vec3]).value ~= vec3.value
    passed = 0;
elseif max([vec2, vec3, vec4]).value ~= [4; 9; 6; 1]
    passed = 0;
end

% Min
if min([vec1, vec2]).value ~= vec1.value
    passed = 0;
elseif min([vec3, vec2]).value ~= min([vec1, vec2, vec3]).value
    passed = 0;
elseif min([vec1, vec3]).value ~= vec1.value
    passed = 0;
elseif min([vec2, vec3, vec4]).value ~= [0; 3; 1; 1]
    passed = 0;
end

% Addition '*'
vec = vec1*vec2;
if vec.value ~= vec2.value
    passed = 0;
end
vec = vec1*vec3;
if vec.value ~= vec3.value
    passed = 0;
end
vec = vec2*vec3;
if vec.value ~= Vector(5, 7, 9).value
    passed = 0;
end
vec = vec1*vec2*vec3;
if vec.value ~= Vector(5, 7, 9).value
    passed = 0;
end

% Addition '+'
vec = vec1+vec2;
if vec.value ~= vec2.value
    passed = 0;
end
vec = vec1+vec3;
if vec.value ~= vec3.value
    passed = 0;
end
vec = vec2+vec3;
if vec.value ~= Vector(5, 7, 9).value
    passed = 0;
end
vec = vec1+vec2+vec3;
if vec.value ~= Vector(5, 7, 9).value
    passed = 0;
end

% Subtraction '-'
vec = vec1-vec2;
if vec.value ~= -vec2.value
    passed = 0;
end
vec = vec3-vec1;
if vec.value ~= vec3.value
    passed = 0;
end
vec = vec3-vec2;
if vec.value ~= Vector(3, 3, 3).value
    passed = 0;
end
vec = vec2-vec2;
if vec.value ~= vec1.value
    passed = 0;
end

% Divide by component
vec = vec1*Vector(1, 1, 1);
if vec.value ~= vec1.value
    passed = 0;
end
vec = vec2*Vector(2, 1, 2);
if vec.value ~= [1; 3; 2; 1]
    passed = 0;
end

% Create frame '*'
R1 = Rotation('x', pi);
F1 = vec1*R1;
if F1.value - [1 0 0 0;0 -1 0 0; 0 0 -1 0; 0 0 0 1] > 0.01
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end
%% Rotation Class functions
fprintf("Testing Rotation Class functions... ");
passed = 1;

R1 = Rotation('x', pi);
R2 = Rotation('y', pi);
R3 = Rotation('z', pi);
R4 = Rotation('x', pi/2);
R5 = Rotation('y', pi/2);
R6 = Rotation('z', pi/2);

% Constructor
if R1.value - [1 0 0;0 -1 0; 0 0 -1] > 0.01
    passed = 0;
elseif R2.value - [-1 0 0;0 1 0; 0 0 -1] > 0.01
    passed = 0;
elseif R3.value - [-1 0 0;0 -1 0; 0 0 1] > 0.01
    passed = 0;
elseif R4.value - [1 0 0;0 0 -1; 0 1 0] > 0.01
    passed = 0;
elseif R5.value - [0 0 1;0 1 0;-1 0 0] > 0.01
    passed = 0;
elseif R6.value - [0 -1 0;1 0 0;0 0 1] > 0.01
    passed = 0;
end

% Combine rotation '*'
R = R1*R2;
if R.value - [-1 0 0;0 -1 0; 0 0 1] > 0.01
    passed = 0;
end
R = R2*R3;
if R.value - [1 0 0;0 -1 0; 0 0 -1] > 0.01
    passed = 0;
end
R = R4*R5;
if R.value - [0 0 1;1 0 0; 0 1 0] > 0.01
    passed = 0;
end
R = R3*R6*R6;
if R.value - eye(3) > 0.01
    passed = 0;
end

% Rotate a vector '*'
vec = R1*vec2;
if vec.value - [1; -2; -3; 1] > 0.01
    passed = 0;
end
vec = R2*vec3;
if vec.value - [-4; 5; -6; 1] > 0.01
    passed = 0;
end
vec = R6*vec4;
if vec.value - [-9; 1; 0; 1] > 0.01
    passed = 0;
end

% Inverse of rotation
if inv(R4).value - [1 0 0;0 0 1; 0 -1 0] > 0.01
    passed = 0;
elseif inv(R5).value - [0 0 -1;0 1 0;1 0 0] > 0.01
    passed = 0;
elseif inv(R6).value - [0 1 0;-1 0 0;0 0 1] > 0.01
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end
%% Frame Class functions
fprintf("Testing Frame Class functions... ");
passed = 1;

F1 = Frame(R4, vec2);
F2 = Frame(R5, vec3);
F3 = Frame(R6, vec4);

% Constructor
if F1.value - [1 0 0 1;0 0 -1 2; 0 1 0 3; 0 0 0 1] > 0.01
    passed = 0;
elseif F2.value - [0 0 1 4;0 1 0 5; -1 0 0 6;0 0 0 1] > 0.01
    passed = 0;
elseif F3.value - [0 -1 0 1;1 0 0 9; 0 0 0 0; 0 0 0 1] > 0.01
    passed = 0;
end

% Combine frame '*'
F = F1*F2;
if F.value - [0 0 1 5;1 0 0 -4;0 1 0 8; 0 0 0 1] > 0.01
    passed = 0;
end
F = F2*F3;
if F.value - [0 0 1 4;1 0 0 14;0 1 0 5; 0 0 0 1] > 0.01
    passed = 0;
end
F = F1*F3;
if F.value - [0 -1 0 2;0 0 -1 2;1 0 0 12; 0 0 0 1] > 0.01
    passed = 0;
end
F = F1*F1;
if F.value - [1 0 0 2;0 -1 0 -1;0 0 -1 5; 0 0 0 1] > 0.01
    passed = 0;
end

% Transform a vector '*'
vec = F1*vec2;
if vec.value - [2; -1; 5; 1] > 0.01
    passed = 0;
end
vec = F2*vec3;
if vec.value - [10; 10; 2; 1] > 0.01
    passed = 0;
end
vec = F3*vec4;
if vec.value - [-8; 10; 0; 1] > 0.01
    passed = 0;
end

% Inverse of frame
if inv(F1).value - [1 0 0 -1;0 0 1 -3; 0 -1 0 2;0 0 0 1] > 0.01
    passed = 0;
elseif inv(F2).value - [0 0 -1 6;0 1 0 -5; 1 0 0 -4;0 0 0 1] > 0.01
    passed = 0;
elseif inv(F3).value - [0 1 0 -9;-1 0 0 1; 0 0 1 0;0 0 0 1] > 0.01
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end

%% registration3dTo3d
fprintf("Testing registration3dTo3d... ");
passed = 1;

a = Vector(0, 0, 0);
b = Vector(1, 1, 1);
F = registration3dTo3d(a, b);
if F.value ~= [[eye(3); [0 0 0]] [1; 1; 1; 1]]    
    passed = 0;
end

a1 = Vector(0, 0, 0);
a2 = Vector(1, 0, 0);
b1 = a1;
b2 = Vector(0, 1, 0);
F = registration3dTo3d([a1 a2], [b1 b2]);
if sum(F.value - [[0 -1 0; 1 0 0; 0 0 1; 0 0 0] [0; 0; 0; 1]], 'all') > 0.001
    passed = 0;
end

a2 = Vector(1, 0, 0);
b2 = Vector(0, 0, 1);
F = registration3dTo3d([a1 a2], [b1 b2]);
if sum(F.value - [[1 0 0; 0 0 1; 1 0 0; 0 0 0] [0; 0; 0; 1]], 'all') > 0.001
    passed = 0;
end

a2 = Vector(0, 1, 0);
b2 = Vector(0, 0, 1);
F = registration3dTo3d([a1 a2], [b1 b2]);
if sum(F.value - [[0 0 1; 0 -1 0; 1 0 0; 0 0 0] [0; 0; 0; 1]], 'all') > 0.001
    passed = 0;
end

a2 = Vector(0, 1, 0);
b2 = Vector(1, 0, 0);
F = registration3dTo3d([a1 a2], [b1 b2]);
if sum(F.value - [[0 1 0; -1 0 0; 0 0 1; 0 0 0] [0; 0; 0; 1]], 'all') > 0.001
    passed = 0;
end

a2 = Vector(0, 0, 1);
b2 = Vector(1, 0, 0);
F = registration3dTo3d([a1 a2], [b1 b2]);
if sum(F.value - [[0 0 1; 0 -1 0; 1 0 0; 0 0 0] [0; 0; 0; 1]], 'all') > 0.001
    passed = 0;
end

a2 = Vector(0, 0, 1);
b2 = Vector(0, 1, 0);
F = registration3dTo3d([a1 a2], [b1 b2]);
if sum(F.value - [[-1 0 0; 0 0 1; 0 1 0; 0 0 0] [0; 0; 0; 1]], 'all') > 0.001
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end
%% Node Class functions
fprintf("Testing Node Class functions... ");
passed = 1;

% Constructor
node1 = Node(Vector(0, 0, 0), 'x');
if node1.vec.value ~= [0; 0; 0; 1] | node1.aligned ~= 'x'
    passed = 0;
end

node = Node(Vector, 'y');
if node.vec.type ~= 'V' || node.aligned ~= 'y'
    passed = 0;
end

node2 = Node(Vector(0, 1, 2), 'z');
if node2.vec.value ~= [0; 1; 2; 1] | node2.aligned ~= 'z'
    passed = 0;
end

% closest
a = Vector(2, 2, 2);
closest_node = closest(node1, node2, a);
if closest_node.vec.value ~= [0; 1; 2; 1] | closest_node.aligned ~= 'z'
    passed = 0;
end


if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end

%% K3Tree Class functions
fprintf("Testing K3Tree Class functions... ");
passed = 1;

% Constructor
tree = K3Tree(8);
matrix = zeros(8);
if tree.adjacency_matrix ~= matrix
    passed = 0;
end

% Insert root
% [300, 300, 300]
tree = insert(tree, Vector(300, 300, 300));
if length(tree.node_set) ~= 1 || sum(tree.node_set(1).vec.value ~= [300; 300; 300; 1], 'all') ...
        || tree.node_set(1).aligned ~= 0 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% Insert left node to root
% [300, 300, 300]
%       /
% [200, 300, 300]
tree = insert(tree, Vector(200, 300, 300));
matrix(1, 2) = char('l');
if length(tree.node_set) ~= 2 || sum(tree.node_set(2).vec.value ~= [200; 300; 300; 1], 'all') ...
        || tree.node_set(2).aligned ~= 1 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% Insert left node to a left node (depth = 3)
%           [300, 300, 300]
%            /           
%   [200, 300, 300]  
%       /
%  [200, 200, 300]
tree = insert(tree, Vector(200, 200, 300));
matrix(2, 3) = char('l');
if length(tree.node_set) ~= 3 || sum(tree.node_set(3).vec.value ~= [200; 200; 300; 1], 'all') ...
        || tree.node_set(3).aligned ~= 2 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% Insert right node to a left node (depth = 3)
%                 [300, 300, 300]
%                 /           
%          [200, 300, 300]  
%             /       \
%  [200, 200, 300]  [200, 400, 300]
tree = insert(tree, Vector(200, 400, 300));
matrix(2, 4) = char('r');
if length(tree.node_set) ~= 4 || sum(tree.node_set(4).vec.value ~= [200; 400; 300; 1], 'all') ...
        || tree.node_set(4).aligned ~= 2 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% Insert right node to root
%                 [300, 300, 300]
%                 /             \ 
%          [200, 300, 300]      [400, 300, 300]
%             /       \
%  [200, 200, 300]  [200, 400, 300]
tree = insert(tree, Vector(400, 300, 300));
matrix(1, 5) = char('r');
if length(tree.node_set) ~= 5 || sum(tree.node_set(5).vec.value ~= [400; 300; 300; 1], 'all') ...
        || tree.node_set(5).aligned ~= 1 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% Insert right node to a right node (depth = 3)
%                 [300, 300, 300]
%                 /             \ 
%          [200, 300, 300]      [400, 300, 300]
%             /       \                 \
%  [200, 200, 300]  [200, 400, 300]     [400, 400, 300]
tree = insert(tree, Vector(400, 400, 300));
matrix(5, 6) = char('r');
if length(tree.node_set) ~= 6 || sum(tree.node_set(6).vec.value ~= [400; 400; 300; 1], 'all') ...
        || tree.node_set(6).aligned ~= 2 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% Insert left node to a right node (depth = 3)
%                        [300, 300, 300]
%                       /             \ 
%          [200, 300, 300]              [400, 300, 300]
%             /       \                  /            \
%  [200, 200, 300]  [200, 400, 300]  [400, 200, 300] [400, 400, 300]
tree = insert(tree, Vector(400, 200, 300));
matrix(5, 7) = char('l');
if length(tree.node_set) ~= 7 || sum(tree.node_set(7).vec.value ~= [400; 200; 300; 1], 'all') ...
        || tree.node_set(6).aligned ~= 2 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% Insert left node to a left node (depth = 4)
%                        [300, 300, 300]
%                       /             \ 
%          [200, 300, 300]              [400, 300, 300]
%             /       \                  /            \
%  [200, 200, 300]  [200, 400, 300]  [400, 200, 300] [400, 400, 300]
%       /
% [200, 200, 200]
tree = insert(tree, Vector(200, 200, 200));
matrix(3, 8) = char('l');
if length(tree.node_set) ~= 8 || sum(tree.node_set(8).vec.value ~= [200; 200; 200; 1], 'all') ...
        || tree.node_set(8).aligned ~= 0 || sum(tree.adjacency_matrix ~= matrix, 'all')
    passed = 0;
end

% search
a = Vector(200, 200, 200);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [200; 200; 200;1]
    passed = 0;
end

a = Vector(249, 349, 449);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [200; 400; 400; 1]
    passed = 0;
end

a = Vector(450, 250, 300);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [400; 200; 300; 1]
    passed = 0;
end

a = Vector(249, 349, 449);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [200; 400; 400; 1]
    passed = 0;
end

a = Vector(350, 401, 300);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [400; 400; 300; 1]
    passed = 0;
end

a = Vector(200, 170, 220);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [200; 200; 300; 1]
    passed = 0;
end

a = Vector(250, 450, 250);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [200; 400; 300; 1]
    passed = 0;
end

a = Vector(250, 300, 310);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [200; 300; 300; 1]
    passed = 0;
end

a = Vector(410, 250, 290);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [400; 300; 300; 1]
    passed = 0;
end

a = Vector(250, 300, 300);
c = nearest_neighbor(tree, 1, a);
if c.vec.value ~= [300; 300; 300; 1]
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end

%% find_closest_point_on_triangle
fprintf("Testing find_closest_point_on_triangle... ");
passed = 1;

% triangle is a point, and 'a' is at the same coordinates as the point
a = Vector(0, 0, 0);
p = Vector(0, 0, 0);
q = Vector(0, 0, 0);
r = Vector(0, 0, 0);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [0; 0; 0; 1]
    passed = 0;
end

% triangle is a point
p = Vector(1, 0, 0);
q = Vector(1, 0, 0);
r = Vector(1, 0, 0);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [1; 0; 0; 1]
    passed = 0;
end

% point in the middle of the triangle
p = Vector(3, 0, 0);
q = Vector(0, 3, 0);
r = Vector(0, 0, 3);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [1; 1; 1; 1]
    passed = 0;
end

% point in triangle, closer vertex p
p = Vector(3, 0, 0);
q = Vector(0, 6, 0);
r = Vector(0, 0, 6);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [2; 1; 1; 1]
    passed = 0;
end

% point in triangle, closer vertex q
p = Vector(6, 0, 0);
q = Vector(0, 3, 0);
r = Vector(0, 0, 6);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [1; 2; 1; 1]
    passed = 0;
end

% point in triangle, closer vertex r
p = Vector(6, 0, 0);
q = Vector(0, 6, 0);
r = Vector(0, 0, 3);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [1; 1; 2; 1]
    passed = 0;
end

% point at vertex p
p = Vector(3, 0, 0);
q = Vector(3, 3, 0);
r = Vector(3, 0, 3);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [3; 0; 0; 1]
    passed = 0;
end

% point at vertex q
p = Vector(3, 3, 0);
q = Vector(0, 3, 0);
r = Vector(0, 3, 3);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [0; 3; 0; 1]
    passed = 0;
end

% point at vertex r
p = Vector(3, 0, 3);
q = Vector(0, 3, 3);
r = Vector(0, 0, 3);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [0; 0; 3; 1]
    passed = 0;
end

% point on pq
p = Vector(3, 0, 3);
q = Vector(3, 0, -3);
r = Vector(3, 3, 0);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [3; 0; 0; 1]
    passed = 0;
end

% point on pr
p = Vector(3, 3, 0);
q = Vector(0, 3, 3);
r = Vector(-3, 3, 0);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [0; 3; 0; 1]
    passed = 0;
end

% point on qr
p = Vector(3, 0, 3);
q = Vector(0, 3, 3);
r = Vector(0, -3, 3);
c = find_closest_point_on_triangle(a, p, q, r);
if c.value ~= [0; 0; 3; 1]
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end

%% find_closest_point_on_mesh
fprintf("Testing find_closest_point_on_mesh... ");
passed = 1;

% 1 triangle in mesh
v_set = [Vector(3, 0, 0), Vector(0, 3, 0), Vector(0, 0, 3)];
triangle_v_set = [0, 1, 2];
[c, idx] = find_closest_point_on_mesh(intmax, 0, a, v_set, triangle_v_set);
if ~isempty(find(c.value ~= [1; 1; 1; 1])) || idx ~= 1
    passed = 0;
end

% 1 triangle in mesh with a different order of vertex indices
v_set = [Vector(3, 0, 0), Vector(0, 3, 0), Vector(0, 0, 3)];
triangle_v_set = [1, 2, 0];
[c, idx] = find_closest_point_on_mesh(intmax, 0, a, v_set, triangle_v_set);
if ~isempty(find(c.value ~= [1; 1; 1; 1])) || idx ~= 1
    passed = 0;
end

% 2 triangles in mesh (closest point in one of the triangles)
v_set = [Vector(3, 0, 0), Vector(0, 3, 0), Vector(0, 0, 3), Vector(6, 0, 0), Vector(0, 6, 0)];
triangle_v_set = [0, 1, 2; 3, 4, 2];
[c, idx] = find_closest_point_on_mesh(intmax, 0, a, v_set, triangle_v_set);
if ~isempty(find(c.value ~= [1; 1; 1; 1])) || idx ~= 1
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end

%% get_barycentric_coord
fprintf("Testing get_barycentric_coord... ");
passed = 1;

m_s = Vector(1, 1, 1);
m_t = Vector(0, 0, 0);
m_u = Vector(-1, -2, 1);

% if on a vertex
[lambda, mu, v] = get_barycentric_coord(m_s, m_s, m_t, m_u);
if all([lambda, mu, v] ~= [1,0,0])
    passed = 0;
end
[lambda, mu, v] = get_barycentric_coord(m_t, m_s, m_t, m_u);
if all([lambda, mu, v] ~= [0,1,0])
    passed = 0;
end
[lambda, mu, v] = get_barycentric_coord(m_u, m_s, m_t, m_u);
if all([lambda, mu, v] ~= [0,0,1])
    passed = 0;
end
    
% if on an edge (midpoints)
[lambda, mu, v] = get_barycentric_coord( mrdivide(m_s+m_t,Vector(2,2,2)) , m_s, m_t, m_u);
if (lambda - .5 > 0.01) || (mu - .5 > 0.01) || (v - 0 > 0.01)
    passed = 0;
end
[lambda, mu, v] = get_barycentric_coord( mrdivide(m_t+m_u,Vector(2,2,2)) , m_s, m_t, m_u);
if (lambda - 0 > 0.01) || (mu - 0.5 > 0.01) || (v - .5 > 0.01)
    passed = 0;
end
[lambda, mu, v] = get_barycentric_coord( mrdivide(m_u+m_s,Vector(2,2,2)) , m_s, m_t, m_u);
if (lambda - .5 > 0.01) || (mu - 0 > 0.01) || (v - .5 > 0.01)
    passed = 0;
end

% c is inside the triangle    
[lambda, mu, v] = get_barycentric_coord(avg([m_s, m_t, m_u]), m_s, m_t, m_u);
if any([lambda, mu, v] < 0)
    passed = 0;
end

% c is outside the triangle
[lambda, mu, v] = get_barycentric_coord(2*avg([m_s, m_t, m_u]), m_s, m_t, m_u);
if all([lambda, mu, v] > 0)
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end

%% get_deformed_coord
fprintf("Testing get_deformed_coord... ");
passed = 1;

m = [ Vector(1,1,1); Vector(-.1,-.1,-.1); Vector(.1,.1,.1)];

if all( get_deformed_coord(m, 1, [.75; .25]).value(1:3) ~= [.95; .95; .95] )
    passed = 0;
elseif all( get_deformed_coord(m, 1, [.5; .5]).value(1:3) ~= [1; 1; 1] )
    passed = 0;
elseif all( get_deformed_coord(m, 1, [0; 1]).value(1:3) ~= [1.1, 1.1, 1.1] )
    passed = 0;
end

if ~passed
    fprintf("Test(s) failed\n");
else
    fprintf("All tests passed!\n");
end