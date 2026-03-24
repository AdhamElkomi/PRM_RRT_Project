function free = isTrajectoryCollisionFree(trajectory, env)
% ISTRAJECTORYCOLLISIONFREE Checks if all states of a trajectory are collision-free.
%
% Only x and y are used for collision checking.

    free = true;

    for i = 1:size(trajectory, 1)
        pt = trajectory(i, 1:2);
        if isPointInCollision(pt, env)
            free = false;
            return;
        end
    end
end