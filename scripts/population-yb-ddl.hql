CREATE EXTERNAL TABLE IF NOT EXISTS unsd_citypopulation_year_both (country STRING, year STRING,  area STRING,  sex STRING, city STRING,  city_type STRING, record_type STRING, reliability STRING, source_year STRING, value STRING, value_footnotes STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/population/';
