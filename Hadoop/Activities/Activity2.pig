-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/sarojini/input.txt' AS (line:chararray);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the number of word (Reduce)
cntd = FOREACH grpd GENERATE $0 AS word, COUNT($1) AS wordcount;
-- Remove the old folder
rmf hdfs:///user/sarojini/pigOutput1
-- Store the result in HDFS
STORE cntd INTO 'hdfs:///user/sarojini/pigOutput1';
