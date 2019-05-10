function dqrtabla =  dqr(data)

names = data.Properties.VariableNames;

dqrtabla = repmat({''},length(names),9);
dqrtabla(:,1)=names;

for k = 1:length(names)
    try
        dqrtabla{k,2}=eval(sprintf('class(data.%s{1});',names{k}));
    catch
        dqrtabla{k,2}=eval(sprintf('class(data.%s(1));',names{k}));
    end
    try
        %dqrtabla{k,3} = sum(cell2mat(cellfun(@(x) sum(isnan(x)),eval(sprintf('data.%s',names{k})), 'UniformOutput', false)));
        dqrtabla{k,3} = sum(cell2mat(cellfun(@(x) sum(isempty(x)),eval(sprintf('data.%s',names{k})), 'UniformOutput', false)));
        dqrtabla{k,4} = sum(cell2mat(cellfun(@(x) sum(~isempty(x)),eval(sprintf('data.%s',names{k})), 'UniformOutput', false)));
    catch
        try
            dqrtabla{k,3} = eval(sprintf('sum(isnan(data.%s));',names{k}));
            dqrtabla{k,4} = eval(sprintf('sum(~isnan(data.%s));',names{k}));
        catch
            dqrtabla{k,3} = nan;
            dqrtabla{k,4} = nan;
        end
    end
    dqrtabla{k,5} = eval(sprintf('length(unique(data.%s))',names{k}));
    try
        dqrtabla{k,6} =eval(sprintf('min(data.%s);',names{k}));
    catch
        dqrtabla{k,6} = nan;
    end
    try
        dqrtabla{k,7} =eval(sprintf('max(data.%s);',names{k}));
    catch
        dqrtabla{k,7} = nan;
    end
    try
        dqrtabla{k,8} =eval(sprintf('mean(data.%s(~isnan(data.%s)));',names{k},names{k}));
    catch
        dqrtabla{k,8} = nan;
    end
    try
        dqrtabla{k,9} =eval(sprintf('std(data.%s(~isnan(data.%s)));',names{k},names{k}));
    catch
        dqrtabla{k,9} = nan;
    end
end
dqrtabla = cell2table(dqrtabla);
dqrtabla.Properties.VariableNames = [{'names'},{'types'},{'missing_values'},{'present_values'},{'unique_values'},{'min_value'},{'max_value'},{'mean_value'},{'std_value'}];