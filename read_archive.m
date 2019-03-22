function tab = read_archive(filename,varnames)
delimiter = ',';
startRow = 2;
% Format for each line of text:
formatSpec = '%f%s%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
% Open the text file.
fileID = fopen(filename,'r');
% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
% Close the text file.
fclose(fileID);
% Create output variable
tab = table(dataArray{1:end-1}, 'VariableNames', varnames);
