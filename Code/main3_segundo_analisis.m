%% Limpiar las variables para iniciar el analisis
clear;
close all;
clc;

%% Cargar los datos
load datafinal_2012.mat
data2012 = datafinal;
load datafinal_2013.mat
data2013 = datafinal;
load datafinal_2014.mat
data2014 = datafinal;
load datafinal_2015.mat
data2015 = datafinal;
load datafinal_2016.mat
data2016 = datafinal;
load datafinal_2017.mat
data2017 = datafinal;
clear datafinal

%% PM10 y O3 de los 4 años disponibles
est = 1;
idx = data2012(:,1)==est;
O3(:,1) = data2014(idx,6);
PM10(:,1) = data2014(idx,12);

idx = data2013(:,1)==est;
O3(:,2) = data2014(idx,6);
PM10(:,2) = data2014(idx,12);

idx = data2014(:,1)==est;
O3(:,3) = data2014(idx,6);
PM10(:,3) = data2014(idx,12);

idx = data2015(:,1)==est;
O3(:,4) = data2015(idx,6);
PM10(:,4) = data2015(idx,12);

idx = data2016(:,1)==est;
O3(:,5) = data2016(idx,6);
PM10(:,5) = data2016(idx,12);

idx = data2017(:,1)==est;
O3(:,6) = data2017(idx,6);
PM10(:,6) = data2017(idx,12);

clear idx

%% Obtener las mediciones de una semana del año 2014
%Ordenar la muestras por semana durante todo el año
PM10_week = [];
for k = 1:floor(size(PM10,1)/168)
    PM10_week(:,k) = PM10((k-1)*168+1:k*168,1);
end

figure(1);
plot(PM10_week);
axis([1,168,-Inf,Inf]);
xlabel('Muestras cada 1hr por periodos 7 dias');
ylabel('PM10');
title('PM10 - 2014')
grid;

% Ordenar las muestras por grupos de 4 semanas (aprox 1 mes)
figure(2);
mPM10_week = [];
for k = 1:52/4
    % Subconjunto de semanas para los promedios
    tmp = PM10_week(:,(k-1)*4+1:k*4);
    for n = 1:size(tmp,1)
        mPM10_week(n,k) = mean(tmp(n,tmp(n,:)>=0));
    end
    
    subplot(3,5,k);
    hold on;
    plot(tmp);
    plot(mPM10_week(:,k),'k--','LineWidth',2);
    hold off;
    xlabel('168 hrs');
    ylabel('PM10');
    title(sprintf('Semanas %i - %i',(k-1)*4+1,k*4));
    axis([1,168,-Inf,Inf]);
end


% %% Obtener las mediciones cada dia del año 2014
% %Ordenar la muestras por semana durante todo el año
% PM10_day = [];
% for k = 1:floor(size(PM10,1)/24)
%     PM10_day(:,k) = PM10((k-1)*24+1:k*24,1);
% end
% 
% figure(3);
% plot(PM10_day);
% axis([1,24,-Inf,Inf]);
% xlabel('1 dia (24 muestras)');
% ylabel('PM10');
% title('PM10 - 2014')
% grid;

%% Ordenar las muestras por grupos de 4 semanas (aprox 1 mes)
figure(2);
for k = 1:52/4
    subplot(3,5,k);
    hold on;
    %plot(PM10_week(:,(k-1)*4+1:k*4));
    plot(mean(PM10_week(:,(k-1)*4+1:k*4),2),'k-','LineWidth',2);
    hold off;
    xlabel('168 hrs');
    ylabel('PM10');
    title(sprintf('Semanas %i - %i',(k-1)*4+1,k*4));
    axis([1,168,-Inf,Inf]);
end

%% Obtener los incrementos porcentuales
tmp = reshape(mPM10_week,168*13,1);
tmp = [tmp;tmp(1)];
rtmp = (tmp(2:end)./tmp(1:end-1))-1;
rmPM10_week = reshape(rtmp,size(mPM10_week));
clear tmp rtmp
%rmPM10_week = mPM10_week(2:end,:)./mPM10_week(1:end-1,:)-1;

%% Guardar los datos importantes del análisis
save data_mean_2014 rmPM10_week mPM10_week PM10_week PM10 O3

