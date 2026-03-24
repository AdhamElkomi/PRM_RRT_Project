function trajectory = simulateBicycle(initialState, v, deltaRate, L, dt, T, deltaMax)
% SIMULATEBICYCLE Simulates the bicycle model over a time horizon.
%
% Inputs:
%   initialState : [x; y; theta; delta]
%   v            : constant linear velocity
%   deltaRate    : constant steering rate
%   L            : wheelbase
%   dt           : time step
%   T            : total simulation time
%   deltaMax     : maximum absolute steering angle
%
% Output:
%   trajectory   : Nx4 matrix, each row = [x y theta delta]

    N = floor(T / dt) + 1;
    trajectory = zeros(N, 4);

    state = initialState;
    trajectory(1, :) = state';

    for k = 2:N
        state = bicycleStep(state, v, deltaRate, L, dt, deltaMax);
        trajectory(k, :) = state';
    end
end