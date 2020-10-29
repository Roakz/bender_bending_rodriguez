# Toy Robot Challenge

This repository holds the toy robot coding challenge. I have completed the challenge with vanilla ruby.

The challenge looks like this.

```
# Toy Robot Simulator

## Description:
- The application is a simulation of a toy robot moving on a square tabletop
- The table top should have dimensions of 5 units x 5 units
- There are no obstructions on the table surface
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction
- Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed

Create an application that can read in commands of the following form:
- PLACE X,Y,FACING
- MOVE
- LEFT
- RIGHT
- REPORT

**PLACE** will put the toy robot on the table in position X, Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command
- The application should discard all commands in the sequence until a valid PLACE command has been executed

**MOVE** will move the toy robot one unit forward in the direction it is currently facing.

**LEFT** and **RIGHT** will rotate the robot 90 degrees in the specified direction without changing the position of the robot. Ie. the facing should change but the position should not.

**REPORT** will announce the X, Y and FACING of the robot. This can be in any form, but standard output is sufficient.

- A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands
- Input can be from a file, or from standard input, as the developer chooses
- Provide test data to exercise the application

## Constraints:
The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to be outside of the bounds of the table should be prevented or ignored.

**Example Input and Output:**
a)
PLACE 0, 0, NORTH
MOVE
REPORT
Output: 0, 1, NORTH

b)
PLACE 0, 0, NORTH
LEFT
REPORT
Output: 0, 0, WEST

c)
PLACE 1, 2, EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3, 3, NORTH
```

I created a small CLI resolution. The structure I went with was fairly object oriented. Creating several classes. Creating instances of them and calling there functions/passing them around.

---

## The basic structure.

### DispatchController 

The dispatch controller is the main controller of the application. It takes care of dispatching the various commands to the classes and therfore functions that are needed to resolve them.

### Gameboard

The gameboard was created for gameboard specific logic. ATM This basically just validates movements before they can occur to ensure the robot is in bounds.

### Robot

The robot class, modelled on Bender Bending Rodriguez the famous futurama robot, is keeping track of Bender and where he is at / which direction he is facing. It also takes care of if Bender was initially placed and provides benders reporting functionality.

### CommandValidator

The command validator provides the sole purpose of validating the commands before they are accepted to prevent any undesired input and movement to somne degree.

### Error Handling

There is a file for custom error classes that provide some custom messages.

---
## Gems
The only GEMS used were minitest (for basic testing) and tty for a nice prompt.

---

## Run the application

Prerequisites are an installation of ruby. I used ruby 2.7.1. Because this is what i had installed.

1. Clone the REPO
2. CD into the directory and run
```bash
 bundle install
 ```
 3. Run tests if you desire
 ```bash
  ruby minitest.rb
 ```
4. To run the application
```bash
ruby main.rb
```
5. Follow the prompts. Easiest way to get started is checkout the instructions option from the menu. This will cat out the instructions for play. If you get stuck in the command option type EXIT to escape back to the main menu.
