#!/usr/bin/env zsh

curl -H 'Client-ID: aokchnui2n8q38g0vezl9hq6htzy4c' -X GET 'https://api.twitch.tv/helix/videos?user_id=178943555' \
  | jq '.data[0].id' | read VOD_ID


aws s3 ls everlords-videos/$VOD_ID.mp4 | read S3_LS

if [ -z $S3_LS ]; then

  echo "New Vod: $VOD_ID"
  ./concat_ubuntu -vod $VOD_ID;

else

  echo "Vod already saved: $S3_LS";

fi

unset VOD_ID
