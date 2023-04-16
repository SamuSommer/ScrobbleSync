-- ScrobbleSync 0.6.1


-- ENTER YOUR LAST.FM USERNAME HERE between the " quotes.

set username to "Samu-1"


-- Optional but recommended:
-- If you want a text file with a summary of the script's run and tags to check to be created automatically, please enter the file path where it shall be saved here. 
-- If you don't want the summary, just leave it as is, nothing will be created.

set summaryFilePath to "/Users/nothanks/Desktop/"


-- nothing you need to modify from here on out. save the script, close it, and enjoy :)

tell application "Music"
	if selection is not {} then
		set sel to selection
		set selCount to the count of sel
	else
		error "Please select some songs first, then run the script again."
	end if
end tell

set modeDialogResult to display dialog "Welcome to ScrobbleSync! 
	
	Please choose a mode." buttons {"Manual Sync", "Daily Sync", "More options"} default button "Manual Sync"
set chosenMode to button returned of modeDialogResult

if chosenMode is "Manual Sync" then
	if selCount is greater than 250 then
		error "Manual Sync only supports up to 250 songs. Please use Daily Sync or Full Sync instead."
	end if
	set delayDuration to 1.5
	
else if chosenMode is "Daily Sync" then
	-- Daily Sync currently does the same thing as Manual Sync, only slower, and allows more than 250 songs without hitting rate limit, thanks to longer delay
	-- It will be reworked shortly. If it works as intended, it will automatically select the last played songs of the last 48 hours and sync those.
	set delayDuration to 5
	
else if chosenMode is "More options" then
	set modeDialogResult2 to display dialog "Choose an option:" buttons {"Full Sync", "Quit"} default button "Full Sync"
	set chosenMode2 to button returned of modeDialogResult2
	
	if chosenMode2 is "Full Sync" then
		-- Full Sync currently works the same as Daily Sync
		-- after rework, it will automatically select all songs in the library and sync them.
		-- best used overnight. can take a while depending on library size.
		set delayDuration to 5
		
	else if chosenMode2 is "Quit" then
		return
		
	end if
end if


set headers to "--user-agent \"ScrobbleSync\" --referer \"https://scrobblesync.carrd.co\" "
set errorCodes to {{code:6, description:"Invalid parameters"}, {code:8, description:"Operation failed - Most likely backend service issue. Please try again"}, {code:11, description:"Service temporarily offline, please try again later"}, {code:16, description:"Service temporarily unavailable, please try again"}, {code:26, description:"API Key Suspended"}, {code:29, description:"Rate limit exceeded"}}
set counter to 0
set checkTagsCounter to 0
set missingScrobblesCounter to 0
set errorCounter to 0
set abortError to 0
set errorCode to 0
set errorDescription to ""

set summaryCheckTags to "Tags to check (Apple Music playcount > 0 but no scrobbles found)
This is probably caused by an artist redirect in the last.fm database." & linefeed & linefeed

set summaryErrorTags to "Songs to try syncing again (probably failed due to last.fm server issue)
If the issue persists, let me know on Discord and I will investigate." & linefeed & linefeed

tell application "Music"
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
					set checkTagsCounter to checkTagsCounter + 1
					set summaryCheckTags to summaryCheckTags & (artistraw & " - " & trackraw) & linefeed & linefeed
				else
					if lfplaycountInt > 0 and AMplaycount > 0 then
						set comment of t to "scrobble " & (AMplaycount - lfplaycountInt) as string
						set missingScrobblesCounter to missingScrobblesCounter + 1
					end if
				end if
			end if
		on error
			-- ignore errors here because they are handled in the handler
		end try
		
		delay delayDuration
		
		set counter to counter + 1
		
	end repeat
	
	my summaryHandler(summaryFilePath, abortError, artistraw, trackraw, errorCode, errorDescription, checkTagsCounter, errorCounter, missingScrobblesCounter, summaryCheckTags, summaryErrorTags, counter)
	
	set dialogSummary to display dialog "ScrobbleSync finished!
		
" & counter & " scrobble counts updated." buttons {"Nice!"} default button 1
	-- would be nice to mention the summary has been saved at the designated location, conditionally if it has been enabled and written. add a line at the end of the handler that sets a variable to check if it is enabled (with the nothanks thing)
end tell


on summaryHandler(summaryFilePath, abortError, artistraw, trackraw, errorCode, errorDescription, checkTagsCounter, errorCounter, missingScrobblesCounter, summaryCheckTags, summaryErrorTags, counter)
	if summaryFilePath is not "/Users/nothanks/Desktop/" then
		set currentDate to current date
		set summaryFull to "ScrobbleSync Summary" & linefeed & linefeed & currentDate & linefeed & linefeed & counter & " scrobble counts were synced."
		
		if abortError is not 0 then
			set summaryFull to summaryFull & linefeed & linefeed & linefeed & "ScrobbleSync stopped running due to an API error." & linefeed & "Error Code: " & errorCode & " - " & errorDescription & linefeed & linefeed & "For your reference: The sync stopped at" & linefeed & linefeed & (artistraw & " - " & trackraw) & linefeed & linefeed & "You can take it up from there next time, if you wish to do so."
		end if
		
		if checkTagsCounter is 0 and errorCounter is 0 then
			set summaryFull to summaryFull & linefeed & linefeed & "There were no errors, and all tags are fine. Congrats!"
		end if
		
		if missingScrobblesCounter is not 0 then
			set summaryFull to summaryFull & linefeed & linefeed & linefeed & missingScrobblesCounter & " tracks are missing scrobbles." & linefeed & linefeed & "Their comments have been set accordingly with the number of times you need to scrobble them additionally to reach parity with their Apple Music play count. Afterwards, you can sync them again to set their comment to just the scrobble count. To do so, press Option+Cmd+F to filter, type in scrobble, and select all tracks shown, then do a Manual Sync."
		end if
		
		if checkTagsCounter is not 0 then
			set summaryFull to summaryFull & linefeed & linefeed & linefeed & summaryCheckTags
		end if
		
		if errorCounter is not 0 then
			set summaryFull to summaryFull & linefeed & linefeed & linefeed & summaryErrorTags
		end if
		
		set fileName to "ScrobbleSync_Summary.txt"
		set fullsummaryFilePath to summaryFilePath & fileName
		set summaryFile to open for access (POSIX file fullsummaryFilePath) with write permission
		set eof summaryFile to 0
		write summaryFull to summaryFile
		close access summaryFile
	end if
end summaryHandler

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
				set abortError to 1
				my summaryHandler(summaryFilePath, abortError, artistraw, trackraw, errorCode, errorDescription, checkTagsCounter, errorCounter, missingScrobblesCounter, summaryCheckTags, summaryErrorTags, counter)
				error "API error: " & errorCode & " - " & errorDescription
			else if errorCode is "6" then
				set errorCounter to errorCounter + 1
				set comment of t to "tag error"
				set summaryErrorTags to summaryErrorTags & (artistraw & " - " & trackraw) & linefeed & linefeed
			else if errorCode is "8" then
				set errorCounter to errorCounter + 1
				set comment of t to "try again"
				set summaryErrorTags to summaryErrorTags & (artistraw & " - " & trackraw) & linefeed & linefeed
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
