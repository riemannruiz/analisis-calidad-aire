% Simulacion del modelo basado en los cambios porcentuales calculados en el
% analisis "main2_v2_PTI.m". Primero se simulara el modelo lineal sin
% retroalimentacion del error

clear all
close all
clc

load ..\Data_PTI\cambios_porcentuales_O3_PM10_week4
load ..\Data_PTI\tabla_O3_PM10_all

%% simulacion del modelo lineal con los datos de anio seleccionado

data = O3_all;
idx = year(data.FechaHora)==2015;
[T,O3_predict_v1] = sim_lineal(table2array(O3_all(idx,3:12)),rmO3_v1);
[T,O3_predict_v2] = sim_lineal(table2array(O3_all(idx,3:12)),rmO3_v2);
[T,PM10_predict_v1] = sim_lineal(table2array(PM10_all(idx,3:12)),rmPM10_v1);
[T,PM10_predict_v2] = sim_lineal(table2array(PM10_all(idx,3:12)),rmPM10_v2);

%% Visualizar los datos de la prediccion lineal
n=1;
figure(1);
plot(T,O3_all{idx,2+n},'b-',T,O3_predict_v1(:,n),'r-',T,O3_predict_v2(:,n),'g-'),grid;

figure(2);
plot(T,PM10_all{idx,2+n},'b-',T,PM10_predict_v1(:,n),'r-',T,PM10_predict_v2(:,n),'g-'),grid;


%% simulacion del modelo lineal retroalimentado con los datos de anio seleccionado

data = O3_all;
idx = year(data.FechaHora)==2015;
[T,O3_predict_retro_v1] = sim_lineal_retro(table2array(O3_all(idx,3:12)),rmO3_v1);
[T,O3_predict_retro_v2] = sim_lineal_retro(table2array(O3_all(idx,3:12)),rmO3_v2);
[T,PM10_predict_retro_v1] = sim_lineal_retro(table2array(PM10_all(idx,3:12)),rmPM10_v1);
[T,PM10_predict_retro_v2] = sim_lineal_retro(table2array(PM10_all(idx,3:12)),rmPM10_v2);

%% Visualizar los datos de la prediccion lineal
n=1;
figure(3);
plot(T,O3_all{idx,2+n},'b-',T,O3_predict_v1(:,n),'r-',T,O3_predict_retro_v1(:,n),'g-'),grid;

figure(4);
plot(T,PM10_all{idx,2+n},'b-',T,PM10_predict_v1(:,n),'r-',T,PM10_predict_retro_v1(:,n),'g-'),grid;


%% Calculo de los errores para evaluar los desempenos del predictor de O3
O3_RMSE_p_v1 = nanmean((O3_all{idx,3:12}-O3_predict_v1).^2);
O3_RMSE_p_v2 = nanmean((O3_all{idx,3:12}-O3_predict_v2).^2);
O3_RMSE_pr_v1 = nanmean((O3_all{idx,3:12}-O3_predict_retro_v1).^2);
O3_RMSE_pr_v2 = nanmean((O3_all{idx,3:12}-O3_predict_retro_v2).^2);

%% Calculo de los errores para evaluar los desempenos del predictor de PM10
PM10_RMSE_p_v1 = nanmean((PM10_all{idx,3:12}-PM10_predict_v1).^2);
PM10_RMSE_p_v2 = nanmean((PM10_all{idx,3:12}-PM10_predict_v2).^2);
PM10_RMSE_pr_v1 = nanmean((PM10_all{idx,3:12}-PM10_predict_retro_v1).^2);
PM10_RMSE_pr_v2 = nanmean((PM10_all{idx,3:12}-PM10_predict_retro_v2).^2);