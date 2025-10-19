# YouTube Music Playlist Downloader (Bash Script)

This is a simple Bash script to download **YouTube Music playlists** directly to your Android device using **Termux**.

## Features

- Downloads songs from pre-defined YouTube Music playlists
- Saves songs into **separate folders per playlist**
- Designed for **Termux** and Android's standard music directories
- Easily customizable to support other systems or playlist URLs
- Will attempt not to download the same song twice (I had some issues with grepping weird URF-8 charecters here but its mostly working)

## Requirements

- [Termux](https://f-droid.org/en/packages/com.termux/)
- 'yt-dlp' (YouTube downloader)
- 'ffmpeg' (for audio conversion and metadata handling)
- All these will be configured automatically with the update command
- Internet connection

You can install dependencies in Termux with:

'''bash
pkg update && pkg install yt-dlp ffmpeg 
...or simply run the update function built into the script

## Usage

- git clone https://github.com/peter2233finn/youtube-playlist-downloader/
- bash youtube-playlist-downloader/ytPlaylistDownload.sh
- (You must edit the script to add your playlists before running the second command)
