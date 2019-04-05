function res = format_data(data)
c = size(data,2);
for k = 1:c
    tmp(:,k) = data{k}(:);
end
res = tmp;