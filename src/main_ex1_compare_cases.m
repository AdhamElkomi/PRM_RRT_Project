clc;
clear;
close all;

initialState = [0; 0; 0; 0];
dt = 0.05;
T = 10;
deltaMax = pi / 6;

%% Case 1: positive steering rate
v1 = 2.0;
deltaRate1 = 0.12;
L1 = 2.5;
traj1 = simulateBicycle(initialState, v1, deltaRate1, L1, dt, T, deltaMax);

%% Case 2: negative steering rate
v2 = 2.0;
deltaRate2 = -0.12;
L2 = 2.5;
traj2 = simulateBicycle(initialState, v2, deltaRate2, L2, dt, T, deltaMax);

%% Case 3: smaller wheelbase
v3 = 2.0;
deltaRate3 = 0.12;
L3 = 1.5;
traj3 = simulateBicycle(initialState, v3, deltaRate3, L3, dt, T, deltaMax);

%% Plot all cases
figure;
plot(traj1(:,1), traj1(:,2), 'b-', 'LineWidth', 2); hold on;
plot(traj2(:,1), traj2(:,2), 'r-', 'LineWidth', 2);
plot(traj3(:,1), traj3(:,2), 'k-', 'LineWidth', 2);

plot(initialState(1), initialState(2), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);

axis equal;
grid on;
xlabel('x');
ylabel('y');
title('Bicycle Model - Comparison of Different Cases');
legend('Positive steering rate', 'Negative steering rate', 'Smaller wheelbase', 'Start');