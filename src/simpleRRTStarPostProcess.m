function newPath = simpleRRTStarPostProcess(path, env)
% SIMPLERRTSTARPOSTPROCESS Simple path shortening by skipping useless points.
%
% This is not a full RRT*, only a lightweight path improvement step.

    if isempty(path) || size(path,1) < 3
        newPath = path;
        return;
    end

    newPath = path(1,:);
    i = 1;

    while i < size(path,1)
        j = size(path,1);

        while j > i + 1
            if isSegmentCollisionFree(path(i,:), path(j,:), env)
                break;
            end
            j = j - 1;
        end

        newPath = [newPath; path(j,:)]; %#ok<AGROW>
        i = j;
    end
end