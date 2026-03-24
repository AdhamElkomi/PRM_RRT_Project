clc;
clear;
close all;

rng(1);

env = createEnvironment();

%% Sampling strategies
strategies(1).name = 'uniform';
strategies(1).strategy = 'uniform';
strategies(1).goalBias = 0.0;
strategies(1).sigmaGoal = 0.0;

strategies(2).name = 'goal_biased';
strategies(2).strategy = 'goal_biased';
strategies(2).goalBias = 0.20;
strategies(2).sigmaGoal = 0.0;

strategies(3).name = 'gaussian_goal';
strategies(3).strategy = 'gaussian_goal';
strategies(3).goalBias = 0.0;
strategies(3).sigmaGoal = 10.0;

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

%% Storage
nS = length(strategies);

stdTimes = zeros(1,nS);
stdLengths = zeros(1,nS);
stdSuccess = zeros(1,nS);

kinTimes = zeros(1,nS);
kinLengths = zeros(1,nS);
kinSuccess = zeros(1,nS);

%% Run experiments
for i = 1:nS
    s = strategies(i);

    resultStd = runSingleExperiment(env, 'standard_rrt', s, paramsStd);
    resultKin = runSingleExperiment(env, 'kinematic_rrt', s, paramsKin);

    stdTimes(i) = resultStd.time;
    stdLengths(i) = resultStd.pathLength;
    stdSuccess(i) = resultStd.success;

    kinTimes(i) = resultKin.time;
    kinLengths(i) = resultKin.pathLength;
    kinSuccess(i) = resultKin.success;
end

%% Print results
fprintf('\n===== Exercise 4: Sampling Strategy Comparison =====\n');
fprintf('Strategy        | Std Time | Std Length | Std OK | Kin Time | Kin Length | Kin OK\n');
fprintf('----------------------------------------------------------------------------------\n');
for i = 1:nS
    fprintf('%-14s | %8.4f | %10.4f | %6d | %8.4f | %10.4f | %6d\n', ...
        strategies(i).name, ...
        stdTimes(i), stdLengths(i), stdSuccess(i), ...
        kinTimes(i), kinLengths(i), kinSuccess(i));
end

%% Plot times
figure;
bar([stdTimes(:), kinTimes(:)]);
grid on;
set(gca, 'XTickLabel', {strategies.name});
xlabel('Sampling strategy');
ylabel('Computation time (s)');
title('Computation Time: Standard RRT vs Kinematic RRT');
legend('Standard RRT', 'Kinematic RRT');

%% Plot path lengths
figure;
bar([stdLengths(:), kinLengths(:)]);
grid on;
set(gca, 'XTickLabel', {strategies.name});
xlabel('Sampling strategy');
ylabel('Path length');
title('Path Length: Standard RRT vs Kinematic RRT');
legend('Standard RRT', 'Kinematic RRT');