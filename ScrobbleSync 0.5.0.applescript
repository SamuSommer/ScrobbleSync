-- ScrobbleSync 0.5.0


-- ENTER YOUR LAST.FM USERNAME HERE between the " quotes.
set username to "Samu-1"


-- main menu dialog

try
	set modeDialogResult to display dialog "Welcome to ScrobbleSync! 
	
	Please choose a mode." buttons {"Manual Sync", "Daily Sync", "More options"} default button "Manual Sync"
	set chosenMode to button returned of modeDialogResult
	
	if chosenMode is "Manual Sync" then
		-- Actions for "Manual Sync"
		set delayDuration to 1.5
		
	else if chosenMode is "Daily Sync" then
		-- Actions for "Daily Sync"
		set delayDuration to 5
		
	else if chosenMode is "More options" then
		set modeDialogResult2 to display dialog "Choose an option:" buttons {"Full Sync", "Quit"} default button "Full Sync"
		set chosenMode2 to button returned of modeDialogResult2
		
		if chosenMode2 is "Full Sync" then
			-- Actions for "Full Sync"
			set delayDuration to 5
		else if chosenMode2 is "Quit" then
			return
		end if
	end if
end try


set headers to "--user-agent \"ScrobbleSync\" --referer \"https://scrobblesync.carrd.co\" "
set errorCodes to {{code:6, description:"Invalid parameters"}, {code:8, description:"Operation failed - Most likely backend service issue. Please try again"}, {code:11, description:"Service temporarily offline, please try again later"}, {code:16, description:"Service temporarily unavailable, please try again."}, {code:26, description:"API Key Suspended"}, {code:29, description:"Rate limit exceeded"}}


tell application "Music"
	if selection is not {} then
		set sel to selection
		set counter to 0
		set check_tags_list to "Tags to check (AM playcount > 0 but scrobbles = 0)"
		-- now that there is always content in here i need to change the condition for the doc to show up - likely if ttclist is not "the content above"
		set tag_error_list to "Tags to check (Incomplete requests, possibly encoding issue)"
		-- this needs to be referenced later in the handler on tag error and then joined with the first list at the end before saving
		-- same condition as above needed
		
		repeat with t in sel
			set artistraw to the artist of t
			set trackraw to the name of t
			set artistquery to quoted form of artistraw
			set trackquery to quoted form of trackraw
			set AMplaycount to the played count of t as integer
			
			
			set curl_command to "curl -G -d 'method=track.getInfo' -d 'api_key=9effc2d441f6ecb5dd8981066b2b3241' -d 'username=" & username & "' --data-urlencode 'artist=" & (text 2 thru -2 of artistquery) & "' --data-urlencode 'track=" & (text 2 thru -2 of trackquery) & "' 'http://ws.audioscrobbler.com/2.0/'"
			
			try
				set QueryResponse to do shell script curl_command
				set lfplaycount to my getPlayCount(QueryResponse)
				set lfplaycountInt to lfplaycount as integer
				
				if lfplaycountInt ≥ AMplaycount then
					set comment of t to lfplaycount
				else
					if lfplaycountInt = 0 and AMplaycount > 0 then
						set comment of t to "check tag"
						set check_tags_list to check_tags_list & (artistraw & " - " & trackraw) & linefeed & linefeed
					else
						if lfplaycountInt > 0 and AMplaycount > 0 then
							set comment of t to "scrobble " & (AMplaycount - lfplaycountInt) as string
						end if
					end if
				end if
			on error
				-- ignore errors here because they are handled in the handler? needs to be re checked
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


on getPlayCount(QueryResponse)
	tell application "System Events"
		set lastXML to make new XML data with properties {text:QueryResponse}
		try
			set lfplaycount to get value of XML element "userplaycount" of XML element "track" of XML element "lfm" of lastXML
			return lfplaycount
		on error
			set errorCode to get value of XML attribute "code" of XML element "error" of XML element "lfm" of lastXML
			set errorDescription to my getErrorDescription(errorCode as integer)
			if errorCode is "11" or errorCode is "16" or errorCode is "26" or errorCode is "29" then
				error "API error: " & errorCode & " - " & errorDescription
			else if errorCode is "6" then
				set comment of t to "tag error"
			else if errorCode is "8" then
				set comment of t to "try again"
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
