show databases;
use sakila;
desc customer;
desc address;

select
    c.first_name,
    c.last_name,
    a.address
from customer c
    join address a;

select
    c.first_name,
    c.last_name,
    a.address
from customer c join address a
on c.address_id = a.address_id;

select
    c.first_name,
    c.last_name,
    a.address
from customer c inner join address a using (address_id);

select customer.customer_id,
       customer.first_name,
       customer.last_name,
       customer.address_id,
       address.address,
       address.address_id
from customer inner join address
on customer.address_id = address.address_id
where address.postal_code = 52137;


-- Only ustomers whose postal code is 52137 in SQL92 Syntax (most used)
select
    c.first_name,
    c.last_name,
    a.address
from customer c inner join address a
on c.address_id = a.address_id
where a.postal_code = 52137;

