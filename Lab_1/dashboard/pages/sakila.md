# My research



### 10 most expensive movies to rent per day

These are the movies with the highest daily rental cost based on rental rate divided by rental duration.
```sql expensive_rentals
SELECT * FROM sakila.expensive_rentals
```

<DataTable data={expensive_rentals}/>

<BarChart 
    data={expensive_rentals}
    x=title
    y=price_per_day
    swapXY=true
    title="10 Most Expensive Movies to Rent Per Day"
    colorPalette={['#dc2626']}
/>

### Top 5 customers by total spend

Our most valuable customers who we should reward with special offers.
```sql top_customers
SELECT * FROM sakila.top_customers
```
<DataTable data={top_customers}/>

<BarChart 
    data={top_customers} 
    x=full_name 
    y=total_spent
    title="Top 5 Customers by Total Spend"
    color="red"
    seriesGap=10
    colorPalette={['#16a34a']}
/>

### Top Genres

```sql revenue
SELECT * FROM sakila.revenue
```

Our most popular film categories

<DataTable data={revenue}/>

<BarChart 
    data={revenue}
    x=genre
    y=total_revenue
    yFmt=usd1k
    labels=true
    colorPalette={['#6825b6ff']}
/>