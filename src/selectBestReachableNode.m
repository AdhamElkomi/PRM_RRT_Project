function [bestNodeIdx, bestControl, bestTrajectory, bestCost] = ...
    selectBestReachableNode(nodes, qRand, env, params)
% SELECTBESTREACHABLENODE Selects the node whose reachable set is the
% closest to the random sample.
%
% Inputs:
%   nodes  : Nx4 matrix [x y theta delta]
%   qRand  : [x y]
%   env    : environment
%   params : planner parameters
%
% Outputs:
%   bestNodeIdx   : index of selected node
%   bestControl   : [v deltaRate]
%   bestTrajectory: local propagated trajectory
%   bestCost      : minimum trajectory-to-sample distance

    controls = generateControlSet(params.vCandidates, params.deltaRateCandidates);

    bestCost = inf;
    bestNodeIdx = -1;
    bestControl = [];
    bestTrajectory = [];

    for i = 1:size(nodes, 1)
        state = nodes(i, :)';

        for c = 1:size(controls, 1)
            v = controls(c, 1);
            deltaRate = controls(c, 2);

            traj = propagateBicycle( ...
                state, v, deltaRate, ...
                params.L, params.dt, params.nSteps, params.deltaMax);

            % full trajectory collision checking
            if isTrajectoryCollisionFree(traj, env)
                cost = trajectoryCostToSample(traj, qRand);

                if cost < bestCost
                    bestCost = cost;
                    bestNodeIdx = i;
                    bestControl = [v, deltaRate];
                    bestTrajectory = traj;
                end
            end
        end
    end
end