function [nodes, parents, path, success] = rrtPlanWithStrategy(env, maxNodes, stepSize, goalRadius, strategyParams)
% RRTPLANWITHSTRATEGY Standard RRT with configurable sampling strategy.
%
% strategyParams fields:
%   .strategy
%   .goalBias
%   .sigmaGoal

    nodes = env.start;
    parents = 0;
    success = false;
    path = [];

    for k = 1:maxNodes

        qRand = samplePointStrategy( ...
            env, env.goal, ...
            strategyParams.strategy, ...
            strategyParams.goalBias, ...
            strategyParams.sigmaGoal);

        if isPointInCollision(qRand, env)
            continue;
        end

        idxNear = nearestNode(nodes, qRand);
        qNear = nodes(idxNear, :);
        qNew = steer(qNear, qRand, stepSize);

        if ~isPointInCollision(qNew, env) && isSegmentCollisionFree(qNear, qNew, env)
            nodes = [nodes; qNew]; %#ok<AGROW>
            parents = [parents; idxNear]; %#ok<AGROW>

            if norm(qNew - env.goal) <= goalRadius
                if isSegmentCollisionFree(qNew, env.goal, env)
                    nodes = [nodes; env.goal]; %#ok<AGROW>
                    parents = [parents; size(nodes,1)-1]; %#ok<AGROW>
                    path = reconstructPathRRT(nodes, parents, size(nodes,1));
                    success = true;
                    return;
                end
            end
        end
    end
end