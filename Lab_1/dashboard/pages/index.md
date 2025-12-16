---
title: Executive Sales Overview
---

This analysis examines our DVD rental business performance, focusing on **revenue generation** and **customer value**.
The visualizations below are built with Evidence.dev based on templates from the course material.

```sql revenue_trend
SELECT * FROM sakila.revenue_trend
```

<!-- https://docs.evidence.dev/components/charts/line-chart -->
<LineChart 
    data={revenue_trend} 
    x=sales_month y=total_sales 
    yFmt=usd 
    title="Monthly Revenue Trend" 
    markers=true
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
    colorPalette={['#16a34a']}
/>

---

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






