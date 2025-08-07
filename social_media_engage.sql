CREATE TABLE social_media_engagement (
	post_id int,
	platform varchar(50),
	post_type varchar(50),
	post_time timestamp,
	likes int,
	comments int,
	shares int,
	post_day varchar(50),
	sentiment_score varchar(50)
);


-- View everything from table

SELECT * 
FROM social_media_engagement;


-- Duplicate check (none)

SELECT post_id, platform, post_type, post_time, likes, comments, shares, post_day, sentiment_score, COUNT(*) 
FROM social_media_engagement
GROUP BY post_id, platform, post_type, post_time, likes, comments, shares, post_day, sentiment_score
HAVING COUNT(*) > 1;


-- Null check (none)

SELECT *
FROM social_media_engagement;

SELECT sentiment_score
FROM social_media_engagement
WHERE sentiment_score IS NULL;


-- Begin Data Exploration 

SELECT *
FROM social_media_engagement;


-- Which platform has the most engagement?

SELECT platform, SUM(likes + comments + shares) AS total_engagement
FROM social_media_engagement
GROUP BY platform
ORDER BY total_engagement DESC;


-- What type of posts get the most likes?

SELECT post_type, likes
FROM social_media_engagement
GROUP BY post_type, likes
ORDER BY likes DESC
LIMIT 5;


-- Least engaged posts?

SELECT post_type, SUM(likes + comments + shares) AS total_engagement
FROM social_media_engagement
GROUP BY post_type
ORDER BY post_type ASC;


-- What time of day are most posts made?

SELECT CASE
	WHEN EXTRACT(HOUR FROM post_time) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 17 AND 23 THEN 'Evening'
    ELSE 'Night'
  END AS time_of_day,
  COUNT(*) AS post_count
FROM social_media_engagement
GROUP BY time_of_day
ORDER BY post_count DESC;


-- Difference in engagement between weekdays and weekends?

SELECT CASE 
    WHEN EXTRACT(DOW FROM post_time) IN (0, 6) THEN 'Weekend'
    ELSE 'Weekday'
	END AS day_type,
	AVG(likes) AS avg_likes,
  	AVG(comments) AS avg_comments,
  	AVG(shares) AS avg_shares
FROM social_media_engagement
GROUP BY day_type;

SELECT *
FROM social_media_engagement;


-- Which day of the week sees the most engagement per platform?

SELECT 
  platform,
  TO_CHAR(post_time, 'Day') AS day_name,
  SUM(likes + comments + shares) AS total_engagement
FROM social_media_engagement
GROUP BY platform, day_name
ORDER BY platform, total_engagement DESC;


-- Do certain post times lead to higher engagement?

SELECT platform, CASE 
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 5 AND 11 THEN '5AM - 11AM'
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 12 AND 16 THEN '12PM - 4PM'
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 17 AND 21 THEN '5PM - 9PM'
    ELSE '10PM - 4AM'
  	END AS time_of_day,
	COUNT(*) AS post_count,
  	AVG(likes + comments + shares) AS avg_engagement,
  	SUM(likes + comments + shares) AS total_engagement
FROM social_media_engagement
GROUP BY platform, time_of_day
ORDER BY total_engagement DESC;


-- Which post types are becoming more or less popular over time?

SELECT *
FROM social_media_engagement;

SELECT post_type, SUM(likes + comments + shares) AS total_engagement
FROM social_media_engagement
GROUP BY post_type
ORDER BY total_engagement ASC;

