load tabla_O3_PM10.mat

%%Obtener las mediciones de una semana de los años 2014 y 2015
PM10_week = [];
O3_week = [];

%Separar training data de testing data
train_size = 17545;%registro de años 2015-2016
PM10_train = PM10(1:train_size-1, :);   
PM10_test = PM10(train_size:end, :);

O3_train = O3(1:train_size-1, :);
O3_test = O3(train_size:end, :);

%% 
DateTable_PM10=[];
DateTable_O3=[];

mean_PM10 = [];
mean_O3 = [];

t1 = datetime(2015,1,1,0,0,0); 
t2 = datetime(2015,12,31,23,0,0);
t3 = datetime(2015, 1, 7, 23,0,0);

weekDay = t1: hours(1) :t3;
months = t1:calmonths(1):t2;
 
PM10_iterate = PM10_train;
O3_iterate = O3_train;

n=size(PM10_iterate);

for m = 1: 12
    for wd = 1: 7
        for hr = 0:23
            for index = 1:n
                if(month(PM10_iterate{index,{'FechaHora'}})==m ...
                    && weekday(PM10_iterate{index,{'FechaHora'}})==wd ...
                    && hour(PM10_iterate{index,{'FechaHora'}})==hr ...
                    && (year(PM10_iterate{index,{'FechaHora'}})==2015 ...
                    || year(PM10_iterate{index,{'FechaHora'}})==2016))
                        aux_PM10 = PM10_iterate(index, 3:12);
                        aux_O3 = O3_iterate(index, 3:12);
                        DateTable_PM10 = [DateTable_PM10;aux_PM10];
                        DateTable_O3 = [DateTable_O3;aux_O3];
                        %delete rows to decrease time
                        PM10_iterate(index, :) = [];
                        O3_iterate(index, :) = [];
                        index=index-1;
                end
                n_dt = size(DateTable_PM10);
                n_PM10 = size(PM10_iterate);
                if(n_dt(2)>10 || index>=n_PM10(1))
                    break;
                end
            end
            aux_mean_PM10 = nanmean(DateTable_PM10{:,:});
            aux_mean_O3 = nanmean(DateTable_O3{:,:});
            mean_PM10 = [mean_PM10;aux_mean_PM10];
            mean_O3 = [mean_O3; aux_mean_O3];
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
save mean_tables mean_PM10 mean_O3 