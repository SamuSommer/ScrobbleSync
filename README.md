# ScrobbleSync

ScrobbleSync is an AppleScript tool that fetches the scrobble count for songs in your Apple Music library and stores it in their comment field.  

This is especially helpful for users of [Marvis Pro](https://apps.apple.com/de/app/marvis-pro/id1447768809), which allows displaying the scrobble counts (comments), and can use them for advanced sorting and filtering with Smart Rules.  
But *even if you don't use Marvis Pro*, you might still find some value in having your scrobble counts available locally, and in the other useful features of ScrobbleSync:


## Features
- Fetches and saves scrobble counts for select songs, or your entire library
- Identifies songs that are missing scrobbles and marks them with the number of missing scrobbles
- Provides a summary that includes a list of tags to check (songs that are scrobbling under a different tag than in your Apple Music library)
- Is free and open source, and does not collect any data


## Getting Started

This README.md should give you all the relevant information for using this tool. If something is unclear or not working, you can message me on Discord @Samu#1337

### Prerequisites
- A Mac
- Apple Music

### Installation
1. Download ScrobbleSync (click on the green `Code` button towards the top of this page, then click `Download ZIP`)
2. Open the zip folder and copy the file **'ScrobbleSync_0.6.0.scpt'**
3. Paste it into

>/Users/yourusernamehere/Library/Music/Scripts

(create the *Scripts* folder if it doesn't exist yet)

4. Then open the file and put in your **last.fm username** where it says to do so (at the top).
5. (*Optional but recommended*) If you want a text file with a summary of the script's run and tags to check to be created automatically, please enter the **file path** to save it in below. If you don't want the summary, just leave it as is, nothing will be created.
6. Save the script (`⌘-S`) and close it.


## Usage

### First-time setup
1. Open Apple Music and view your Library in **Songs** view. 
2. Press `⌘-J` for display options. Enable `Comments`, and `Last Played`.
3. **WARNING**: If you have anything written in comment fields already, it WILL GET OVERWRITTEN by ScrobbleSync. If that is a concern for you, I recommend you [back up your Apple Music library](https://www.imore.com/how-back-your-itunes-library). Don't worry, the script won't change anything but comments, but having a backup is a good idea anyways.
4. (*Optional but recommended*) Click on the **Last Played** column until it sorts by last played descending (most recent tracks first). This facilitates gradually importing all scrobbles going from recent to old plays, and is better for Daily Sync.
5. You're all set! Now you can start using ScrobbleSync! :)

### Everyday Use
- Select a few songs and then click the script icon on the menu bar (*it's the little scroll*), then click on ScrobbleSync and select a **Mode**.
- While the script is running, you can't scroll around or click on other stuff in Apple Music. Playback will continue however, and the media keys still work. 
- If you want to **stop the script**, just press `ESC`. 
- Once it has finished running, you will get a popup telling you how many scrobble counts were synced, and the summary file has been saved to your designated file path if you enabled it.

### Modes

#### Manual Sync
- Manual Sync is meant for a quick sync of a few songs (up to about 250 - if you select more, it will raise an error).
- To sync your entire library, use **Daily Sync** or **Manual Sync**.

#### Daily Sync
- Daily Sync has no songs limit, but is a bit slower than manual sync (about 600 songs per hour).
- The longer delay allows to sync more songs without hitting *rate limit* (see **Limitations** below).
- *It will be reworked soon to automatically select the last played songs of the last 48 hours and sync those.*

#### Full Sync
- Full Sync currently works the same as Daily Sync. You can use either of them.
- *After the upcoming rework, it will automatically select all songs in the library and sync them.*


## Limitations
The last.fm API has a **rate limit**, which means if you send too many requests in a short time, your IP adress will be restricted from making more API calls for a while (*you won't get banned, don't worry. You will just have to wait about day*).  
This is why my script has an inbuilt **delay** after each API call - 1.5s in Manual Sync, 5s in Full Sync - to prevent getting rate limited.  
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
No, I do not get any of your data. The only info you put in is your username, and optionally a filepath. The API response is handled on device by the script, none of it is sent or saved anywhere.


## Changelog

#### 0.6.0 (16-04-2023)
- Biggest rework yet!
- Greatly improved Summary with dedicated handler
- Reworked Manual Sync
- Bug fixes and stability improvements

#### 0.5.0 (16-04-2023)
- Better error handling
- Escaping apostrophes with quoted form (fixes error)
- Foundation for Modes rework

#### 0.4.0 (15-04-2023)
- Encoding reworked to work automatically with flags
- Removed now-deprecated handlers
- Simplified username input

#### 0.3.0 (14-04-2023)
- Added getErrorDescription handler
- Enabled error codes recognition and different messages
- Adjusted getPlayCount handler accordingly

#### 0.2.0 (14-04-2023)
- Added on error condition to getPlayCount handler 
- Included error message in the getPlayCount handler

#### 0.1.1 (14-04-2023)
- Improvements to readability and logic structure

#### 0.1.0 (14-04-2023)
- Initial development release


## Contributing

## License

## Acknowledgments
