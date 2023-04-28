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
<img src="https://i.imgur.com/riYUsvp.png" alt="Show View Options" width="450">

3. Enable **Comments**, and **Last Played**. You can also select or deselect other things as you like, it doesn't matter to the script.

*Recommended:* At the top, set *Sort by* to **Last Played** and **Descending**. This will facilitate seeing if recent songs have been synced.
<img src="https://i.imgur.com/mIsyy9i.png" alt="View Options Settings" width="250">

4. **WARNING**: If you have anything written in comment fields already, it WILL GET OVERWRITTEN by ScrobbleSync. If that is a concern for you, I recommend you [back up your Apple Music library](https://www.imore.com/how-back-your-itunes-library). Don't worry, the script won't change anything but comments, but having a backup is a good idea anyways.
5. You're all set! :) You will likely want do do a *Full Sync* with **ScrobbleSync** next and then use **AutoScrobbleSync** to keep your library up to date automatically.



## ScrobbleSync 

### Setup
1. Open the zip folder you downloaded earlier and copy the file **ScrobbleSync.scpt** (make sure to use the **.scpt** version, not the .applescript version!)
2. Go to 
>~/Library/Music/

You can do this by using Finder's *Go to Folder* command (`⇧ ⌘ G`), pasting the filepath in and pressing `Enter`. 

Alternatively, you can paste the filepath into Spotlight Search (`⌘ SPACE`)and click the folder in the results:
<img src="https://i.imgur.com/miQwB1Z.png" alt="Spotlight Search Filepath" width="600">

3. Likely, you need to create a new folder called **Scripts** here, unless it's already there.
4. Paste the **ScrobbleSync.scpt** into the Scripts folder.
5. Then open the file and put in your **Last.fm username** where it says to do so (at the top).
6. Save the script (`⌘ S`) and close it.


### Usage
1. In Library Songs View, select some songs.
2. Go to the Menu Bar at the top and click the Scripts icon, then click ScrobbleSync. 
<img src="https://i.imgur.com/KdTsk8J.png" alt="Click ScrobbleSync Script" width="600">

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

1. In Apple Music, create a new Smart Playlist (`⌥ ⌘ N`)
<img src="https://i.imgur.com/cVuMmYp.png" alt="Create Smart Playlist" width="550">

2. Set it up like this:
<img src="https://i.imgur.com/bFdwyoE.png" alt="Smart Playlist Rules" width="650">

3. Click `OK`, and give it a name. I called mine AutoScrobbleSync, but you can choose whatever. 
<img src="https://i.imgur.com/NbdmCsU.png" alt="Smart Playlist Name" width="350">

4. While still viewing the playlist, in the Menu Bar, select View, then as Songs
<img src="https://i.imgur.com/pnhDNRr.png" alt="View Smart Playlist as Songs" width="650">

5. Click the Last Played Column until it sorts descending (little down arrow **˯** next to it). Now, you can easily watch your last played songs get synced! 
<img src="https://i.imgur.com/sJKu6nO.png" alt="Sort by Last Played Descending" width="650">

6. Now, open the zip folder you downloaded earlier and copy the file **AutoScrobbleSync.scpt** (make sure to use the **.scpt** version, not the .applescript version!)
7. Go to 
>~/Library/Music/

You can do this by using Finder's *Go to Folder* command (`⇧ ⌘ G`), pasting the filepath in and pressing `Enter`.

Alternatively, you can paste the filepath into Spotlight Search (`⌘ SPACE`)and click the folder in the results:
<img src="https://i.imgur.com/miQwB1Z.png" alt="Spotlight Search Filepath" width="600">

8. Likely, you need to create a new folder called **Scripts** here, unless it's already there.
9. Paste the **AutoScrobbleSync.scpt** into the Scripts folder.
10. Then open the file and put in your **Last.fm username** where it says to do so (at the top).
11. Below, put in the name of the **Smart Playlist** you just created.
12. Save the script (`⌘ S`) and close it.


### Usage
Whenever you want to sync your recently played songs, do the following.
*(soon, it won't be necessary to do it manually, but for now it still is...)*

1. Go to the Menu Bar at the top and click the Scripts icon, then click AutoScrobbleSync.
<img src="https://i.imgur.com/IwTUCPb.png" alt="Click AutoScrobbleSync Script" width="600">

2. You don't need to click anything else. The Script will start running. Depending on the number of songs in the Smart Playlist, it might take a while (it processes about 600 songs per hour)
3. If you want to **stop the script**, just press `ESC`. 
4. Once it has finished running, you **WON'T** get a popup. You can tell it has finished when you can scroll around in Apple Music again. *I am working on System Notification support for the next updates.*



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

The .scpt is compiled, which makes it backwards compatible to various macOS versions, and also more performant. 

The .applescript can be read and edited in VS Code and GitHub, which is not possible for .scpt. Also, like this, you can inspect the code before you download it.

#### Does this collect my data in any way?  
No, I do not get any of your data. The only info you put in is your username, and optionally a filepath.
Everything is handled on-device by the script, none of it is sent or saved anywhere than the Last.fm servers.



## Changelog


### AutoScrobbleSync

#### 0.2.0 (29-04-2023)
- Added conditions to check for username and playlist name

#### 0.1.0 (28-04-2023)
- Initial development release


### ScrobbleSync

#### 0.6.4 (29-04-2023)
- Added check for username condition

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