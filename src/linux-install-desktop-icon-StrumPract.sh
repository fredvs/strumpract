## Linux: Script to install icon on desktop and in menu Programming.
## Thanks to Roland Chastain.

BASENAME="StrumPract"
## Application full name
APP="strumpract"
## Script directory
SCRDIR="$(dirname "$(readlink -f "$0")")"
## Desktop directory
DDIR="$HOME/Desktop"
## Applications menu directory
ADIR="$HOME/.local/share/applications"

echo "INFO Create desktop and menu icon."

if [ ! -d $DDIR ] ;
then
  echo "WARNING Cannot find $DDIR"
  DDIR="$HOME/Bureau"
fi

if [ -d $DDIR ] ;
then
  FILE=$DDIR/$BASENAME.desktop
  echo "INFO Create $FILE"
  cat > $FILE << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=StrumPract
Comment=Tools for musicians
Exec=$SCRDIR/strumpract %F
Icon=$SCRDIR/strumpract.png
Path=$SCRDIR/
Terminal=false
StartupNotify=false
Categories=AudioVideo;Audio;AudioVideoEditing;
MimeType=application/x-ogg;application/ogg;audio/x-vorbis+ogg;audio/vorbis;audio/x-vorbis;audio/x-scpls;audio/x-mp3;audio/x-mpeg;audio/mpeg;audio/x-mpegurl;audio/x-flac;audio/mp4;audio/x-it;audio/x-mod;audio/x-s3m;audio/x-stm;audio/x-xm;
Keywords=DJ;Synthesizer;Recording;Tuner;Audio;Song;MP3;Playlist;
EOF
  echo "INFO Set permission"
  sudo chmod -R 777 $FILE
  echo "INFO Done"
else
  echo "ERROR Cannot find $DDIR"
  exit 0
fi

echo "INFO Copy .desktop to applications menu directory"

if [ -d $ADIR ] ;
then
  FILE1=$DDIR/$BASENAME.desktop
  FILE2=$ADIR/$BASENAME.desktop
  echo "INFO Create $FILE2"
  cp -f $FILE1 $FILE2
  echo "INFO Set permission"
  sudo chmod -R 777 $FILE2
  echo "INFO Done"
else
  echo "ERROR Cannot find $ADIR"
  exit 0
fi
