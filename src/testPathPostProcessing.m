clc;
clear;
close all;

env = createEnvironment();

maxNodes = 1000;
stepSize = 5;
goalRadius = 6;

strategyParams.strategy = 'goal_biased';
strategyParams.goalBias = 0.20;
strategyParams.sigmaGoal = 0.0;

[nodes, parents, path, success] = rrtPlanWithStrategy( ...
    env, maxNodes, stepSize, goalRadius, strategyParams);

if success
    improvedPath = simpleRRTStarPostProcess(path, env);

    figure;
    plotEnvironment(env); hold on;

    for i = 2:size(nodes,1)
        p = nodes(i,:);
        parent = nodes(parents(i),:);
        plot([p(1) parent(1)], [p(2) parent(2)], 'b-');
    end

    plot(path(:,1), path(:,2), 'r-', 'LineWidth', 2);
    plot(improvedPath(:,1), improvedPath(:,2), 'k--', 'LineWidth', 2);

    legend('Original path', 'Improved path');
    title('Simple Path Improvement after RRT');
end