---
title: Products & Markets
---

This section analyzes the characteristics of our film inventory (length and duration) and our global customer footprint.

---

## Time & Duration Analysis

### Movie Length Distribution
Understanding our film inventory's length distribution helps with scheduling.
With an average film length of 115 minutes, most of our inventory fits within standard viewing sessions.

```sql film_stats
SELECT * FROM sakila.film_stats
```

<BarChart 
    data={film_stats}
    x=category
    y=minutes
    title="Movie Statistics (Length in Minutes)"
    colorPalette={['#dc2626']}
/>

### Longest Average Rental Duration

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

## Geographic Distribution

Our global customer distribution shows strong concentration in Asian markets, 
with India and China representing our largest customer bases.
```sql registered_customers
SELECT * FROM sakila.registered_customers
```

<BarChart
data={registered_customers} 
x=country y=total_customers 
labels=true 
colorPalette={['#dc2626']}
/>