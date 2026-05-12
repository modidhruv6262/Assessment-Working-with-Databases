SELECT 
    r.restaurant_id,
    r.name,
    l.location_name,
    
    (r.online_order + r.book_table) AS digital_readiness_score,
    
    r.approx_cost_for_two,
    CASE 
        WHEN r.approx_cost_for_two < 500 THEN 'Budget'
        WHEN r.approx_cost_for_two BETWEEN 500 AND 1200 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS price_tier,
    
    (rt.rate * LOG10(NULLIF(rt.votes, 0) + 1)) AS weighted_demand_score,
    
    COUNT(r.restaurant_id) OVER(PARTITION BY r.location_id) AS neighborhood_competition_index,
    
    r.approx_cost_for_two - AVG(r.approx_cost_for_two) OVER(PARTITION BY r.location_id) AS local_price_variance

FROM restaurants r
JOIN locations l ON r.location_id = l.location_id
JOIN ratings rt ON r.restaurant_id = rt.restaurant_id
WHERE rt.rate IS NOT NULL
ORDER BY weighted_demand_score DESC;