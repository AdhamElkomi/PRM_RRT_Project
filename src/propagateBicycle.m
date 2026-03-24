function trajectory = propagateBicycle(state0, v, deltaRate, L, dt, nSteps, deltaMax)
% PROPAGATEBICYCLE Propagates the bicycle model for several Euler steps.
%
% Inputs:
%   state0    : initial state [x; y; theta; delta]
%   v         : constant velocity during propagation
%   deltaRate : constant steering rate during propagation
%   L         : wheelbase
%   dt        : integration time step
%   nSteps    : number of integration steps
%   deltaMax  : maximum steering angle
%
% Output:
%   trajectory : (nSteps+1)x4 matrix

    trajectory = zeros(nSteps + 1, 4);
    trajectory(1, :) = state0';

    state = state0;
    for k = 1:nSteps
        state = bicycleStep(state, v, deltaRate, L, dt, deltaMax);
        trajectory(k + 1, :) = state';
    end
end