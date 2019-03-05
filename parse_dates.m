function res = parse_dates(x)  
    if ~isnan(x)
        if length(x)==10
            res = [x ' 00:00:00'];
        else
            if strfind(x,'p.')>0
                tmp =str2double(x(12:13));
                x(12:13)=num2str(12 + mod(tmp,12));
                res = x(1:19);
            else 
                if x>=40908
                    % 41275 es el 1 de enero de 2013
%                     t1 = datetime(2012, 1, 1, 0, 0, 0);
%                     aux_date = x-40909;
%                     date=t1+caldays(0:aux_date);
%                     date = date(end);
                    aux_date = x+datetime(1899, 12, 30, 0,0,0);
                    x = datestr(aux_date, 'dd/mm/yyyy HH:MM:ss');
                    res = x(1:19);
                else 
                    t1 = datetime(1997, 1, 1, 0, 0, 0);
                    x = datestr(t1, 'dd/mm/yyyy HH:MM:ss');
                    res = x(1:19);  
                end    
            end
            
        end
    else
        
    end
    
end