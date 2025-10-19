#! /bin/bash
function progress(){
	printf "\r"
	printf "$1 out of $2 files processed."
}

function playlistDownload {
	# raw playlist
	tmpList=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

	# Sorted complete without ID
	tmpList2=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

	# List of songs already downloaded (formatted already)
	tmpList3=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

	# Songs to download
	tmpList4=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

	# Only IDs of the todownload
	tmpList5=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

	name="$1"
        url="$3"
        outDir="$2"
        echo "Downloading: $name into $outDir with URL $url"

	mkdir $name 2> /dev/null
        mkdir $outDir 2> /dev/null

	yt-dlp --print "%(id)s %(title)s" --flat-playlist "$url" > "$tmpList"

	awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' "$tmpList" | sort > "$tmpList2"

	# get list of already existing files
	ls "$outDir/$name"  | sed 's/.mp3$//g' | grep -v description | sort > $tmpList3

	# get list of not downloaded songs
	grep -v -F -x -f "$tmpList3" "$tmpList2" > "$tmpList4"

	# make list of yt IDs
	#cat "$tmpList4"|while read x; do grep " ${x}" "$tmpList" ; done
	cat "$tmpList4"|while read x; do grep -a -F -- "${x}" "$tmpList" ; done | awk '{print $1}' > "$tmpList5"

	total=$(wc -l "$tmpList5")
	echo "Downloading: $total songs from playlist $name"

	n=1
	cat "$tmpList5" | while read x; do
		progress $n $total
		((n++))

		yt-dlp --extract-audio -f "bestaudio[ext=m4a]","bestaudio[ext=webm]" --audio-format mp3 --write-description --embed-metadata "https://music.youtube.com/watch?v=$x" -o "$outDir/$name/%(title)s.%(ext)s"

	done

	rm "$tmpList"
	rm "$tmpList2"
	rm "$tmpList3"
	rm "$tmpList4"
	rm "$tmpList5"
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

        echo "downloading..."
        # You need to edit this part. the automatic output is the music folder.
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
