%% Function for computing the set of frame that transforms a to each observed b
function frame_set = find_frame_transformation(a, b)
    [num_frame, ~] = size(b);

    frame_set = [];
    for i = 1:num_frame
        frame_set = [frame_set registration3dTo3d(a, b(i, :))];
    end
end
