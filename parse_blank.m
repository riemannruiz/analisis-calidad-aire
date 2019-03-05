function res = parse_blank(x)
    x = strrep(x,'Temperatura','Temp Ext');
    x = strrep(x,'TMP','Temp Ext');
    x = strrep(x,'Humedad relativa ','RH');
    x = strrep(x,'HR ','RH');
    x = strrep(x,'Velocidad de viento ','WS');
    x = strrep(x,'Dirección de vientos ','WD');
    x = strrep(x, '12:WD', 'WD');
    x = strrep(x,'Radiación solar','Rad Solar');
    x = strrep(x, '1:O3', 'O3');
    x = strrep(x, '3:NO2', 'NO2');
    x = strrep(x, '5:SO2', 'SO2');
    x = strrep(x, '6:CO', 'CO');
    x = strrep(x, '7:PM10', 'PM10');
    x(strfind(x,' ')) = '';
    res = x;
end