function qNew = steer(qNear, qRand, stepSize)
% STEER Moves from qNear towards qRand with a maximum distance = stepSize.

    direction = qRand - qNear;
    d = norm(direction);

    if d <= stepSize
        qNew = qRand;
    else
        qNew = qNear + (direction / d) * stepSize;
    end
end