function res = parse_dates_pti(x)
    for k = 1:length(x)
        try
            res(k,1) = datetime(x(k),'InputFormat','yyyy-MM-dd HH:mm:ss.SSS');
        catch
            res(k,1) = datetime(x(k),'InputFormat','yyyy-MM-dd HH:mm:ss');
        end
    end
end