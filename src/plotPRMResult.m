function plotPRMResult(env, nodes, G, path)
% PLOTPRMRESULT Displays PRM graph and resulting path.

    plotEnvironment(env);
    hold on;

    % Plot graph edges
    [s, t] = findedge(G);
    for k = 1:length(s)
        p1 = nodes(s(k), :);
        p2 = nodes(t(k), :);
        plot([p1(1) p2(1)], [p1(2) p2(2)], 'b-');
    end

    % Plot nodes
    plot(nodes(:,1), nodes(:,2), 'b.', 'MarkerSize', 10);

    % Plot final path
    if ~isempty(path)
        plot(path(:,1), path(:,2), 'r-', 'LineWidth', 2.5);
    end

    title('PRM Result');
end