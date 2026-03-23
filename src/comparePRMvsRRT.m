clc; clear; close all;

env = createEnvironment();

% Values to test
nodeValues = [50 100 150 200 300 500];

% PRM parameters
connectionRadius = 20;

% RRT parameters
stepSize   = 5;
goalRadius = 6;
goalBias   = 0.10;

% Storage
prmTimes = zeros(size(nodeValues));
prmLengths = zeros(size(nodeValues));

rrtTimes = zeros(size(nodeValues));
rrtLengths = zeros(size(nodeValues));

for i = 1:length(nodeValues)
    n = nodeValues(i);

    % ---------- PRM ----------
    tic;
    [prmNodes, prmGraph] = buildPRM(env, n, connectionRadius);
    [prmPath, prmLen] = findPathPRM(prmNodes, prmGraph);
    prmTimes(i) = toc;
    prmLengths(i) = prmLen;

    % ---------- RRT ----------
    tic;
    [rrtNodes, rrtParents, rrtPath, success] = rrtPlan(env, n, stepSize, goalRadius, goalBias);
    rrtTimes(i) = toc;

    if success
        rrtLengths(i) = pathLength(rrtPath);
    else
        rrtLengths(i) = inf;
    end
end

% Display results in command window
fprintf('\n===== COMPARISON PRM vs RRT =====\n');
fprintf(' Nodes     PRM Time(s)     PRM Length     RRT Time(s)     RRT Length\n');
fprintf('----------------------------------------------------------------------\n');
for i = 1:length(nodeValues)
    fprintf('%5d     %10.4f     %10.4f     %10.4f     %10.4f\n', ...
        nodeValues(i), prmTimes(i), prmLengths(i), rrtTimes(i), rrtLengths(i));
end

% Plot computation times
figure;
plot(nodeValues, prmTimes, '-o', 'LineWidth', 2); hold on;
plot(nodeValues, rrtTimes, '-s', 'LineWidth', 2);
grid on;
xlabel('Number of nodes');
ylabel('Computation time (s)');
title('PRM vs RRT - Computation Time');
legend('PRM', 'RRT');

% Plot path lengths
figure;
plot(nodeValues, prmLengths, '-o', 'LineWidth', 2); hold on;
plot(nodeValues, rrtLengths, '-s', 'LineWidth', 2);
grid on;
xlabel('Number of nodes');
ylabel('Path length');
title('PRM vs RRT - Path Length');
legend('PRM', 'RRT');