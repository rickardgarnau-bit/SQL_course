# My research

## Executive Summary

This analysis examines our DVD rental business performance across multiple dimensions: 
inventory pricing, customer behavior, revenue generation, and geographic distribution.

---

## Detailed Analysis

### 10 Movies With Longest Average Rental Duration

These are the movies that customers keep the longest on average, indicating high engagement and rewatchability.

```sql longest_rent
SELECT * FROM sakila.longest_rent
```

<BarChart 
    data={longest_rent}
    x=title
    y=avg_rental_days
    swapXY=true
    title="Top 10 Movies by Average Rental Duration (Days)"
    colorPalette={['#dc2626']}
/>

---

## Customer Value Analysis

Now that we understand our premium inventory, let's identify our most valuable 
customers. These insights help us design targeted loyalty programs and special offers 
to retain our best clients.

### Top 5 customers by total spend

Our most valuable customers who we should reward with special offers.

```sql top_customers
SELECT * FROM sakila.top_customers
```

<BarChart 
    data={top_customers} 
    x=full_name 
    y=total_spent
    title="Top 5 Customers by Total Spend"
    seriesGap=10
    colorPalette={['#16a34a']}
/>

---

### Top Genres

Understanding which genres generate the most revenue helps us make smarter
inventory purchasing decisions. Sports films lead our revenue at $5,314, 
suggesting strong customer demand in this category.


```sql revenue
SELECT * FROM sakila.revenue
```

<BarChart 
    data={revenue}
    x=genre
    y=total_revenue
    yFmt=usd1k
    labels=true
    colorPalette={['#6825b6ff']}
/>

---

### Country with most customers

Our global customer distribution shows strong concentration in Asian markets, 
with India and China representing our largest customer bases.
```sql registered_customers
SELECT * FROM sakila.registered_customers
```


<BarChart 
    data={registered_customers}
    x=country
    y=total_customers
    labels=true
    colorPalette={['#bb3006ff']}
/>


---

### Movie Length Analysis

Understanding our film inventory's length distribution helps with scheduling and 
customer expectations. With an average film length of 115 minutes and longest at 
185 minutes, most of our inventory fits within standard viewing sessions.
```sql film_stats
SELECT * FROM sakila.film_stats
```

<BarChart 
    data={film_stats}
    x=category
    y=minutes
    title="Movie Statistics (Length in Minutes)"
    colorPalette={['#eb5752']}
/>