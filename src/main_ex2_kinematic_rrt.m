clc;
clear;
close all;

% Environment from previous work
env = createEnvironment();

% Initial state of bicycle model: [x; y; theta; delta]
startState = [env.start(1); env.start(2); 0; 0];
goalPoint = env.goal;

% Parameters
params.maxNodes = 10000;
params.goalBias = 0.10;

params.L = 2.5;
params.dt = 0.05;
params.nSteps = 15;
params.deltaMax = pi/6;

params.vMin = 1.0;
params.vMax = 2.0;
params.deltaRateMin = -0.25;
params.deltaRateMax = 0.25;

params.goalRadius = 6;

% Run planner
tic;
[nodes, parents, edgeTraj, path, success] = kinematicRRT(env, startState, goalPoint, params);
elapsedTime = toc;

% Plot
plotKinematicRRT(env, nodes, edgeTraj, path);

% Display results
fprintf('--- Kinematic RRT ---\n');
fprintf('Number of nodes attempted : %d\n', params.maxNodes);
fprintf('Computation time         : %.4f s\n', elapsedTime);
fprintf('Nodes in tree            : %d\n', size(nodes,1));

if success
    fprintf('Path found               : YES\n');
else
    fprintf('Path found               : NO\n');
end