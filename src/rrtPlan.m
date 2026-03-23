function [nodes, parents, path, success] = rrtPlan(env, maxNodes, stepSize, goalRadius, goalBias)
% RRTPLAN Builds an RRT and tries to reach the goal.
%
% Inputs:
%   maxNodes   : maximum number of nodes in the tree
%   stepSize   : extension length
%   goalRadius : distance to goal for stopping
%   goalBias   : probability of sampling the goal directly
%
% Outputs:
%   nodes, parents, path, success

    nodes = env.start;
    parents = 0;
    success = false;
    path = [];

    for k = 1:maxNodes
        % Goal bias
        if rand() < goalBias
            qRand = env.goal;
        else
            qRand = [ ...
                env.xMin + (env.xMax - env.xMin) * rand(), ...
                env.yMin + (env.yMax - env.yMin) * rand() ...
            ];
        end

        if isPointInCollision(qRand, env)
            continue;
        end

        idxNear = nearestNode(nodes, qRand);
        qNear = nodes(idxNear, :);
        qNew = steer(qNear, qRand, stepSize);

        if ~isPointInCollision(qNew, env) && isSegmentCollisionFree(qNear, qNew, env)
            nodes = [nodes; qNew]; %#ok<AGROW>
            parents = [parents; idxNear]; %#ok<AGROW>

            % Check if goal can be connected
            if norm(qNew - env.goal) <= goalRadius
                if isSegmentCollisionFree(qNew, env.goal, env)
                    nodes = [nodes; env.goal]; %#ok<AGROW>
                    parents = [parents; size(nodes,1)-1]; %#ok<AGROW>
                    path = reconstructPathRRT(nodes, parents, size(nodes,1));
                    success = true;
                    return;
                end
            end
        end
    end
end