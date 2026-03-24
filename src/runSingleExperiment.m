function result = runSingleExperiment(env, plannerType, strategyParams, plannerParams)
% RUNSINGLEEXPERIMENT Runs one experiment for one planner and one strategy.
%
% plannerType: 'standard_rrt' or 'kinematic_rrt'

    result.success = false;
    result.time = inf;
    result.pathLength = inf;
    result.treeSize = 0;

    switch lower(plannerType)

        case 'standard_rrt'
            tic;
            [nodes, parents, path, success] = rrtPlanWithStrategy( ...
                env, ...
                plannerParams.maxNodes, ...
                plannerParams.stepSize, ...
                plannerParams.goalRadius, ...
                strategyParams);
            elapsedTime = toc;

            result.success = success;
            result.time = elapsedTime;
            result.treeSize = size(nodes,1);

            if success
                result.pathLength = pathLength(path);
            end

        case 'kinematic_rrt'
            startState = [env.start(1); env.start(2); 0; 0];
            goalPoint = env.goal;

            tic;
            [nodes, parents, edgeTraj, path, success] = ...
                feasibleKinematicRRTWithStrategy( ...
                    env, startState, goalPoint, plannerParams, strategyParams);
            elapsedTime = toc;

            result.success = success;
            result.time = elapsedTime;
            result.treeSize = size(nodes,1);

            if success
                result.pathLength = pathLength(path(:,1:2));
            end

        otherwise
            error('Unknown planner type.');
    end
end