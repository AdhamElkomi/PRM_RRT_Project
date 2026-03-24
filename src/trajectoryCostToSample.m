function cost = trajectoryCostToSample(trajectory, qRand)
% TRAJECTORYCOSTTOSAMPLE Returns the minimum distance between a trajectory
% and a sampled point qRand = [x y].

    points = trajectory(:, 1:2);
    distances = vecnorm(points - qRand, 2, 2);
    cost = min(distances);
end