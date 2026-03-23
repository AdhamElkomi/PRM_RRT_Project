clc; clear; close all;

env = createEnvironment();

maxNodes   = 1000;
stepSize   = 5;
goalRadius = 6;
goalBias   = 0.10;

tic;
[nodes, parents, path, success] = rrtPlan(env, maxNodes, stepSize, goalRadius, goalBias);
elapsedTime = toc;

plotRRTResult(env, nodes, parents, path);

fprintf('--- RRT ---\n');
fprintf('Maximum nodes       : %d\n', maxNodes);
fprintf('Step size           : %.2f\n', stepSize);
fprintf('Goal radius         : %.2f\n', goalRadius);
fprintf('Goal bias           : %.2f\n', goalBias);
fprintf('Computation time    : %.4f s\n', elapsedTime);

if success
    fprintf('Path found          : YES\n');
    fprintf('Path length         : %.4f\n', pathLength(path));
else
    fprintf('Path found          : NO\n');
end