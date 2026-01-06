# Console Game

## Week 1: Making the game

### Day 1

Today I worked on importing the Flynn character model from Skylanders Giants, getting him cleaned up and setting him up inside the game. To set him up, I began programming the player and camera movement, the player can move in all 4 directions and should be pretty easy to swap over to joystick controls once I've created the controller. The player smoothly rotates in the direction that they're walking and the camera can orbit around the player's body. However, it currently orbits their feet so tomorrow I'll try to move it up so that the camera orbits around the player's head instead. I also quickly added jumping but I want to tweak the speed at which they fall back down because right now the player feels quite floaty.

<img width="1150" height="644" alt="image" src="https://github.com/user-attachments/assets/238d097b-35a2-42d2-91c9-a131ebc7efc0" />

### Day 2

I switched the game over to using the compatibility renderer in advance of getting the game on a console and updated the visuals so they looked as similar as possible as to when they were on the Forward+ renderer. I also completed the tweaks I said I was going to do yesterday, for example I increased the gravity to make the game feel less floaty and also made the camera orbit around the player's head instead of their feet. After I'd finished all this, the real fun began. I started with handpicking some voicelines for the player's character "Flynn" and imported them to use later. Next, I created some balls and let the player be able to push them by applying a force onto the balls, and they would also spawn from the sky which made me decide to turn them into a meteor shower. So I made them spawn in a random location, added fire and explosion particle effects, and a target for where they're going to hit the ground. I'm having a bit of an issue right now with the particles spawning in black so that will be my first focus tomorrow, after that I'd like to rattle through some more natural disasters and make the chocolate ocean look more... chocolatey... mmm.... oh and also make it drown the player when they touch it.
<br><br>
Image taken moments before disaster lol:

<img width="1150" height="646" alt="image" src="https://github.com/user-attachments/assets/684fc75b-d4ca-4b64-a769-29814b2c82cb" />

### Day 3

I started off today by making the target be affected by light so now it looks much more like it's part of the game. I eventually got a fix for the particles spawning in black which was to use GPU particles instead of CPU particles (I think CPU particles are a bit bugged and less of a priority for the devs, which is fair enough as they only have so much time) so I just need to hope the pi can handle it - although there aren't any complex particles so hopefully it should be fine. I also added chocolate bubbles to the chocolate ocean that bubble up and the meteors can now only strike the circle island instead of an invisible square shape around it. I did end up running out of time today unfortunately so I wasn't able to create more natural disasters or make some sort of building for the island, but I did start working on the round system so that I can have different disasters each round and they only last for a certain amount of time. Tomorrow though I'm likely to be busy as well so I might not get much done until day 5.

|chocolate bubbles in the chocolate ocean for the chocolate ocean addict|fixed the black particles and the target also disappears after the meteor strikes the ground|
|---|---|
|<img width="1148" height="645" alt="image" src="https://github.com/user-attachments/assets/213b7a71-a5a5-4c2b-9ffe-ea370dcc8c78" />|<img width="1148" height="644" alt="image" src="https://github.com/user-attachments/assets/cf5a7108-b43f-45fe-a8df-c4aa5fd3503c" />|

### Day 4

Just like I thought, I wasn't able to get very much done today. However, I did manage to start the UI, for example I worked on a little dialog box with Flynn's picture and imported a font to go alongside it and I also created a very primitive UI for the round which will eventually tell you what disaster is currently happening or about to happen and what to do to best avoid it. Although I wasn't physically working on the game a lot today, I was thinking about how I was going to model the maps since they will get destroyed by the disasters. I think I'll model the individual static bodies for things like walls, doors, windows and the like for performance and then replace them during gameplay with rigid bodies when they get hit by a disaster to ensure the console can handle the physics.

<img width="1148" height="646" alt="image" src="https://github.com/user-attachments/assets/471de11d-6bcf-4958-865d-2856f92b97ff" />

### Day 5

Today I spent a lot of time trying to import a map so that it would automatically make each individual mesh as a child of a rigid body but that didn't end up working so I just imported each mesh separately, manually parenting it to a rigid body and adding as basic collisions as possible to keep good performance. Once I'd placed each mesh back where they should be within the map, I edited the disaster code for the meteor shower to unfreeze the meshes when they hit them which looks pretty cool imo when you're playing in the game. After this it should be faster to add more maps and disasters now that I've done each of them once. Also after I had one of each I decided to go back to working on the rounds UI so I could code the random maps and disasters and that's where I got up to today. Tomorrow I'd like to add a tornado disaster and maybe even try to get another map in because I want to make sure this game is fully playable before working on any more beautification.

<img width="1148" height="643" alt="image" src="https://github.com/user-attachments/assets/5669e48c-db26-44d7-abfd-585a367644f8" />

### Day 6

I got a lot done on my game today which I'm very proud of, I finally programmed the round system/core loop of the game so now it's infinitely replayable although I definitely want to add more disasters and maps. Speaking of disasters, I added a tornado like I said I would except it's donut themed because why not :D and it has little mini donut particle effects that flow around it which helps the player to see where the tornado is currently in effect. I had a lot of problems trying to import the textures for the donut meshes but I eventually got it working... **eventually**. I added a UI to show which map has been chosen next and then it spawns that map in and then chooses a random disaster. I also updated the round UI so that it displays a "Disaster Warning" and tells you what the disaster is and how to avoid it. I also just did some general clean up, like I merged some of the meshes to simplify some of the collisions in the tent map to maybe help performance a bit, and there's probably other stuff I've forgotten about but yeah I got a lot done today and I'm really happy with the progress I made. Tomorrow I'd like to add a UI after a round ends to notify the player that the round has actually ended, because right now the disaster just disappears and the map despawns without telling the user anything, and I'd also like to add another map, maybe a castle map.