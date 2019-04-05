function [T,predict] = sim_lineal(data,rdata)
T = [1:size(data,1)]';
X = zeros(size(data));
X(1,:) = data(1,:);
for t = 1:size(T,1)-1
    % Revisar si existe el sensor
    idx = isnan(data(t,:));
    
    anio = floor(t/(168*4*13));
    group = floor((t-1-(168*4*13-1)*anio)/(168*4));
    element = mod(t,168);
    if element ==0
        element = 168;
    end
    tr = 168*group+element;
    X(t+1,~idx) = (1+rdata(tr,~idx)).*data(t,~idx);
    X(t+1,idx) = (1+rdata(tr,idx)).*X(t,idx);
end
predict=X;