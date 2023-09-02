SELECT user_id FROM users WHERE user_id = 1;
select * from (select * from example_table) sample (1) seed (99);

select *
   from (
         select *
            from t1 join t2
               on t1.a = t2.c
        ) sample (1);

SELECT * FROM testtable SAMPLE (10 ROWS);