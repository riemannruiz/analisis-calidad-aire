% Organizar los datos limpios para poder hacer analisis posteriormente.
% Como primer paso se tratan de ordenar los datos en grupos de cuatro
% semanas
clear all
load ..\Data_PTI\tabla_O3_PM10_all

%% Agrupar los datos de una estacion por un numero determinado de horas
num_hours = 168; %168 datos son los datos de una semana

% Como el 2016 fue un anio bisiesto, se tiene el detalle que tiene un dia
% adicional a los dias del 2015. Por lo que se propone hacer dos
% agrupaciones que tendran un dia de diferencia

% Agrupacion de los datos por semana, considerando que para ambos años el
% punto inicial es el 1 de enero. Es decir se supone que el primero de
% enero del 2015 tuvo niveles similares al 1 de enero del 2016 sin importar
% que fueron dias de la semana distintos. Cada anio tiene 52 semanas

% Operaciones sobre el O3
idx = year(O3_all.FechaHora)==2015;
d1_week = group_num_hours(table2array(O3_all(idx,3:12)),num_hours);
idx = year(O3_all.FechaHora)==2016;
d2_week = group_num_hours(table2array(O3_all(idx,3:12)),num_hours);
idx = year(O3_all.FechaHora)==2017;
d3_week = group_num_hours(table2array(O3_all(idx,3:12)),num_hours);
for k = 1:10
    O3_week1{k} = [d1_week{k} d2_week{k} d3_week{k}];
end
clear idx d1_week d2_week d3_week k;

% Operaciones sobre el PM10
idx = year(PM10_all.FechaHora)==2015;
d1_week = group_num_hours(table2array(PM10_all(idx,3:12)),num_hours);
idx = year(PM10_all.FechaHora)==2016;
d2_week = group_num_hours(table2array(PM10_all(idx,3:12)),num_hours);
idx = year(PM10_all.FechaHora)==2017;
d3_week = group_num_hours(table2array(PM10_all(idx,3:12)),num_hours);
for k = 1:10
    PM10_week1{k} = [d1_week{k} d2_week{k} d3_week{k}];
end
clear idx d1_week d2_week d3_week k;



% Agrupacion de los datos por semana, considerando que el dato inicial es
% el 1 de enero del 2015 y los ultimos dias del 2015 acompletan una semana
% con los primeros dias del 2016. Es decir, se respetan los dias de la
% semana sin importar la fecha.

% Operaciones sobre el O3
O3_week2 = group_num_hours(table2array(O3_all(:,3:12)),num_hours);

% Operaciones sobre el PM10
PM10_week2 = group_num_hours(table2array(PM10_all(:,3:12)),num_hours);

%% Solo para visualizar unos datos internos (opcional)
% n=20;
% subplot(2,1,1)
% plot(D1_week{1}(:,53)),grid
% subplot(2,1,2)
% plot(D2_week{1}(:,53)),grid
% % subplot(3,1,3)
% % plot(d3_week(:,[1:4,53:56])),grid

%% Calcular los promedios por grupos de 4 semanas (es posible cambio del intervalo)
% Se obtiene el promedio por grupos de cuatro semanas y considerando el
% mismo grupo del siguiente año. Es decir, se promedian la semana 1:4 junto
% con las semanas 53:56. De tal forma que se obtienen 13 promedios, porque
% existen 13 grupos de cuatro semanas en un anio.
num_week = 4;
[mO3_v1,rmO3_v1] = mean_ratio_by_weeks(O3_week1,num_week);
[mO3_v2,rmO3_v2] = mean_ratio_by_weeks(O3_week2,num_week);
[mPM10_v1,rmPM10_v1] = mean_ratio_by_weeks(PM10_week1,num_week);
[mPM10_v2,rmPM10_v2] = mean_ratio_by_weeks(PM10_week2,num_week);

%% Guardar los resultados obtenidos del script
% Los datos importantes son:
% 1.- Datos organizados por semana en ambas versiones (O3_week1, O3_week2,
%       PM10_week1, PM10_week2)
% 2.- Perfiles promedio por grupos de 4 semanas (mO3_v1, mO3_v2, mPM10_v1,
%       mPM10_v2)
% 3.- Cambios porcentuales de los perfiles promedio (rmO3_v1, rmO3_v2,
% rmPM10_v1, rmPM10_v2)

% save ..\Data_PTI\cambios_porcentuales_O3_PM10_week4 rmO3_v1 rmO3_v2 rmPM10_v1 rmPM10_v2

