-- AutoScrobbleSync 0.2.0
--

-- Enter your Last.fm username here between the " quotes:
set username to ""

-- Put in the name of your Smart Playlist here between the " quotes:
set playlistName to ""

-- Now save the script (Cmd-S), close it, and proceed with the setup instructions from the README.md.

if username is "" then
	error "Please put in your Last.fm username first."
end if

if playlistName is "" then
	error "Please put in the name of your Smart Playlist first."
end if

tell application "Music"
	set recentlyPlayedTracks to every track of playlist playlistName
	repeat with t in recentlyPlayedTracks
		set artistraw to the artist of t
		set trackraw to the name of t
		set artistquery to quoted form of artistraw
		set trackquery to quoted form of trackraw
		set AMplaycount to the played count of t as integer
		set curl_command to "curl -G -d 'method=track.getInfo' -d 'api_key=9effc2d441f6ecb5dd8981066b2b3241' -d 'autocorrect=0' -d 'username=" & username & "' --data-urlencode 'artist=" & (text 2 thru -2 of artistquery) & "' --data-urlencode 'track=" & (text 2 thru -2 of trackquery) & "' 'http://ws.audioscrobbler.com/2.0/' --user-agent \"AutoScrobbleSync\""
		try
			set QueryResponse to do shell script curl_command
			set lfplaycount to my getPlayCount(QueryResponse)
			set lfplaycountInt to lfplaycount as integer
			if lfplaycountInt >= AMplaycount then
				set comment of t to lfplaycount
			else
				set comment of t to AMplaycount
			end if
		on error
		-- optional: set comment of t to "!" or whatever
		end try
		delay 5
	end repeat
end tell


on getPlayCount(QueryResponse)
	tell application "System Events"
		set lastXML to make new XML data with properties {text:QueryResponse}
		try
			set lfplaycount to get value of XML element "userplaycount" of XML element "track" of XML element "lfm" of lastXML
			return lfplaycount
		on error
		end try
	end tell
end getPlayCount