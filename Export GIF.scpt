local currentFilePath
local movieDuration
local startTime
local gifDuration
local fileName
local exportDir
local exportPath
local fps
local scale
local flags

# get values from quicktime player
tell application "QuickTime Player"
	
	# get current file path
	set currentFilePath to the file of the front document
	
	# get current playback time in seconds
	set startTime to get the (current time of the front document) div 1
	
	# get current movie duration 
	set movieDuration to duration of the front document
	
end tell

# get duration from user dialog
repeat
	set dialogResult to (display dialog "Duration? (seconds)" default answer "3")
	try
		set gifDuration to (text returned of dialogResult) as integer
		if gifDuration > 0 and gifDuration < movieDuration then exit repeat
	end try
	beep
	display dialog "The duration needs to be a valid integer between 1 and " & movieDuration div 1 & "!" buttons {"Enter again", "Cancel"} default button 1
end repeat

# get file name from user dialog
repeat
	set dialogResult to (display dialog "Output file name?" default answer "my gif")
	try
		set fileName to (text returned of dialogResult)
		if fileName is not "" then exit repeat
	end try
	beep
	display dialog "The file name is required! No special characters." buttons {"Enter again", "Cancel"} default button 1
end repeat

# get fps from user dialog
repeat
	set dialogResult to (display dialog "Frames per second? (number between 1 and 25)" default answer "5")
	try
		set fps to (text returned of dialogResult) as integer
		if fps > 0 and fps ≤ 25 then exit repeat
	end try
	beep
	display dialog "The frames per seconds needs to be a valid integer between 1 and 25!" buttons {"Enter again", "Cancel"} default button 1
end repeat

# get scale from user dialog
repeat
	set dialogResult to (display dialog "Scale? (in format width:height; or leave blank; use -1 to automaticaly calculate the size – eg 300:-1." default answer "")
	try
		set scale to (text returned of dialogResult)
		if scale is not "" then exit repeat
	end try
	beep
	display dialog "The scale is required!" buttons {"Enter again", "Cancel"} default button 1
end repeat

# set export paths and convert to POSIX
set exportDir to choose folder with prompt "Select an output folder:"
set exportPath to POSIX path of exportDir & fileName & ".gif"
set currentFilePath to POSIX path of currentFilePath

# treat scale
if scale is not "" then set scale to "scale=" & scale & ":flags=lanczos"

#treat fps
if fps is not "" then set fps to "fps=" & fps

#set scale and fps in proper ffmpeg flags
set flags to fps & ", " & scale


# use ffmpeg to export the gif
tell application "Terminal"
	do script "ffmpeg -ss " & startTime & " -t " & gifDuration & " -i " & quoted form of currentFilePath & " -vf " & quoted form of flags & " -loop 0 " & quoted form of exportPath
end tell
