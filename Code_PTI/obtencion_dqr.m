%% Initialize variables. Especificar el archivo al que se le aplciar� el estudio de calidad
% Ruta del archivo
%filename = '..\Data_PTI\PM10.csv'; 
filename = '..\Data_PTI\O3.csv'; 

%% Lectura del archivo
data = readtable(filename);

%% Generaci�n del estudio de calidad
tab_dqr = dqr(data);
