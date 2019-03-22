%% Limpiar las variables para iniciar el analisis
clear;
close all;
clc;

%% Importar los datos de la contaminación
% Lista de estaciones
tic;
nombres_est = {'Atemajac','Aguilas','Loma Dorada','Miravalle','Centro','Oblatos','Las Pintas','Tlaquepaque','Vallarta'};
col_names = {'Fecha','Hora','O3','NO','NO2','NOX','SO2','CO','PM10','PM2.5','TempExt','RH','WS','WD','Precipitacion','RadSolar'}
% Crear una matriz con todas la fechas posibles
dates_complete = datetime(2012,1,1,0,0,0)+hours(0:24*365)';
%%load data_temp_limpieza.mat;
datafinal = [];
for hje = 1:length(nombres_est)
    [~,~,raw] = xlsread('../Data/Datos_2012.xlsx',nombres_est{hje});
    hora_tmp = cell2mat(raw(2:25,2));
    %% Limpieza
    
    % crear una matriz de fechas
    dt = raw(2:end,1);
    idx_d = cellfun(@(x) sum(isnan(x)),dt);
    dt(cellfun(@(x) any(isnan(x)),dt)) = [];
    dates_tmp = cellfun(@parse_dates,dt,'UniformOutput', false);
    
    dates = datetime(dates_tmp,'InputFormat','dd/MM/yyyy HH:mm:ss');
    clear dates_tmp;
%%
    % descomponer las fechas en año mes dia
    data = [year(dates) , month(dates) , day(dates)];
    % concatenar los datos leidos en la hoja de excel
    tmp = cellfun(@parse_nan,raw(2:end,2:end),'UniformOutput', false);
    tmp = cell2mat(tmp);
    data = [data , tmp(~idx_d,:)];
    %%data(:,4) = round(data(:,4),4);
    % Cambiar la hora de la hora a un numero entero de 0 - 23 hrs
    b1=0;
    format shortG
    %for k = 0:size(hora_tmp,1)-1
        %idx = data(:,4) == hora_tmp(k+1,1);
        %data(idx,4)=k;
    %end
    for k =1: size(data,1)
        %if(data(k,4)>=237)
            auxiliar = data(k,4)+datetime(1899, 12, 30, 0,0,0);
            data(k,4)=hour(auxiliar);
            if(minute(auxiliar)>50)
                data(k,4)=data(k,4)+1;
            end
            b1=1;
        %end
    end
    dates = datetime([data(:,1:4),zeros(size(data,1),2)]);
    %% Acompletar las fechas faltantes
    % Crear una matriz vacía con las fechas y horas completas
    data_complete = [year(dates_complete) , month(dates_complete) , ...
        day(dates_complete) , hour(dates_complete) , ones(size(dates_complete,1),14)*-1]; 
    
    %% Determinar las columnas que si estan reportadas
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
    clear tmp k m
    
    %% Hacer el llenado de la tabla completa
    for k = 1:size(dates,1)
        idx = dates_complete==dates(k);
        if sum(idx)>0
            data_complete(idx,idx_col_to+2)=data(k,idx_col_from+2);
        end
    end
    datafinal = [datafinal;[ones(size(dates_complete))*hje , data_complete]];
end
%% PM10 y O3
toc;
save datafinal_2012 datafinal
