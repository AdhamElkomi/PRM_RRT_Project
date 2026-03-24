clc;
clear;
close all;

rng(1);

env = createEnvironment();

%% Strategy to visualize
strategyParams.strategy = 'goal_biased';
strategyParams.goalBias = 0.20;
strategyParams.sigmaGoal = 0.0;

%% Standard RRT parameters
paramsStd.maxNodes = 1000;
paramsStd.stepSize = 5;
paramsStd.goalRadius = 6;

%% Kinematic RRT parameters
paramsKin.maxNodes = 400;
paramsKin.goalRadius = 6;
paramsKin.goalBias = 0.10;
paramsKin.L = 2.5;
paramsKin.dt = 0.05;
paramsKin.nSteps = 15;
paramsKin.deltaMax = pi/6;
paramsKin.vCandidates = [1.0 1.5 2.0];
paramsKin.deltaRateCandidates = [-0.25 0 0.25];

%% Standard RRT
tic;
[nodesStd, parentsStd, pathStd, successStd] = rrtPlanWithStrategy( ...
    env, paramsStd.maxNodes, paramsStd.stepSize, paramsStd.goalRadius, strategyParams);
timeStd = toc;

%% Kinematic RRT
startState = [env.start(1); env.start(2); 0; 0];
goalPoint = env.goal;

tic;
[nodesKin, parentsKin, edgeTrajKin, pathKin, successKin] = ...
    feasibleKinematicRRTWithStrategy(env, startState, goalPoint, paramsKin, strategyParams);
timeKin = toc;

%% Plot side by side
figure;

subplot(1,2,1);
plotEnvironment(env); hold on;
for i = 2:size(nodesStd,1)
    p = nodesStd(i,:);
    parent = nodesStd(parentsStd(i),:);
    plot([p(1) parent(1)], [p(2) parent(2)], 'b-');
end
plot(nodesStd(:,1), nodesStd(:,2), 'b.', 'MarkerSize', 8);
if successStd
    plot(pathStd(:,1), pathStd(:,2), 'r-', 'LineWidth', 2.5);
end
title(sprintf('Standard RRT | %.4f s', timeStd));

subplot(1,2,2);
plotFeasibleKinematicRRT(env, nodesKin, edgeTrajKin, pathKin);
title(sprintf('Kinematic RRT | %.4f s', timeKin));