%% Limpiar las variables para iniciar el analisis
clear;
close all;
clc;

%% Importar los datos de la contaminación
% Lista de estaciones
nombres_est = {'Atemajac','Águilas','Loma dorada','Miravalle','Centro','Oblatos','Las Pintas','Tlaquepaque','Santa Fe','Vallarta'};
[~,~,raw] = xlsread('..\Data\Datos_2014.xlsx',nombres_est{2});
hora_tmp = round(cell2mat(raw(2:25,2)),4);
load data_temp_limpieza.mat
%% Limpieza

idx_col_to = [];
idx_col_from = [];
c_names = cellfun(@parse_blank,raw(1,:),'UniformOutput', false);
for k = 3:length(col_names)
    tmp=0;
    for m = 3:length(c_names)
        if strfind(c_names{m},col_names{k})>0 & strfind(col_names{k},c_names{m})>0
            idx_col_to = [idx_col_to k];
            idx_col_from = [idx_col_from m];
        end
    end
end
%col_names = raw(1,:);

% crear una matriz de fechas
dates_tmp = cellfun(@parse_dates,raw(2:end,1),'UniformOutput', false);
dates = datetime(dates_tmp,'InputFormat','dd/MM/yyyy HH:mm:ss');
clear dates_tmp;

% descomponer las fechas en año mes dia
data = [year(dates) , month(dates) , day(dates)];
% concatenar los datos leidos en la hoja de excel
data = [data , cell2mat(raw(2:end,2:end))];
% Cambiar la hora de la hora a un numero entero de 0 - 23 hrs
if sum(data(:,4))>10000
    data(:,4)=hour(dates);
else
    for k = 0:size(hora_tmp,1)-1
        idx = data(:,4) == hora_tmp(k+1,1);
        data(idx,4)=k;
    end
end

dates = datetime([data(:,1:4),zeros(size(data,1),2)]);

%% Acompletar las fechas faltantes
% Crear una matriz con todas la fechas posibles
dates_complete = datetime(2017,1,1,0,0,0)+hours(0:24*365)';
% Crear una matriz vacía con las fechas y horas completas
data_complete = [year(dates_complete) , month(dates_complete) , ...
    day(dates_complete) , hour(dates_complete) , ones(size(dates_complete,1),14)*-1]; 
% Hacer el llenado de la tabla completa
for k = 1:size(dates,1)
    idx = dates_complete==dates(k);
    if sum(idx)>0
        data_complete(idx,idx_col_to)=data(k,indx_from);
    end
end


%% PM10 y O3
PM10 = raw(2:end,9);
