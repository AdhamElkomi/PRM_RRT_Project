function [success, finalTraj, finalState] = tryConnectToGoal(stateNear, goalPoint, params, env)
% TRYCONNECTTOGOAL
% Tries to connect the current state to the exact goal point
% using a simple control search on the bicycle model.

    success = false;
    finalTraj = [];
    finalState = [];

    % Candidate controls to test
    vCandidates = linspace(params.vMin, params.vMax, 3);
    deltaRateCandidates = linspace(params.deltaRateMin, params.deltaRateMax, 7);

    % Use a finer propagation near the goal
    nStepsFinal = 30;

    bestDist = inf;

    for i = 1:length(vCandidates)
        for j = 1:length(deltaRateCandidates)
            v = vCandidates(i);
            deltaRate = deltaRateCandidates(j);

            traj = propagateBicycle(stateNear, v, deltaRate, ...
                params.L, params.dt, nStepsFinal, params.deltaMax);

            % Check whole trajectory
            if isTrajectoryCollisionFree(traj, env)
                endPos = traj(end, 1:2);
                distToGoal = norm(endPos - goalPoint);

                if distToGoal < bestDist
                    bestDist = distToGoal;
                    finalTraj = traj;
                    finalState = traj(end, :)';
                end
            end
        end
    end

    finalTraj(end,1:2) = goalPoint;

    % Accept only if the final state is very close to the true goal
    if bestDist < 0.5
        finalTraj(end,1:2) = goalPoint;
        finalState = finalTraj(end,:)';
        success = true;
    end
end