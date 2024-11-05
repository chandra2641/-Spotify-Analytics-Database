# -Spotify-Analytics-Database
The Spotify Analytics Database project is designed to simulate a music streaming platform's database, similar to Spotify. It stores information about users, artists, songs, playlists, and listening history, enabling analysis of user behavior, song popularity, and playlist trends.
Database Structure
The database consists of the following main tables:

Users: Stores information about each user, including username, email, country, subscription type (e.g., Free or Premium), and the date they joined the platform. This table helps in identifying user demographics and subscription types, which is essential for segmenting users for further analysis.

Artists: Contains details about music artists, such as their name, genre, and country of origin. This information is essential for analyzing the popularity of artists across regions and genres.

Songs: Stores information about each song, including its title, artist, album, duration, release date, and genre. This table links to the Artists table and enables us to analyze song details, artist collaborations, and genre trends.

Playlists: Represents the playlists created by users, with fields for playlist name, creator, and creation date. This table allows us to track user-created playlists, understand playlist creation trends, and analyze playlist preferences.

Playlist_Songs: This associative table connects playlists to songs, representing a many-to-many relationship between them. It enables analysis of song popularity within playlists and allows for playlist-specific insights.

Listening_History: Captures each instance a user listens to a song, including the timestamp. This table is crucial for understanding song popularity, user engagement, and listening behavior over time.

Subscriptions: Stores details about each user’s subscription, including subscription type, start date, and end date. This table helps in understanding user retention, subscription trends, and the popularity of different subscription models.
