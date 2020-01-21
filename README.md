# DESCRIPTION
Little nifty feature for Quicktime Player that lets you export gif from current playback position and of a certain duration. 
Uses applescript and ffmpeg. 


# REQUIREMENTS 
works only for OS X / macOS with the following installed:
- Quicktime Player 
- Terminal 
- ffmpeg 


# SETUP
- download file "Export GIF.scpt" from this repository and place it in the following folder 
"/Users/*your username*/Library/Scripts/Applications/Quicktime Player"

- make sure you have ffmpeg installed. 
If not, the simplest way is using homebrew in Terminal (brew install ffmpeg). Or google "install ffmpeg"


# HOW TO USE
> open movie in Quicktime Player 
> move to playback position where you want to start the gif from 
> in menu, click scripts icon and choose "Export GIF" 
  (if you don't see the script icon open Script Editor.app, go to preferences and check "Show scripts icon in menu")
> Follow the dialogs and enter the values 
- gif is saved in the chosen directory


# FFMPEG CONFIGURATION
The script summons all variables and sends it to ffmpeg as follows:
ffmpeg -ss $start -t $duration -i $inputFile -vf "fps=$fps, scale=$scale:flags=lanczos" -loop 0 $outputFile


# AUTHOR
MadMonkey.Works


# CHANGE LOG
1.0 Start - stable version
