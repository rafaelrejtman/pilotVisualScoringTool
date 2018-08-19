% Importing Data from TSV File
% Script for importing data from TSV file.
% Script based on the one from: https://www.mathworks.com/matlabcentral/answers/267176-read-and-seperate-csv-data#answer_209938
% Improve Performance: remove "str2double"!!

function rawGazeTable = getRGTfromTSV(input_file)

%% Detecting File Enconding

[file_encoding, bytes_per_char, BOM_size, bytes2char] = detect_UTF_encoding(input_file);

if isempty(file_encoding)
   error('No usable input file');
end

%% Importing Data

fid = fopen(input_file,'rt'); % rt stands for read (as text)
fread(fid, [1, BOM_size], '*uint8');   %skip the Byte Order Mark
thisbuffer = fgets(fid);
extra = mod(length(thisbuffer), bytes_per_char);

if extra ~= 0
  %in little-endian modes, newline would be found in first byte and the 0's after need to be read
  thisbuffer = [thisbuffer, fread(fid, [1, bytes_per_char - extra], '*uint8')];
end

thisline = bytes2char(thisbuffer);
data_cell = textscan(thisline, '%s', 'delimiter', '\t');   %will ignore the end of lines
header_fields = reshape(data_cell{1}, 1, []);
num_field = length(header_fields);
thisbuffer = fread(fid, [1 inf], '*uint8');
extra = mod(length(thisbuffer), bytes_per_char);

if extra ~= 0
  thisbuffer = [thisbuffer, zeros(1, bytes_per_char - extra, 'uint8')];
end

% Removing Spacing from Headers

% for i=1:num_field
%     thisString = header_fields{1,i};
%     thisString = thisString(find(~isspace(thisString)));
%     thisString = thisString(1:9);
%     header_fields{1,i} = thisString;
% end

%% Formatting Data

my_header = {'RecName';'RecDur';'TimeStamp';'EyeMoveType';'AutoMapScore';'AutoMapX';'AutoMapY'};

thisline = bytes2char(thisbuffer);
fmt = repmat('%s', 1, num_field);
%fmt = {'%s';'%f';'%f';'%s';'%f';'%f';'%f';'%f';'%f';'%f';'%f';'%f';'%f';'%f';'%f';'%f'};
data_cell = textscan(thisline, fmt, 'delimiter', '\t');
data_fields_text = horzcat(data_cell{:});
data_fields = data_fields_text;
data_fields(:,2) = num2cell(str2double(data_fields_text(:,2)));
data_fields(:,3) = num2cell(str2double(data_fields_text(:,3)));
data_fields(:,5) = num2cell(str2double(data_fields_text(:,5)));
data_fields(:,6) = num2cell(str2double(data_fields_text(:,6)));
data_fields(:,7) = num2cell(str2double(data_fields_text(:,7)));
% data_fields(:,8) = num2cell(str2double(data_fields_text(:,8)));
% data_fields(:,9) = num2cell(str2double(data_fields_text(:,9)));
% data_fields(:,10) = num2cell(str2double(data_fields_text(:,10)));
% data_fields(:,11) = num2cell(str2double(data_fields_text(:,11)));
% data_fields(:,12) = num2cell(str2double(data_fields_text(:,12)));
% data_fields(:,13) = num2cell(str2double(data_fields_text(:,13)));
% data_fields(:,14) = num2cell(str2double(data_fields_text(:,14)));
% data_fields(:,15) = num2cell(str2double(data_fields_text(:,15)));
% data_fields(:,16) = num2cell(str2double(data_fields_text(:,16)));
rawGazeTable = cell2table(data_fields, 'VariableNames', my_header);

end
