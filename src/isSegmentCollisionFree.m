function free = isSegmentCollisionFree(p1, p2, env)
% ISSEGMENTCOLLISIONFREE Checks whether segment [p1 p2] is collision-free
% by discretizing the segment.

    numSamples = max(20, ceil(norm(p2 - p1)));
    xs = linspace(p1(1), p2(1), numSamples);
    ys = linspace(p1(2), p2(2), numSamples);

    free = true;
    for k = 1:numSamples
        if isPointInCollision([xs(k), ys(k)], env)
            free = false;
            return;
        end
    end
end