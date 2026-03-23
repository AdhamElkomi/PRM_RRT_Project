function [path, pathLengthValue, nodePath] = findPathPRM(nodes, G)
% FINDPATHPRM Finds the shortest path from start node (1) to goal node (N).

    startIdx = 1;
    goalIdx  = size(nodes,1);

    [nodePath, pathLengthValue] = shortestpath(G, startIdx, goalIdx);

    if isempty(nodePath)
        path = [];
        pathLengthValue = inf;
    else
        path = nodes(nodePath, :);
    end
end