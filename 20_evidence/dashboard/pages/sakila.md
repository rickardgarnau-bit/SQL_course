# Exploring Sakila database

## Films in Sakila

```sql films
select
title,
description,
rating,
length,
release_year
from sakila.film;

```

## Top customer

```sql rental
select 
customer,
sum(amount) as total_amount,
count(*) as number_of_rentals
from sakila.rental_customer
group by customer_id, customer,
order by total_amount desc, number_of_rentals desc
limit 10;
```

<BarChart
    data={rental}
    title="Top customers measured by total amount paid"
    x=customer
    y=total_amount
    swapXY = true
/>

```sql rent
from sakila.rental_customer;
```

## Analyzing payments

Choose your store

<Dropdown data={rent} name=store value=store_id
title="select a store" defaultValue="1">
</Dropdown>

You have picked store {inputs.store.value}

```sql customer
select
date_trunc('day', payment_date) as pay_date,
sum(amount) as total_amount
from sakila.rental_customer
where
store_id = ${inputs.store.value} and payment_date between 
'2005-05-01' and '2005-09-01'
group by pay_date

```

<LineChart
data={customer}
x = pay_date
y = total_amount
xAxisTitle="total amount"
yAxisTitle="payment date"
title="payment over time for store {inputs.store.value}"
/>