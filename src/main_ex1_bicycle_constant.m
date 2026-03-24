clc;
clear;
close all;

% Initial state: [x; y; theta; delta]
initialState = [0; 0; 0; 0];

% Parameters
v = 2.0;                  % linear velocity
deltaRate = 0.15;         % steering rate
L = 2.5;                  % wheelbase
dt = 0.05;                % time step
T = 12;                   % total simulation time
deltaMax = pi / 6;        % max steering angle = 30 deg

% Simulation
trajectory = simulateBicycle(initialState, v, deltaRate, L, dt, T, deltaMax);

% Plot
plotBicycleTrajectory(trajectory, 'Bicycle Model - Constant Inputs');

% Display final state
finalState = trajectory(end, :);
disp('Final state [x y theta delta] =');
disp(finalState);