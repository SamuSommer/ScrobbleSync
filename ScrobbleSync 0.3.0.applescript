-- ScrobbleSync 0.3.0

-- ENTER YOUR LAST.FM USERNAME HERE between the = and the \
set username to "&username=Samu-1\""


set modeDialogResult to display dialog "Welcome to ScrobbleSync!

Please choose a mode." buttons {"Fast Mode", "Overnight Mode"} default button "Fast Mode"
set chosenMode to button returned of modeDialogResult

if chosenMode is "Fast Mode" then
	set delayDuration to 1.5
else
	set delayDuration to 5
end if


set headers to "--user-agent \"ScrobbleSync\" --referer \"https://scrobblesync.carrd.co\" "
set baseURL to "\"http://ws.audioscrobbler.com/2.0/?method=track.getInfo"
set APIKey to "&api_key=e72f27917817492492a244ff7e22b561"
set replacements to {{"&", "%26"}, {"#", "%23"}, {"+", "%2B"}, {"\"", "\\\""}, {"$", "\\$"}, {" ", "+"}, {"[", "%5B"}, {"]", "%5D"}}
set errorCodes to {{code:6, description:"Invalid parameters"}, {code:16, description:"Service temporarily unavailable, please try again."}, {code:26, description:"API Key Suspended"}, {code:29, description:"Rate limit exceeded"}}


tell application "Music"
	if selection is not {} then
		set sel to selection
		set counter to 0
		set check_tags_list to ""
		
		repeat with t in sel
			set artistraw to the artist of t
			set trackraw to the name of t
			set AMplaycount to the played count of t as integer
			
			set artistquery to my replaceMultiple(artistraw, replacements)
			set trackquery to my replaceMultiple(trackraw, replacements)
			
			set QueryArtist to "&artist=" & artistquery
			set QueryTrack to "&track=" & trackquery
			set curl_command to "curl " & headers & baseURL & APIKey & QueryArtist & QueryTrack & username
			
			try
				set QueryResponse to do shell script curl_command
				set lfplaycount to my getPlayCount(QueryResponse)
				set lfplaycountInt to lfplaycount as integer
				
				if lfplaycountInt ≥ AMplaycount then
					set comment of t to lfplaycount
				else
					if lfplaycountInt = 0 and AMplaycount > 0 then
						set comment of t to "check tag"
					else
						if lfplaycountInt > 0 and AMplaycount > 0 then
							set comment of t to "scrobble " & (AMplaycount - lfplaycountInt) as string
						end if
					end if
				end if
			on error
				set comment of t to "error"
				set check_tags_list to check_tags_list & (artistraw & " - " & trackraw) & linefeed
			end try
			
			delay delayDuration
			
			set counter to counter + 1
			
		end repeat
		
		
		set dialogSummary to display dialog "" & counter & " scrobble counts updated." buttons {"Nice!"} default button 1
		
		if check_tags_list is not "" then
			set dialogCheckTags to display dialog "Do you want to save the list of songs with tags to check?" buttons {"Yes", "No"} default button 1
			if button returned of dialogCheckTags is "Yes" then
				set tagsFilePath to choose file name with prompt "Save tags to check as a text file:"
				set tagsFile to open for access tagsFilePath with write permission
				set eof tagsFile to 0
				write check_tags_list to tagsFile
				close access tagsFile
			end if
		end if
		
	end if
end tell


on replaceMultiple(subject, replacements)
	repeat with i from 1 to count items of replacements
		set find to item 1 of item i of replacements
		set replace to item 2 of item i of replacements
		set subject to my replaceChars(find, replace, subject)
	end repeat
	return subject
end replaceMultiple


on replaceChars(find, replace, subject)
	set savedelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to find
	set subject to text items of subject
	set AppleScript's text item delimiters to replace
	set subject to (subject as string)
	set AppleScript's text item delimiters to savedelims
	return subject
end replaceChars


on getPlayCount(QueryResponse)
	tell application "System Events"
		set lastXML to make new XML data with properties {text:QueryResponse}
		try
			set lfplaycount to get value of XML element "userplaycount" of XML element "track" of XML element "lfm" of lastXML
			return lfplaycount
		on error
   			set errorCode to get value of XML attribute "code" of XML element "error" of XML element "lfm" of lastXML
    			set errorDescription to my getErrorDescription(errorCode as integer)
			if errorCode is "16" or errorCode is "26" or errorCode is "29" then
				error "API error: " & errorCode & " - " & errorDescription
			end if
      	 	end try
	end tell
end getPlayCount


on getErrorDescription(errorCode)
    repeat with errorRecord in errorCodes
        if code of errorRecord is errorCode then
            return description of errorRecord
        end if
    end repeat
    return "Unknown error. Message me on Discord @Samu#1337"
end getErrorDescription
