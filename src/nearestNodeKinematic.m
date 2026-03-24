function idx = nearestNodeKinematic(nodes, qRand)
% NEARESTNODEKINEMATIC Returns the index of the nearest node in position.
%
% nodes is Nx4: [x y theta delta]
% qRand is 1x2 or 1x4, but only x and y are used.

    qxy = qRand(1:2);
    distances = vecnorm(nodes(:,1:2) - qxy, 2, 2);
    [~, idx] = min(distances);
end