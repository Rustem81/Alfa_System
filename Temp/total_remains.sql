select
    t.*,
    (NQUANTITYIN - NQUANTITYOUT) as saldo,
    coalesce(
        sum(t.NQUANTITYIN) over (
            order by
                t.DCONTROLDATE rows between unbounded preceding
                and current row
        ),
        0
    ) as total_in,
    coalesce(
        sum(t.NQUANTITYOUT) over (
            order by
                t.DCONTROLDATE rows between unbounded preceding
                and current row
        ),
        0
    ) as total_out,
    coalesce(
        sum(t.NQUANTITYIN - t.NQUANTITYOUT) over (
            order by
                t.DCONTROLDATE rows between unbounded preceding
                and current row
        ),
        0
    ) as total_remains
from
    tst_simpletable t
where
    SPRODUCTNAME = 'ibmdb2_bug'
order by
    DCONTROLDATE;

-----------
select
    t.id,
    t.sproductname,
    t.dcontroldate,
    coalesce(
        sum(t.NQUANTITYIN - t.NQUANTITYOUT) over (
            PARTITION BY
                SPRODUCTNAME
            order by
                t.DCONTROLDATE
        ),
        0
    ) as total_remains
from
    tst_simpletable t
ORDER BY
    SPRODUCTNAME,
    DCONTROLDATE