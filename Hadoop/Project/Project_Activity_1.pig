-- Load data from HDFS
inputDialouges4 = LOAD 'hdfs:///user/sarojini/inputs/episodeIV_dialogues.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);
inputDialouges5 = LOAD 'hdfs:///user/sarojini/inputs/episodeV_dialogues.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);
inputDialouges6 = LOAD 'hdfs:///user/sarojini/inputs/episodeVI_dialogues.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);

--Filter out first 2 lines from each file
ranked4 = RANK inputDialouges4;
OnlyDialouges4 = FILTER ranked4 BY (rank_inputDialouges4 > 2);
ranked5 = RANK inputDialouges5;
OnlyDialouges5 = FILTER ranked4 BY (rank_inputDialouges5 > 2);
ranked4 = RANK inputDialouges6;
OnlyDialouges6 = FILTER ranked4 BY (rank_inputDialouges6 > 2);

--Merge the three inputs
inputData = UNION OnlyDialouges4, OnlyDialouges5, OnlyDialouges6;

--Group by name
groupByname = GROUP inputData BY name;

--count the number of lines by each character
names = FOREACH groupByname GENERATE $0 AS name, COUNT($1) AS no_of_lines;
namesOrdered = ORDER names BY no_of_lines DESC;

--Remove the outputs folder
rmf hdfs:///user/sarojini/outputs;

--Store the results in HDFS
STORE namesOrdered INTO 'hdfs:///user/sarojini/outputs' USING PigStorage('\t');  
