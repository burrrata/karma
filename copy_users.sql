COPY (WITH
  first_content AS (SELECT DISTINCT ON(author) author, extract(epoch from reddit_created_utc) AS firstContent FROM content ORDER BY author, reddit_created_utc ASC),
  temp_scores AS (SELECT author, sum(score) as score FROM content GROUP BY author)
SELECT username, address, score, firstContent
FROM users
LEFT JOIN first_content on first_content.author = username
LEFT JOIN temp_scores on temp_scores.author = username
WHERE address IS NOT NULL)
TO
'/tmp/users.csv'
WITH CSV HEADER;
