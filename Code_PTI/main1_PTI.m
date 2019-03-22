%% Limpiar las variables para iniciar el analisis
clear;
close all;
clc;

%% Importar los datos de la contaminación
filename = '..\Data_PTI\O3.csv';
varnames = {'Num','FechaHora','Atemajac','Aguilas','Centro','Las_Pintas','Loma_Dorada','Miravalle','Oblatos','Santa_Fe','Tlaquepaque','Vallarta'};
O3 = read_archive(filename,varnames);
filename = '..\Data_PTI\PM10.csv';
PM10 = read_archive(filename,varnames);

%% Convertir a fechas la columna 
O3.FechaHora = parse_dates_pti(O3.FechaHora);
PM10.FechaHora = parse_dates_pti(PM10.FechaHora);

save ..\Data_PTI\tabla_O3_PM10 O3 PM10