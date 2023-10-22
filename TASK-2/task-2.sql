SET STATISTICS TIME ON;

WITH sub_tree (id, name, parent_id, level) AS (
    SELECT id, name, parent_id, 1 AS level
    FROM subdivisions
    WHERE id = (SELECT subdivision_id FROM collaborators WHERE id = 710253)
    UNION ALL
    SELECT s.id, s.name, s.parent_id, st.level + 1
    FROM subdivisions s
    INNER JOIN sub_tree st ON s.parent_id = st.id
    WHERE s.id NOT IN (100055, 100059)
),
colls_in_sub AS (
    SELECT subdivision_id, COUNT(*) AS colls_count
    FROM collaborators
    GROUP BY subdivision_id
)
SELECT c.id, c.name, st.name AS sub_name, st.id AS sub_id, st.level AS sub_level, cs.colls_count
FROM collaborators c
JOIN sub_tree st ON c.subdivision_id = st.id
LEFT JOIN colls_in_sub cs ON c.subdivision_id = cs.subdivision_id
WHERE LEN(c.name) > 11 AND c.age < 40
ORDER BY st.level;

SET STATISTICS TIME OFF;