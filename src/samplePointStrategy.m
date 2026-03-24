function qRand = samplePointStrategy(env, goalPoint, strategy, goalBias, sigmaGoal)
% SAMPLEPOINTSTRATEGY Samples a point according to a chosen strategy.
%
% Inputs:
%   env       : environment structure
%   goalPoint : [x y]
%   strategy  : 'uniform', 'goal_biased', or 'gaussian_goal'
%   goalBias  : probability of directly sampling the goal (for goal_biased)
%   sigmaGoal : standard deviation for gaussian sampling around the goal
%
% Output:
%   qRand     : sampled point [x y]

    switch lower(strategy)

        case 'uniform'
            qRand = [ ...
                env.xMin + (env.xMax - env.xMin) * rand(), ...
                env.yMin + (env.yMax - env.yMin) * rand() ...
            ];

        case 'goal_biased'
            if rand() < goalBias
                qRand = goalPoint;
            else
                qRand = [ ...
                    env.xMin + (env.xMax - env.xMin) * rand(), ...
                    env.yMin + (env.yMax - env.yMin) * rand() ...
                ];
            end

        case 'gaussian_goal'
            qRand = goalPoint + sigmaGoal * randn(1,2);

            % keep point inside bounds
            qRand(1) = max(min(qRand(1), env.xMax), env.xMin);
            qRand(2) = max(min(qRand(2), env.yMax), env.yMin);

        otherwise
            error('Unknown sampling strategy.');
    end
end