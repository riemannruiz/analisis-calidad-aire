function res = group_num_hours(data,num_hours)
% La funcion supone que los datos tienen todas las horas completas

% Determina el numero de columnas tiene data e itera en cada una de las
% columnas
ncol = size(data,2);
for c = 1:ncol
    tmp = [];
    for k = 1:floor(size(data,1)/num_hours) % 168 hrs en 7 dias
        tmp(:,k) = data((k-1)*num_hours+1:k*num_hours,c);
    end
    res{c} = tmp;
end