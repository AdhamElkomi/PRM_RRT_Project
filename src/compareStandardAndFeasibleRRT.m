clc;
clear;
close all;

env = createEnvironment();

%% Standard RRT parameters
maxNodesStandard = 1000;
stepSize = 5;
goalRadiusStandard = 6;
goalBiasStandard = 0.10;

%% Feasible Kinematic RRT parameters
startState = [env.start(1); env.start(2); 0; 0];
goalPoint = env.goal;

params.maxNodes = 400;
params.goalBias = 0.10;
params.L = 2.5;
params.dt = 0.05;
params.nSteps = 15;
params.deltaMax = pi/6;
params.goalRadius = 6;

params.vCandidates = [1.0 1.5 2.0];
params.deltaRateCandidates = [-0.25 0 0.25];

%% Standard RRT
tic;
[nodesStd, parentsStd, pathStd, successStd] = ...
    rrtPlan(env, maxNodesStandard, stepSize, goalRadiusStandard, goalBiasStandard);
timeStd = toc;

%% Feasible kinematic RRT
tic;
[nodesKin, parentsKin, edgeTrajKin, pathKin, successKin] = ...
    feasibleKinematicRRT(env, startState, goalPoint, params);
timeKin = toc;

%% Plot comparison
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
title(sprintf('Feasible Kinematic RRT | %.4f s', timeKin));

%% Command window info
fprintf('--- Comparison ---\n');
fprintf('Standard RRT found path  : %d\n', successStd);
fprintf('Standard RRT time        : %.4f s\n', timeStd);
fprintf('Feasible Kinematic found : %d\n', successKin);
fprintf('Feasible Kinematic time  : %.4f s\n', timeKin);