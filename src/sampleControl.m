function [v, deltaRate] = sampleControl(vMin, vMax, deltaRateMin, deltaRateMax)
% SAMPLECONTROL Samples a random control input for the bicycle model.
%
% Outputs:
%   v         : linear velocity
%   deltaRate : steering rate

    v = vMin + (vMax - vMin) * rand();
    deltaRate = deltaRateMin + (deltaRateMax - deltaRateMin) * rand();
end