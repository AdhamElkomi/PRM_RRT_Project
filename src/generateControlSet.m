function controls = generateControlSet(vValues, deltaRateValues)
% GENERATECONTROLSET Creates a list of candidate controls.
%
% Output format:
% controls = [v1 deltaRate1;
%             v2 deltaRate2;
%             ...]

    controls = [];

    for i = 1:length(vValues)
        for j = 1:length(deltaRateValues)
            controls = [controls; vValues(i), deltaRateValues(j)]; %#ok<AGROW>
        end
    end
end