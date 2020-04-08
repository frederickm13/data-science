--Remove duplicate records
delete from movies_details
where id in (
    select id
    from movies_details
    where id in (
        select id
        from movies_details
        group by id
        having count(id) > 1
    )
    group by id)
AND popularity in (
    select min(popularity)
    from movies_details
    where id in (
        select id
        from movies_details
        group by id
        having count(id) > 1
    )
    group by id
);