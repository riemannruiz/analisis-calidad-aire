% Archivo que completa las fechas y calcula las fechas por semanas y
% acompleta la tabla para ver que fechas hacen falta de datos

load ..\Data_PTI\tabla_O3_PM10

%% Acompletar la tabla con todas las fechas
varnames = {'Num','FechaHora','Atemajac','Aguilas','Centro','Las_Pintas','Loma_Dorada','Miravalle','Oblatos','Santa_Fe','Tlaquepaque','Vallarta'};
tic
% Crear vector con todas las fechas
dates_complete = datetime(2015,1,1,0,0,0)+hours(0:(24*365*3+24))';

% Crear una matriz temporal para guardar los datos
d_tmp =ones(size(dates_complete,1),10)*-99;

% Mover los datos a la tabla completa
data = PM10;
for k=1:size(data,1)
    idx = data.FechaHora(k)==dates_complete;
    if sum(idx)>0
        d_tmp(idx,:)=table2array(data(k,3:12));
    end
end
% Cambiar los valores -99 a NaN
d_tmp(d_tmp == -99)=NaN;
toc;

%Elapsed time is 35.104073 seconds.

%% Crear la tabla de resultados
d_tmp_cell{1} = [1:size(d_tmp,1)]';
d_tmp_cell{2} = dates_complete;
d_tmp_cell = cat(2,d_tmp_cell,num2cell(d_tmp,1));
PM10_all = table(d_tmp_cell{1:end},'VariableNames',varnames);

%% Guardar los resultados de este script
%save ..\Data_PTI\tabla_O3_PM10_all O3_all PM10_all
