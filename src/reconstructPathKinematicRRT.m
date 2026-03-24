function path = reconstructPathKinematicRRT(nodes, parents, edgeTraj, goalIdx)
% RECONSTRUCTPATHKINEMATICRRT Reconstructs the full path from root to goal.
%
% Inputs:
%   nodes    : Nx4 matrix of nodes
%   parents  : Nx1 parent indices
%   edgeTraj : cell array, edgeTraj{i} is the trajectory from parent(i) to node i
%   goalIdx  : index of final node
%
% Output:
%   path     : Mx4 full state trajectory

    sequence = [];
    current = goalIdx;

    while current ~= 1
        sequence = [current sequence]; %#ok<AGROW>
        current = parents(current);
    end
    sequence = [1 sequence];

    path = nodes(1, :);

    for k = 2:length(sequence)
        idx = sequence(k);
        localTraj = edgeTraj{idx};

        % avoid repeating the first point
        path = [path; localTraj(2:end, :)]; %#ok<AGROW>
    end
end