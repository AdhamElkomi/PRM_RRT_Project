function [nodes, G] = buildPRM(env, nSamples, connectionRadius)
% BUILDPRM Builds a PRM graph from random collision-free samples.
%
% nodes = [start; random points; goal]
% G = weighted graph

    randomPoints = sampleFreePoints(nSamples, env);
    nodes = [env.start; randomPoints; env.goal];

    N = size(nodes, 1);
    s = [];
    t = [];
    w = [];

    for i = 1:N
        for j = i+1:N
            d = norm(nodes(i,:) - nodes(j,:));

            if d <= connectionRadius
                if isSegmentCollisionFree(nodes(i,:), nodes(j,:), env)
                    s(end+1) = i; %#ok<AGROW>
                    t(end+1) = j; %#ok<AGROW>
                    w(end+1) = d; %#ok<AGROW>
                end
            end
        end
    end

    G = graph(s, t, w);
end