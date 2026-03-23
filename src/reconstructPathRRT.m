function path = reconstructPathRRT(nodes, parents, goalIdx)
% RECONSTRUCTPATHRRT Reconstructs path from goal to root using parent array.

    path = nodes(goalIdx, :);
    current = goalIdx;

    while parents(current) ~= 0
        current = parents(current);
        path = [nodes(current, :); path]; %#ok<AGROW>
    end
end