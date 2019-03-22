% Simulacion de la propuesta de predictor. El predictor es un observador de
% Luemberger con retroalimentación según la medición actual

clear;
close all;
clc;

load data_mean_2014.mat;

%% Simulación del modelo lineal sin corrección del error
% Estructura del modelo x(t+1) = a(t)x(t)
% a(t) es el promedio de 4 semanas en la misma hora
% x(t) es el valor del contaminante determinado por el modelo

x = PM10(1,1); %x(0) valor inicial del modelo

a = [];
for m = 1:size(rmPM10_week,2)
    for k = 1:4
        a = [a; rmPM10_week(:,m)];
    end
end

for t = 1:size(a,1)
    x(t+1) = (1+a(t))*x(t);
end


figure(1);
t = 1:size(a,1);
plot(t,PM10(t,1),'b-',t,x(t),'r--');
grid;


%% Simulación del modelo lineal con corrección del error
% Estructura del modelo x(t+1) = a(t)x(t) + Lx(t)
% a(t) es el promedio de 4 semanas en la misma hora
% x(t) es el valor del contaminante determinado por el modelo

x = PM10(1,1); %x(0) valor inicial del PM10
L = 0.5; % constante de retroalimentación

a = [];
for m = 1:size(rmPM10_week,2)
    for k = 1:4
        a = [a; rmPM10_week(:,m)];
    end
end

for t = 1:size(a,1)
    if PM10(t,1)<0
        x(t+1) = (1+a(t))*x(t);
    else
        x(t+1) = (1+a(t))*x(t)+L*(PM10(t,1)-x(t));
    end
end


figure(2);
t = 1:size(a,1);
plot(t,PM10(t,1),'b-',t,x(t),'r--','LineWidth',1.5);
grid;

% Medicion del error cuadratico medio
tmp = PM10(t,1);
idx = tmp>=0;
emc = mean((tmp(idx,1)-x(1,idx)').^2);

%% Simulación del modelo lineal con corrección del error
% Estructura del modelo x(t+1) = a(t)x(t) + Lx(t)
% a(t) es el promedio de 4 semanas en la misma hora
% x(t) es el valor del contaminante determinado por el modelo

year = 4;
x = PM10(1,year); %x(0) valor inicial del PM10
L = 0.9;% constante de retroalimentación

a = [];
for m = 1:size(rmPM10_week,2)
    for k = 1:4
        a = [a; rmPM10_week(:,m)];
    end
end

for t = 1:size(a,1)
    if PM10(t,year)<0
        x(t+1) = (1+a(t))*x(t);
    else
        x(t+1) = (1+a(t))*x(t)+L*(PM10(t,year)-x(t));
    end
end


figure(3);
t = 1:size(a,1);
plot(t,PM10(t,year),'b-',t,x(t),'r--','LineWidth',1.5);
grid;

% Medicion del error cuadratico medio
tmp = PM10(t,year);
idx = tmp>=0;
emc = mean((tmp(idx,1)-x(1,idx)').^2);