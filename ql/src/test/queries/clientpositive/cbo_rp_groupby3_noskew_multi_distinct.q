--! qt:dataset:src
set hive.cbo.returnpath.hiveop=true;
set hive.map.aggr=false;
set hive.mapred.mode=nonstrict;
set hive.groupby.skewindata=false;
set mapred.reduce.tasks=31;

CREATE TABLE dest1_n123(c1 DOUBLE, c2 DOUBLE, c3 DOUBLE, c4 DOUBLE, c5 DOUBLE, c6 DOUBLE, c7 DOUBLE, c8 DOUBLE, c9 DOUBLE, c10 DOUBLE, c11 DOUBLE) STORED AS TEXTFILE;

EXPLAIN
FROM src
INSERT OVERWRITE TABLE dest1_n123 SELECT
  sum(substr(src.value,5)),
  avg(substr(src.value,5)),
  avg(DISTINCT substr(src.value,5)),
  max(substr(src.value,5)),
  min(substr(src.value,5)),
  std(substr(src.value,5)),
  stddev_samp(substr(src.value,5)),
  variance(substr(src.value,5)),
  var_samp(substr(src.value,5)),
  sum(DISTINCT substr(src.value, 5)),
  count(DISTINCT substr(src.value, 5));

FROM src
INSERT OVERWRITE TABLE dest1_n123 SELECT
  sum(substr(src.value,5)),
  avg(substr(src.value,5)),
  avg(DISTINCT substr(src.value,5)),
  max(substr(src.value,5)),
  min(substr(src.value,5)),
  std(substr(src.value,5)),
  stddev_samp(substr(src.value,5)),
  variance(substr(src.value,5)),
  var_samp(substr(src.value,5)),
  sum(DISTINCT substr(src.value, 5)),
  count(DISTINCT substr(src.value, 5));

SELECT dest1_n123.* FROM dest1_n123;


CREATE TABLE test (col1 INT, col2 INT);
INSERT INTO test VALUES (1, 100), (2, 200), (2, 200), (3, 300);

EXPLAIN
SELECT
  SUM(DISTINCT col1),
  COUNT(DISTINCT col1),
  SUM(col2), -- This has to refer to the key for `SUM(DISTINCT col2)`
  MAX(DISTINCT col1),
  SUM(DISTINCT col2),
  MIN(DISTINCT col1)
FROM test;

SELECT
  SUM(DISTINCT col1),
  COUNT(DISTINCT col1),
  SUM(col2), -- This has to refer to the key for `SUM(DISTINCT col2)`
  MAX(DISTINCT col1),
  SUM(DISTINCT col2),
  MIN(DISTINCT col1)
FROM test;
