with
    data_set --остатки за каждый день
    as (
        select
            sproductname,
            dcontroldate,
            coalesce(
                sum(NQUANTITYIN - NQUANTITYOUT) over (
                    PARTITION BY
                        SPRODUCTNAME
                    order by
                        DCONTROLDATE
                ),
                0
            ) as total_remains
        from
            tst_simpletable
        where
            dcontroldate BETWEEN TO_DATE(:p_start_data, 'DD.MM.YYYY') AND TO_DATE(:p_end_data, 'DD.MM.YYYY')
        ORDER BY
            SPRODUCTNAME,
            DCONTROLDATE
    ),
    cld --  подзапрос с датами
    as (
        SELECT
            to_date(:p_start_data, 'DD.MM.YYYY') + level -1 as DCONTROLDATE
        FROM
            dual
        CONNECT BY level <= to_date(:p_end_data, 'DD.MM.YYYY') - to_date(:p_start_data, 'DD.MM.YYYY') + 1
    ),
    start_item -- первый приход 
    as (
        select
            min(DCONTROLDATE) as min_dt,
            SPRODUCTNAME
        from
            data_set
        group by
            SPRODUCTNAME
    ),
    date_item --расширенный календарь 
    as (
        select
            cld.DCONTROLDATE,
            start_item.SPRODUCTNAME
        from
            cld
            left join start_item on cld.DCONTROLDATE >= start_item.min_dt
    )
select
    date_item.DCONTROLDATE,
    nvl(date_item.SPRODUCTNAME, 'нет данных') as SPRODUCTNAME,
    last_value(data_set.TOTAL_REMAINS ignore nulls) over (
        partition by
            date_item.SPRODUCTNAME
        order by
            date_item.DCONTROLDATE
    ) as TOTAL_REMAINS
from
    date_item
    left join data_set on date_item.SPRODUCTNAME = data_set.SPRODUCTNAME
    and date_item.DCONTROLDATE = data_set.DCONTROLDATE
order by
    1,
    2;