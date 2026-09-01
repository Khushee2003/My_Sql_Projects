SELECT * FROM random_tables.pelicanstore;

# Which gender gives the maximum sales
SELECT sum(sales) From pelicanstore
WHERE Gender = "Female";

SELECT sum(sales) From pelicanstore
WHERE Gender = "male";

# Which age group and gender gives the maximum sales
SELECT MAX(sales) as sales, age, gender From pelicanstore
group by age, gender
order by Sales desc limit 5;

# what is the highest discount given to females
SELECT * FROM pelicanstore
WHERE gender ="Female"
order by Discount desc;

# What is the avg discount given to female in the store
SELECT AVG(Discount) FROM pelicanstore
WHERE gender ="Female"
order by Discount desc;