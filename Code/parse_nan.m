function res = parse_nan(x)
    if any(isnan(x))|sum(size(x))>2
        res = -1;
    else
        res = double(x);
    end