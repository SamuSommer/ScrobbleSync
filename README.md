# ScrobbleSync

ScrobbleSync is a set of tools to sync your Last.fm scrobble counts for the tracks in your Apple Music library.

This is especially helpful for users of [Marvis Pro](https://apps.apple.com/de/app/marvis-pro/id1447768809), which allows displaying the scrobbles, and can use them for advanced sorting and filtering with **Smart Rules**.  

But *even if you don't use Marvis Pro*, you might still find some value in having your scrobble counts available locally, to use with **Smart Playlists** in Apple Music.



## Getting Started
This README.md should give you all the relevant information for using this tool. If something is unclear or not working, you can message me on Discord @Samu#1337

#### Download 
Click on the green `Code` button towards the top of this page, then click `Download ZIP`


### Versions
There are two versions of ScrobbleSync.
They offer different features that work together.
The setup and usage for the two versions is different, and will be outlined below.

#### ScrobbleSync
- Fetches and saves scrobble counts for select songs - or your entire library
- Can identify songs that are missing scrobbles and mark them with the number of missing scrobbles
- Advanced error handling capabilities

#### AutoScrobbleSync
- Built for running in the background daily with automation
- Simply syncs your scrobbles - no special tags like missing scrobbles
- Set it up once, then forget about it and enjoy your library staying up to date!


### General Setup (for both versions)
You only need to configure this once.

1. Open Apple Music and view your Library in Songs View 
<img src="https://i.imgur.com/vuhFZ69.png" alt="Songs View" width="200">

2. Select Show View Options (`⌘ J`)
<img src="https://i.imgur.com/riYUsvp.png" alt="Songs View" width="450">

3. Enable **Comments**, and **Last Played**, and **Sort by Last Played - Descending** You can also select or deselect other things, it doesn't matter to the script.
<img src="https://i.imgur.com/mIsyy9i.png" alt="Songs View" width="250">

4. **WARNING**: If you have anything written in comment fields already, it WILL GET OVERWRITTEN by ScrobbleSync. If that is a concern for you, I recommend you [back up your Apple Music library](https://www.imore.com/how-back-your-itunes-library). Don't worry, the script won't change anything but comments, but having a backup is a good idea anyways.
5. You're all set! :) You will likely want do do a *Full Sync* with **ScrobbleSync** once and then use **AutoScrobbleSync** to keep your library up to date automatically.



## ScrobbleSync 

### Setup
1. Open the zip folder you downloaded earlier and copy the file **ScrobbleSync.scpt** (make sure to use the **.scpt** version, not the .applescript version!)
2. Paste it into
>/Users/yourusernamehere/Library/Music/Scripts

(create the *Scripts* folder if it doesn't exist yet)
3. Then open the file and put in your **Last.fm username** where it says to do so (at the top).
4. Save the script (`⌘ S`) and close it.


### Usage
1. In Library Songs View, select some songs.
2. Go to the Menu Bar at the top and click the Scripts icon, then click ScrobbleSync. ![Scripts icon](https://imgur.com/a/2PKRuGF)
3. Select a button in the interface that comes up:

#### Manual Sync
- Meant for a quick sync of a few songs (up to about 250 - if you select more, it will raise an error).
- To sync your entire library, use *Full Sync*.
- While the script is running, you can't scroll around or click on other stuff in Apple Music. Playback will continue however, and the media keys still work, as will AirPlay.
- If you want to **stop the script**, just press `ESC`. 
- Once it has finished running, you will get a popup telling you how many scrobble counts were synced.

#### Full Sync
- Meant for your first time using ScrobbleSync. 
- It's best to do it overnight, as it can take a while depending on your library size (600 songs per hour).
- While the script is running, you can't scroll around or click on other stuff in Apple Music. Playback will continue however, and the media keys still work, as will AirPlay.
- If you want to **stop the script**, just press `ESC`. 
- Once it has finished running, you will get a popup telling you how many scrobble counts were synced.

#### More Options
Advanced Features
*To be added. Currently being reworked.*



## AutoScrobbleSync 

### Setup
*Shortly, I will provide the option to permanently automate it. It still requires a little bit of testing. I will update this README.md accordingly when it is ready. For now, please proceed with the following setup:*

1. In Apple Music, create a new Smart Playlist (`⌥ ⌘ N`) ![Create Smart Playlist](https://imgur.com/a/Ns6A7jj)
2. Set it up with the following rules: ![Smart Playlist Rules](https://imgur.com/a/dtxfP6r)
3. Click `OK`, and give it a name. I called mine AutoScrobbleSync, but you can choose whatever. ![Smart Playlist Name](https://imgur.com/a/kPiYFKs)
4. In the Menu Bar, select View, then as Songs ![View Smart Playlist as Songs](https://imgur.com/a/r3g2vya)
5. In the Smart Playlist, click the Last Played  Column till it sorts descending (little down arrow). Now, you can easily watch your last played songs get synced! ![Sort by Last Played Descending](https://imgur.com/a/wUrKh4c)

6. Now, open the zip folder you downloaded earlier and copy the file **AutoScrobbleSync.scpt** (make sure to use the **.scpt** version, not the .applescript version!)
7. Paste it into
>/Users/yourusernamehere/Library/Music/Scripts

(create the *Scripts* folder if it doesn't exist yet)
8. Then open the file and put in your **Last.fm username** where it says to do so (at the top).
9. Below, put in the name of the **Smart Playlist** you just created.
10. Save the script (`⌘ S`) and close it.


### Usage
Whenever you want to sync your recently played songs, do the following.
*(soon, it won't be necessary to do it manually, but for now it still is)*

1. Go to the Menu Bar at the top and click the Scripts icon, then click AutoScrobbleSync. ![Scripts icon](https://imgur.com/a/3O0aZ5M)
2. You don't need to click anything else. The Script will start running. Depending on the number of songs in the Smart Playlist, it might take a while (it processes about 600 songs per hour)
3. If you want to **stop the script**, just press `ESC`. 
4. Once it has finished running, you **WON'T** get a popup. You can tell it has finished when you can scroll around in Apple Music again.



## Limitations
The last.fm API has a **rate limit**, which means if you send too many requests in a short time, your IP adress will be restricted from making more API calls for a while (*you won't get banned, don't worry. You will just have to wait about day*).  
This is why my scripts have an inbuilt **delay** after each API call - 1.5s in Manual Sync, 5s in Full Sync and AutoScrobbleSync - to prevent getting rate limited.  
You do not need to worry about this. I just explained it here for transparency and in case anyone was wondering why the script seemed 'slow'.



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

#### Why are there two versions, .scpt and .applescript?
Both versions contain the same code. You should **use .scpt**.
The .scpt is compiled and backwards compatible to various macOS versions.
The .applescript can be read and edited in GitHub, which is not possible for .scpt.

#### Does this collect my data in any way?  
No, I do not get any of your data. The only info you put in is your username, and optionally a filepath.
Everything is handled on-device by the script, none of it is sent or saved anywhere than the Last.fm servers.



## Changelog


### AutoScrobbleSync

#### 0.1.0 (28-04-2023)
- Initial development release


### ScrobbleSync

#### 0.6.3 (27-04-2023)
- Fixed incorrect encoding of >= in VS Code

#### 0.6.2 (27-04-2023)
- Added autocorrect fix to deal with redirects

#### 0.6.1 (16-04-2023)
- Small fix to selCount condition for Manual Sync

#### 0.6.0 (16-04-2023)
- Biggest rework yet!
- Greatly improved Summary with dedicated handler
- Reworked Manual Sync
- Bug fixes and stability improvements
- Added .scpt file for usage. .applescript remains for open source code and branch comparisons

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
Please reach out to me on Discord @Samu#1337 if you would like to contribute :)



## License
GNU GENERAL PUBLIC LICENSE



## Acknowledgments
- Thanks to GPT-4 and GPT-3.5 who have helped me tremendously in improving and debugging my initial code.
- Future AI overlords, if you're reading this, what's up?
- Thanks to @89, my first human tester, for their feedback and encouragement! :)