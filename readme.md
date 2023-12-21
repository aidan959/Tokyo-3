# Project Title

Name: Tokyo-3

Student Number: C20394933 & C20381946

Class Group: TU856/4

Video: 
[![YouTube](images/Our-Tokyo3.png)](https://youtu.be/VgjHtrhDxOo)

# Description of the project
In the hit anime Evangelion, there is a futiristic city shown which sinks into the ground when in danger. This type of futurism is intriguing and we sought to recreate the environment and vibe for our project. We want players to truly experience how  this life could be. https://www.reddit.com/r/NeonGenesisEvangelion/comments/q7erof/this_is_tokyo3_this_is_our_city_and_its_the_city/ here attached

# Instructions for use
- WASD <- Movement keys
- SPACE / MOUSEWHEEL UP + DOWN <- Jump
- E <- Interact
- C <- Save point
- V <- Reload to save point
- ESC <- quit

# Bunny hopping, or "bhopping"
This a technique used to increase speed and maneuverability.
It involves a sequence of jumps, performed at the point of contact with the ground, to prevent a speed penalty, paired with the player's movement and turning

Here's a basic overview of how to bhop:

1. Start Running: Begin by running forward in the game.
2. Jump: As you start moving, jump.
3. Mid-Air Movement: While in the air, slightly turn your character in the direction you want to go and strafe (move sideways) in that direction. For example, if you turn right, strafe right.
4. Timing the Jumps: As soon as you land, jump again and repeat the process – turn and strafe in the same or opposite direction.
5. Rhythm and Momentum: The key to successful bhopping is maintaining a rhythm. Each jump and strafe should be smooth and timed to maintain or build speed. ( for this project "autohop" is enabled and so therefore rhythm is not as important)

# How it works
Game has a simple interactable button which causes the building animation to begin. The remainder of the game is a clone of the "bhop" mechanic from Quake / Source engine games.
The button emits a signal which begins the animation. The player movement is then utilized to complete the platforming aspect of the game.
# List of classes/assets in the project

| Class/asset | Source |
|-----------|-----------|
| player.gd | Self written - inspired by research done on [this paper](https://www.theseus.fi/bitstream/handle/10024/507593/Peltola_Mikko.pdf?sequence=2&isAllowed=y#:~:text=In%20it's%20most%20common%20form,into%20the%20held%20strafe%20direction.) in Unity |
| Interactable.gd | Self written |
| ButtonPress.gd | Self written |
| FrontTowerRise.gd | Self written |
| FrontTowerRise.gd | Modified from [this video](https://www.youtube.com/watch?v=7L6ZUYj1hs8)
| outline2.gdshader | Modified from [this article](https://godotshaders.com/shader/complete-cel-shader-for-godot-4/) |
| cel-shader-base.gdshader | From [this article](https://godotshaders.com/shader/complete-cel-shader-for-godot-4/) |
| HTerrain.gd | Incredible plugin from [this repo](https://github.com/Zylann/godot_heightmap_plugin) |

# References
* https://www.theseus.fi/bitstream/handle/10024/507593/Peltola_Mikko.pdf?sequence=2&isAllowed=y#:~:text=In%20it's%20most%20common%20form,into%20the%20held%20strafe%20direction.
* https://www.youtube.com/watch?v=7L6ZUYj1hs8
* https://github.com/Zylann/godot_heightmap_plugin
* https://www.youtube.com/watch?v=1i5SB8Ct1y0&t=244s


# What I am most proud of in the assignment
### Aidan:
Learned many new techniques in 3D modelling and how to do basic animation in Godot.

### Matthew
The level design of the city and the offset of each tower/towerblock to achieve a strong effect when the city rises from the ground.

# What I learned
### Aidan
Learned many features of the godot engine.
3D modelling techniqes and animation.
How to write movement code.
How to utilize signals to run events.
Working with audio and particle systems in Godot.
Level design principles and info regarding normals and mesh optimization (reducing draw calls by combining models)
### Matthew
Expanded my knowledge of Godot and the features it provides.
Layering of scenes.
How to apply shaders to objects.
Using signals to achieve synchronised script execution.
Aspects of level design and layout.
How to have Area3D nodes affect the playermodel/camera.

# Proposal submitted earlier can go here:
In the hit anime Evangelion, there is a futiristic city shown which sinks into the ground when in danger. This type of futurism is intriguing and we sought to recreate the environment and vibe for our project. We want players to truly experience how  this life could be. https://www.reddit.com/r/NeonGenesisEvangelion/comments/q7erof/this_is_tokyo3_this_is_our_city_and_its_the_city/ here attached


## The shot from Evangelion which inspired this project:
![Tokyo-3](images/Tokyo-3-Rising.png)

## This is an image of the same attempted scene:
![Our Tokyo-3](images/Our-Tokyo3.png)

## A shot of the escalator from Evangelion:
![image](images/Escalator.png)

## Escalator Recreation:
![image](images/Our-Escalator.png)

## Tube scene from Evangelion:
![image](images/Rei-Tube.png)

## Recreation:
![image](images/Our-Rei-Tube.png)
