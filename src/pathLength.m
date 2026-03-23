function L = pathLength(path)
% PATHLENGTH Computes total path length.

    if isempty(path) || size(path,1) < 2
        L = inf;
        return;
    end

    diffs = diff(path, 1, 1);
    L = sum(vecnorm(diffs, 2, 2));
end