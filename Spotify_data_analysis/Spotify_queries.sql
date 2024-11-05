-- User and Subscription Analysis ##########

-- Q 1.	How many users are on the Premium subscription versus the Free subscription?

select count(subscription_id) as users
from subscriptions
where subscription_type = "Free";

-- Q 2.	What is the average time since join date for all users?

SELECT AVG(DATEDIFF(CURDATE(), join_date)) AS avg_days_since_join
FROM Users;

-- Q 3.	List all users from a specific country (e.g., USA) who have a Premium subscription.

select* from users
where country = "USA" and subscription_type = "Premium";

-- Q 4.	Find users who have not listened to any song in the last month.

SELECT user_id, username
FROM Users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM Listening_History
    WHERE listened_at >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
);

-- Q 5.	How many users joined in each month of the year 2023?

select month(join_date) month_ , count(* ) as user_count
from users
where year(join_date) = 2023
group by 1;


-- Artist and Song Analysis #############

-- Q 6 List all songs by a specific artist (e.g., Ed Sheeran) along with their duration.

select song_title , duration_in_seconds from songs as so
join artists as ar on 
so.artist_id=ar.artist_id
where artist_name = "Ed Sheeran";

-- Q 7.	Which genre has the most songs in the database?

select genre, count(*) as song_count
from songs
group by 1 
order by 2 desc;

-- Q 8.	Find the average duration of songs by each artist

select   ar.artist_name,
round(avg(so.duration_in_seconds),2) as avg_song_du 
from songs as so
join artists as ar on so.artist_id = ar.artist_id
group by 1;

-- Q 9.	Retrieve all songs released in a specific year (e.g., 2019).

select* from songs
where year(release_date) = 2019 ;

-- Q 10.	List the top 5 longest songs in the database.

select song_title, 
duration_in_seconds from songs
order by 2 desc
limit 5;

-- Playlist and Song Engagement #########

-- Q 11.	How many songs are in each playlist?

select playlist_id,count(song_id)as count_songs
from playlist_songs
group by 1;

-- Q 12.	List all playlists containing songs by a specific artist (e.g., Taylor Swift).

select distinct pll.playlist_name ,ar.artist_name from playlists as pll
join playlist_songs as ps on pll.playlist_id= ps.playlist_id
join songs as so on ps.song_id= so.song_id
join artists as ar on so.artist_id=ar.artist_id
where artist_name = "Taylor Swift";

-- Q 13.	Which songs appear in the most playlists?

select so.song_title, count(pls.playlist_id) as playlist_count 
from playlist_songs as pls
join songs as so on so.song_id= pls.song_id
group by 1
order by 2 desc;
;

-- Q 14.	Find the most popular playlist based on the number of users who have listened to songs from it.

SELECT Playlists.playlist_name, COUNT(DISTINCT Listening_History.user_id) AS user_count
FROM Playlist_Songs
JOIN Listening_History ON Playlist_Songs.song_id = Listening_History.song_id
JOIN Playlists ON Playlist_Songs.playlist_id = Playlists.playlist_id
GROUP BY Playlists.playlist_name
ORDER BY user_count DESC
LIMIT 1;

-- Q 15.	List all playlists created by Premium users only.

select pl.playlist_name, us.subscription_type 
from  playlists as pl
join users as us on pl.user_id=us.user_id
where subscription_type = "Premium";

-- Listening History and Song Popularity ############

-- Q 16.	Which song has been listened to the most times by users?

select so.song_title, count(history_id) as listen_count from songs as  so
join listening_history as lh on so.song_id=lh.song_id
group by 1
order by 2 desc 
limit 1;

-- Q 17.	What is the total number of listens for each artist?

select 
arr.artist_name,
count(history_id) as count_listen
from listening_history as lh 
join songs as so on lh.song_id=so.song_id
join artists as arr on so.artist_id=arr.artist_id
group by 1;

-- Q 18.	Find the song with the longest average listening duration per user.

select so.song_title ,avg(so.duration_in_seconds) as avg_dureation 
from songs as so 
join listening_history  as lh on so.song_id=lh.song_id
group by 1
order by 2
limit 1;

-- Q 19.	List the top 3 users with the highest number of unique songs listened to.

select us.username,
count(distinct  lh.history_id) as unique_songs
from users as us
join listening_history as lh on us.user_id=lh.user_id
join songs as so on lh.song_id=so.song_id
group by 1
order by 2 desc
limit 3;

-- Q 20.	How many users listened to a specific song (e.g., 'Blinding Lights') on a specific day?

select 
count(us.user_id) as users_count
from users as us
join listening_history as lh on lh.user_id=us.user_id
join songs as so on lh.song_id= so.song_id
where so.song_title = "Blinding Lights" and date(lh.listened_at)= "2023-07-01";

