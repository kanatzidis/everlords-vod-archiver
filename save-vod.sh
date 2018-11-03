#!/usr/bin/env zsh

curl -H 'Client-ID: aokchnui2n8q38g0vezl9hq6htzy4c' -X GET 'https://api.twitch.tv/helix/videos?user_id=178943555' \
  | jq '.data[0]' | read VOD_JSON


echo $VOD_JSON | jq '.id' | tr -d '"' | read VOD_ID
echo $VOD_JSON | jq '.title' | tr -d '"' | sed 's/[^A-Za-z0-9]//g' | read VOD_NAME

aws s3 ls everlords-videos/$VOD_NAME.mp4 | read S3_LS

if [ -z $S3_LS ]; then

  echo "New Vod: $VOD_ID - $VOD_NAME"
  ./concat_ubuntu -vod $VOD_ID;
  aws s3 mv $VOD_ID.mp4 s3://everlords-videos/$VOD_NAME.mp4 && echo "Saved successfully"

else

  echo "Vod already saved: $S3_LS";

fi

unset VOD_ID
