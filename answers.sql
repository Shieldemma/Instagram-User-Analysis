- -Instagram User Analytics
--Description
--User analysis is the process by which we track how users engage and interact with our digital product (software or mobile application)
--This is done to derive buiness insights for marketing, product and development teams
- -1. Find the oldest users of the instagram from the datatbase provided
USE ig_clone; -- Use the ig_clone database

SELECT TOP 5 *
FROM dbo.users
ORDER BY created_at;

id  username            created_at
80	Darby_Herzog	    2016-05-06 00:14:21.190
67	Emilio_Bernier52	2016-05-06 13:04:29.960
63	Elenor88	        2016-05-08 01:30:40.677
95	Nicole71	        2016-05-09 17:30:22.370
38	Jordyn.Jacobson2	2016-05-14 07:56:25.837

- -2.Find users who have not posted a single photo on instagram.
USE ig_clone; -- Use the ig_clone database

SELECT u.*
FROM dbo.users u
LEFT JOIN dbo.photos p ON [u.id](http://u.id/) = p.user_id
WHERE [p.id](http://p.id/) IS NULL;

id  username           image_url
5	Aniya_Hackett	    NULL
7	Kasandra_Homenick	NULL
14	Jaclyn81	        NULL
21	Rocio33	            NULL
24	Maxwell.Halvorson	NULL
25	Tierra.Trantow	    NULL
34	Pearl7	            NULL
36	Ollie_Ledner37	    NULL
41	Mckenna17	        NULL
45	David.Osinski47	    NULL
49	Morgan.Kassulke	    NULL
53	Linnea59	        NULL
54	Duane60         	NULL
57	Julien_Schmidt	    NULL
66	Mike.Auer39      	NULL
68	Franco_Keebler64	NULL
71	Nia_Haag	        NULL
74	Hulda.Macejkovic	NULL
75	Leslie67	        NULL
76	Janelle.Nikolaus81	NULL
80	Darby_Herzog	    NULL
81	Esther.Zulauf61  	NULL
83	Bartholome.Bernhard	NULL
89	Jessyca_West	    NULL
90	Esmeralda.Mraz57	NULL
91	Bethany20	        NULL

- -3.identify the winner of the contest and provide their details to the team

USE ig_clone; -- Use the ig_clone database

- - Selecting the top user with the most likes on a single photo
SELECT TOP 5 [u.id](http://u.id/), u.username, [p.id](http://p.id/) AS photo_id, MAX(l.total_likes) AS max_likes
FROM dbo.users u
JOIN dbo.photos p ON [u.id](http://u.id/) = p.user_id
JOIN (
-- Subquery to calculate total likes per photo
SELECT photo_id, COUNT(user_id) AS total_likes
FROM dbo.likes
GROUP BY photo_id
) l ON [p.id](http://p.id/) = l.photo_id
GROUP BY [u.id](http://u.id/), u.username, [p.id](http://p.id/)
ORDER BY MAX(l.total_likes) DESC;

id  username        photos_id max_likes
52	Zack_Kemmer93	145	      48
65	Adelle96	    182	      43
46	Malinda_Streich	127	      43
44	Seth46	        123       42
63	Elenor88	    174	      41

- -4.Identify and suggest 5 commonly used hashtags on the platform

USE ig_clone; -- Use the ig_clone database

SELECT TOP 10 tag_name, COUNT(*) AS tag_count
FROM tags t
JOIN photo_tags pt ON [t.id](http://t.id/) = pt.tag_id -- Assuming a table photo_tags associates tags with posts
GROUP BY tag_name
ORDER BY COUNT(*) DESC;

tag_name  tag_count
smile	    59
beach	    42
party	    39
fun	        38
lol	        24
food	    24
concert	    24
hair	    23
happy	    22
dreamy	    20

- -5 What day of the week do most users register on? Provide insights on when to schedule ads campaign
USE ig_clone; -- Use the ig_clone database

SELECT DATEPART(WEEKDAY, created_at) AS registration_day,
DATENAME(WEEKDAY, created_at) AS day_name,
COUNT(*) AS registrations_count
FROM users
GROUP BY DATEPART(WEEKDAY, created_at), DATENAME(WEEKDAY, created_at)
ORDER BY registrations_count DESC;

registration_day    day_name   registration_count
1	            Sunday	          16
5	            Thursday	      16
6	            Friday	          15
2           	Monday	          14
3          	Tuesday	          14
4          	Wednesday	      13
7            	Saturday	      12

- -6 Provide how many times does the average user post on instagram, also provide the total number of photos on instagram/total number of users

USE ig_clone; -- Use the ig_clone database

SELECT
COUNT(*) AS total_photos,
COUNT(DISTINCT user_id) AS total_users,
COUNT(*) * 1.0 / COUNT(DISTINCT user_id) AS average_posts_per_user
FROM photos;

totoal_photos  total_users     average_posts_per_user
257	       74	       3.472972972972

&
