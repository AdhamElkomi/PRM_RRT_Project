function nextState = bicycleStep(state, v, deltaRate, L, dt, deltaMax)
% BICYCLESTEP One Euler integration step for a bicycle model.
%
% State format:
% state = [x; y; theta; delta]
%
% Inputs:
%   state     : current state [x; y; theta; delta]
%   v         : linear velocity
%   deltaRate : steering rate
%   L         : wheelbase
%   dt        : time step
%   deltaMax  : maximum absolute steering angle
%
% Output:
%   nextState : next state after one Euler step

    x     = state(1);
    y     = state(2);
    theta = state(3);
    delta = state(4);

    % Bicycle model equations
    x_dot     = v * cos(theta);
    y_dot     = v * sin(theta);
    theta_dot = (v / L) * tan(delta);
    delta_dot = deltaRate;

    % Euler integration
    x_next     = x + dt * x_dot;
    y_next     = y + dt * y_dot;
    theta_next = theta + dt * theta_dot;
    delta_next = delta + dt * delta_dot;

    % Steering saturation
    delta_next = max(min(delta_next, deltaMax), -deltaMax);

    % Optional angle normalization
    theta_next = atan2(sin(theta_next), cos(theta_next));

    nextState = [x_next; y_next; theta_next; delta_next];
end