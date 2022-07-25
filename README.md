# Godot-XR-Simple-Airplane
 Simple Airplane for use with Godot XR plugin and XR-Tools plugin

To try it out, just open the project in Godot 3.5 rc7 or later and hit play.

There is a release for a quest native apk.  Not much to do, just for testing, not a game.

To use in your own project, copy the following over to your project AFTER you have already installed the latest Godot XR plugin and Godot XR tools plugin:

Put in the root of your directory (same place as your project.godot)
(1) plane folder

(2) sketchfab folder (at minimum with the "sopwith" model inside)

Put in your addons/godot-xr-tools folder:

(1) interactables folder

(2) objects folder (override existing)

Once you have done that, open your project, and:

(1) Create a new "node" (plain node), call it "AirplaneController" and attach the AirplaneController.gd script found in the plane folder to it

(2) drop in the Plane.tscn found in the plane folder into your project as a child of the AirplaneController node

(3) Set your pickup function to be able to collide with layers 18 / 19 in order to grab the yoke and throttle

The plane assumes your world collision is on level 1, so the collision body of the plane is 1, but other things like the base of the yoke and throttle are layer 3 so as to avoid odd collisions physics with it.

If your world collision level is on something else you will have to adjust those accordingly.