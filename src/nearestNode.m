function idx = nearestNode(nodes, qRand)
% NEARESTNODE Returns the index of the nearest node to qRand.

    distances = vecnorm(nodes - qRand, 2, 2);
    [~, idx] = min(distances);
end