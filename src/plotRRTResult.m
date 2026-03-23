function plotRRTResult(env, nodes, parents, path)
% PLOTRRTRESULT Displays the RRT tree and final path.

    plotEnvironment(env);
    hold on;

    % Plot tree edges
    for i = 2:size(nodes,1)
        p = nodes(i,:);
        parent = nodes(parents(i),:);
        plot([p(1) parent(1)], [p(2) parent(2)], 'b-');
    end

    % Plot nodes
    plot(nodes(:,1), nodes(:,2), 'b.', 'MarkerSize', 10);

    % Plot path
    if ~isempty(path)
        plot(path(:,1), path(:,2), 'r-', 'LineWidth', 2.5);
    end

    title('RRT Result');
end