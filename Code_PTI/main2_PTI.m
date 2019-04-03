load tabla_O3_PM10.mat

%%Obtener las mediciones de una semana de los años 2014 y 2015
PM10_week = [];
O3_week = [];

%%Separar training data de testing data

%Tomar el mes JAN 
%tomar todos los Lunes 
%tomar todas las 00:00

%dates = PM10(:, 2)


DateTable_PM10=[];
DateTable_O3=[];

mean_PM10 = [];
mean_O3 = [];

t1 = datetime(2015,1,1,0,0,0); 
t2 = datetime(2015,12,31,23,0,0);
t3 = datetime(2015, 1, 7, 23,0,0);

weekDay = t1: hours(1) :t3;
months = t1:calmonths(1):t2;
 
PM10_iterate = PM10;
O3_iterate = O3;

for m = 1: 12
    for wd = 1: 7
        for hr = 0:23
            for index = 1:size(PM10_iterate)
                if(month(PM10_iterate{index,{'FechaHora'}})==m ...
                    && weekday(PM10_iterate{index,{'FechaHora'}})==wd ...
                    && hour(PM10_iterate{index,{'FechaHora'}})==hr ...
                    && (year(PM10_iterate{index,{'FechaHora'}})==2015 ...
                    || year(PM10_iterate{index,{'FechaHora'}})==2016))
                        aux_PM10 = PM10_iterate(index, 3:12);
                        aux_O3 = PM10_iterate(index, 3:12);
                        DateTable_PM10 = [DateTable_PM10;aux_PM10];
                        DateTable_O3 = [DateTable_O3;aux_O3];
                        %delete rows to decrease time
                        PM10_iterate(index, :) = [];
                        O3_iterate(index, :) = [];
                end
                if(size(DateTable_PM10)>4)
                    break;
                end
            end
            aux_mean_PM10 = nanmean(DateTable_PM10{:,:});
            aux_mean_O3 = nanmean(DateTable_PM10{:,:});
            mean_PM10 = [mean_PM10;aux_mean_PM10];
            mean_O3 = [mean_PM10; aux_mean_O3];
            %clear data
            DateTable_PM10 = [];
            DateTable_O3 = [];
            aux_mean_PM10 = [];
            aux_mean_O3 = []; 
        end
   end
    %sacar 1 semana promedio de ambos años por mes   
end

%% PM10 y O3
toc;
save mean_PM10 mean_O3 