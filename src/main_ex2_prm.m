clc; clear; close all;

env = createEnvironment();

nSamples = 150;
connectionRadius = 20;

tic;
[nodes, G] = buildPRM(env, nSamples, connectionRadius);
[path, pathLengthValue, ~] = findPathPRM(nodes, G);
elapsedTime = toc;

plotPRMResult(env, nodes, G, path);

fprintf('--- PRM ---\n');
fprintf('Number of samples   : %d\n', nSamples);
fprintf('Connection radius   : %.2f\n', connectionRadius);
fprintf('Computation time    : %.4f s\n', elapsedTime);
fprintf('Path length         : %.4f\n', pathLengthValue);