# ScrobbleSync

ScrobbleSync is a simple AppleScript (*soon-to-be Applet*) that fetches the scrobble count for each song in your Apple Music library and stores it in the comment field, which can then be used for sorting and filtering.

## Getting Started

This README.md should give you all the relevant information for using this tool. If something is unclear or not working, you can message me on Discord @Samu#1337

## Prerequisites
- A Mac
- Apple Music

## Installation
1. Download the script and paste it into

>/Users/yourusernamehere/Library/Music/Scripts

(create the Scripts folder if it doesn't exist yet)

2. Then open it and put in your **last.fm username** where it says to do so (at the top).
3. Save the script (`⌘-S`) and close it.

## Usage

### First-time setup:
1. Open Apple Music and view your Library in tracks view. 
2. Press `⌘-J` for display options. Enable `Comments`, and `Last Played`.
3. Now, select a few tracks and then click the script icon on the menu bar (*it's the little scroll*), then click on ScrobbleSync.  
4. It will start running, writing the comments starting from the first selected song.

### Fast mode:

### Overnight mode:


*the next part is my personal use rec, not mandatory:*
then at the top, click on the last played column until it sorts by last played (most recent tracks first). this is to import the scrobbles for your recently listened songs (i usually do it once a day for the day's plays), and so you can gradually import all scrobbles going from recent to old plays.

Once it has finished running, you will get a popup telling you how many scrobble counts were synced.
Prompts to save, yada yada

### Important things to note:

While the script is running, you can't scroll around or click on other stuff in Apple Music. 
Playback will continue however, and the media keys still work. 
If you want to **stop the script**, just press `ESC`. 

## Limitations

The last.fm API has a rate limit, which means if you send too many requests in a short time, your IP adress will be restricted from making more API calls for a while (you won't get banned, don't worry). 
This is why my script has an inbuilt delay after each API call - 1.5s in fast mode, 5s in Overnight mode - to prevent getting rate limited. 
In Fast Mode, I still recommend not doing too many songs at once (I usually do like up to 200 with no issues).

In the case you do get rate limited however (like if you tried do run the script in Fast Mode on like several thousand songs at once, the script will show an error message and stop running. 
Then you can either wait a while (not exactly sure how long) or change your IP adress, either with a VPN or by restarting your router.

This API rate limit is annoying, but unfortunately can't be avoided.

## FAQ

#### Something is not working! Help!  
You can message me on Discord @Samu#1337, I will try to help you :)


#### Does this work on iOS / on Windows / on Android / with Spotify / etc.?  
Unfortunately no, AppleScript only works on Mac.  
Spotify doesn't have any metadata editing features. If you really care about scrobbles and correct tags, I highly recommend you switch to Apple Music.


#### Why do you write the scrobbles to comment instead of just updating the playcount directly?  
It is against Apple Music's Terms of Service to modify playcounts.  
Also, even though there are scripts that do that, playcounts are reset to their previous value on next Cloud Library sync, not making this a viable option.
That's why I use the comment workaround.

#### Does this collect my data in any way?  
No, I do not get any of your data. The only info you put in is your username, which is only used to call the last.fm API. The API response is handled on device by the script, none of it is sent or stored anywhere.


## Contributing

## License

## Acknowledgments
