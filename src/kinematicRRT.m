function [nodes, parents, edgeTraj, path, success] = kinematicRRT(env, startState, goalPoint, params)
% KINEMATICRRT RRT with bicycle-model kinematic constraints.
%
% Inputs:
%   env        : environment structure
%   startState : [x; y; theta; delta]
%   goalPoint  : [x y]
%   params     : structure containing planner parameters
%
% Outputs:
%   nodes      : Nx4 matrix [x y theta delta]
%   parents    : Nx1 vector
%   edgeTraj   : cell array, trajectory from parent to node
%   path       : full path if found
%   success    : true if goal reached

    nodes = startState(:)';
    parents = 0;
    edgeTraj = {startState(:)'};

    success = false;
    path = [];

    for iter = 1:params.maxNodes

        % Goal bias on sampled position
        if rand() < params.goalBias
            qRand = goalPoint;
        else
            qRand = [ ...
                env.xMin + (env.xMax - env.xMin) * rand(), ...
                env.yMin + (env.yMax - env.yMin) * rand() ...
            ];
        end

        % Find nearest existing node
        idxNear = nearestNodeKinematic(nodes, qRand);
        stateNear = nodes(idxNear, :)';

        % Sample a random control
        [v, deltaRate] = sampleControl( ...
            params.vMin, params.vMax, ...
            params.deltaRateMin, params.deltaRateMax);

        % Propagate with bicycle model
        traj = propagateBicycle( ...
            stateNear, v, deltaRate, ...
            params.L, params.dt, params.nSteps, params.deltaMax);

        stateNew = traj(end, :)';

        % Check validity of the full local trajectory
        if isTrajectoryCollisionFree(traj, env)

            nodes = [nodes; stateNew']; %#ok<AGROW>
            parents = [parents; idxNear]; %#ok<AGROW>
            edgeTraj{end+1} = traj; %#ok<AGROW>

            % Check if goal is reached
            if norm(stateNew(1:2)' - goalPoint) <= params.goalRadius
                success = true;
                path = reconstructPathKinematicRRT(nodes, parents, edgeTraj, size(nodes,1));
                return;
            end
        end
    end
end