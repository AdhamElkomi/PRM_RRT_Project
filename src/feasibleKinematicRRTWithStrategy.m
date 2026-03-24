function [nodes, parents, edgeTraj, path, success] = ...
    feasibleKinematicRRTWithStrategy(env, startState, goalPoint, params, strategyParams)
% FEASIBLEKINEMATICRRTWITHSTRATEGY Feasible kinematic RRT with sampling strategy.

    nodes = startState(:)';
    parents = 0;
    edgeTraj = {startState(:)'};

    success = false;
    path = [];

    for iter = 1:params.maxNodes

        qRand = samplePointStrategy( ...
            env, goalPoint, ...
            strategyParams.strategy, ...
            strategyParams.goalBias, ...
            strategyParams.sigmaGoal);

        [bestIdx, ~, bestTraj, ~] = ...
            selectBestReachableNode(nodes, qRand, env, params);

        if bestIdx == -1
            continue;
        end

        if ~isTrajectoryCollisionFreeDetailed(bestTraj, env)
            continue;
        end

        stateNew = bestTraj(end, :);

        nodes = [nodes; stateNew]; %#ok<AGROW>
        parents = [parents; bestIdx]; %#ok<AGROW>
        edgeTraj{end+1} = bestTraj; %#ok<AGROW>

        if norm(stateNew(1:2) - goalPoint) <= params.goalRadius
            success = true;
            path = reconstructPathKinematicRRT(nodes, parents, edgeTraj, size(nodes,1));
            return;
        end
    end
end