function [nodes, parents, edgeTraj, path, success] = feasibleKinematicRRT(env, startState, goalPoint, params)
% FEASIBLEKINEMATICRRT Kinematic RRT with reachable-set-based node selection.
%
% Inputs:
%   env        : environment structure
%   startState : [x; y; theta; delta]
%   goalPoint  : [x y]
%   params     : planner parameters
%
% Outputs:
%   nodes      : Nx4 matrix
%   parents    : Nx1 vector
%   edgeTraj   : cell array of local trajectories
%   path       : final reconstructed path
%   success    : true if goal reached

    nodes = startState(:)';
    parents = 0;
    edgeTraj = {startState(:)'};

    success = false;
    path = [];

    for iter = 1:params.maxNodes

        % Sample random position with optional goal bias
        if rand() < params.goalBias
            qRand = goalPoint;
        else
            qRand = [ ...
                env.xMin + (env.xMax - env.xMin) * rand(), ...
                env.yMin + (env.yMax - env.yMin) * rand() ...
            ];
        end

        % Choose node based on reachable-set proximity
        [bestIdx, bestControl, bestTraj, ~] = ...
            selectBestReachableNode(nodes, qRand, env, params);

        if bestIdx == -1
            continue;
        end

        % Safer complete trajectory check
        if ~isTrajectoryCollisionFreeDetailed(bestTraj, env)
            continue;
        end

        stateNew = bestTraj(end, :);

        nodes = [nodes; stateNew]; %#ok<AGROW>
        parents = [parents; bestIdx]; %#ok<AGROW>
        edgeTraj{end+1} = bestTraj; %#ok<AGROW>

        % Goal test
        if norm(stateNew(1:2) - goalPoint) <= params.goalRadius
            success = true;
            path = reconstructPathKinematicRRT(nodes, parents, edgeTraj, size(nodes,1));
            return;
        end
    end
end