#! /bin/bash

function playlistDownload {
        name="$1"
        url="$3"
        outDir="$2"
        echo "Downloading: $name into $outDir with URL $url"

        mkdir $name 2> /dev/null
        mkdir $outDir 2> /dev/null
        yt-dlp --extract-audio -f "bestaudio[ext=m4a]","bestaudio[ext=webm]" --audio-format mp3 --write-description --embed-metadata --yes-playlist "$url" -o "$outDir/$name/%(title)s.%(ext)s"
}

function install {
        # setup storage permission
        termux-setup-storage
        

        # install pip for yt-dlp and ffmpeg for music
        yes | pkg update
        yes | pkg upgrade
        yes | pkg install python-pip ffmpeg
        yes | pip3 install yt-dlp --upgrade
}

output="/storage/emulated/0/Music"

function download {

        # Put the playlists here. the automatic output is the music folder.
        # The only things necessary to configure are the name of the playlists and the playlist URL.
        # The playlist must be either on "public" or "unlisted" (Unlisted is better for privacy)
        # Also remove the comment (this charecter -> #) at the start. otherwise it will be ignored 
        
        # playlistDownload "name-of-playlist"   "$output"       "https://music.youtube.com/playlist?list=blablabla"
        # playlistDownload ""   "$output"       ""
        # playlistDownload ""   "$output"       ""
        # playlistDownload ""   "$output"       ""
        # playlistDownload ""   "$output"       ""
        # playlistDownload ""   "$output"       ""
        # playlistDownload ""   "$output"       ""
        # playlistDownload ""   "$output"       ""

}

echo "1. download all music"
echo "2. update yt-dlp"

if [ -z $1 ]; then
        read opt
else
        opt=$1
fi

if [ $opt -eq 1 ]; then
        download
elif [ $opt -eq 2 ]; then
        install
fi
