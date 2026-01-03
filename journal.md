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

I started off today by making the target be affected by light so now it looks much more like it's part of the game. I eventually got a fix for the particles spawning in black which was to use GPU particles instead of CPU particles (I think CPU particles are a bit bugged and less of a priority for the devs, which is fair enough as they only have so much time) so I just need to hope the pi can handle it - although there aren't any complex particles so hopefully it should be fine. I also added chocolate bubbles to the chocolate ocean that bubble up and the meteors can now only strike the circle island instead of an invisible square shape around it. I did end up running out of time today unfortunately so I wasn't able to create more natural disasters or make some sort of building for the island, but I did start working on the round system so that I can have different disasters each round and they only last for a certain amount of time. Tomorrow I'm likely to be busy as well so I might not get much done until day 5.