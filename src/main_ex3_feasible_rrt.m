clc;
clear;
close all;

env = createEnvironment();

startState = [env.start(1); env.start(2); 0; 0];
goalPoint = env.goal;

params.maxNodes = 10000;
params.goalBias = 0.10;

params.L = 2.5;
params.dt = 0.05;
params.nSteps = 15;
params.deltaMax = pi/6;
params.goalRadius = 6;

% Candidate controls for reachable set approximation
params.vCandidates = [1.0 1.5 2.0];
params.deltaRateCandidates = [-0.25 0 0.25];

tic;
[nodes, parents, edgeTraj, path, success] = ...
    feasibleKinematicRRT(env, startState, goalPoint, params);
elapsedTime = toc;

plotFeasibleKinematicRRT(env, nodes, edgeTraj, path);

fprintf('--- Exercise 3: Feasible Kinematic RRT ---\n');
fprintf('Tree size       : %d\n', size(nodes,1));
fprintf('Computation time: %.4f s\n', elapsedTime);
fprintf('Path found      : %d\n', success);