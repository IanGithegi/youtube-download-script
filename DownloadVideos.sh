#!/usr/bin/env bash
#Download  Each Video from a List provided.
#Create a New folder, Obtain the Thumbnail and Download video and other metadata for each video

#vid_dir=$1
file="/home/samuel/Music/Test_Videos/list.txt"

mkdir Videos

touch video-map.txt

echo "Reading the lines in $file"
#while IFS= read -r line 
for line in $(cat $file)
do
    video_id=$(youtube-dl --get-id "$line")
    echo Creating Folder :$video_id
    mkdir "$video_id"
    video_title=$(youtube-dl --get-title "$line")
    
    echo "$video_id=$video_title" >> video-map.txt
    cd $video_id
    thumbnail=$(youtube-dl --write-thumbnail $line)
    echo Downloading Video : "$video_title" 
    youtube-dl -f best $line
    echo "{ \"Title\": \"$video_title\", \"Thumbnail\": \"$thumbnail\",\"Poster\":\"poster.jpg\", \"Content Type\": \"Show\", \"Content Provider\": \"Ted Talks\",  \"Content Licence\": \"Creative Commons licenses \",}" > metadata.json
    cd ..
    
done <$file

