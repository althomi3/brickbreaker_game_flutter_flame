import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:math' as math;
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'components/components.dart';
import 'config.dart';

// defines our game by extending FlameGame
// adds mixins to work with collision detection and get keyboard interaction, e.g., to move bat
class BrickBreaker extends FlameGame with HasCollisionDetection, KeyboardEvents {
  BrickBreaker()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth, // defined in config file
            height: gameHeight, // defined in config file
          ),
        );

  final rand = math.Random();  
  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft; // anchors viewfinder to top left

    world.add(PlayArea()); // ads play area which defines the game dimensions

    // adds play ball
    world.add(Ball(                // instantiates the ball we created in ball.dart and adds values for props that were defined in constructor                              
          difficultyModifier: difficultyModifier,
          radius: ballRadius,
          position: size / 2, // centers the ball's position
          velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2) // sets a random velocity for x and defines velocity for y
              .normalized() // normalized vector and keeps speed consistent
            ..scale(height / 4))); // scales up velocity to be 1/4th of screen height

    world.add(Bat(                                              
        size: Vector2(batWidth, batHeight),
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95)));
    
    // adds bricks to the world
    await world.addAll([                                        
      for (var i = 0; i < brickColors.length; i++) // creates as many bricks in the row as there are colors
        for (var j = 1; j <= 5; j++) // creates 5 rows
          Brick(
            position: Vector2( // positions bricks
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: brickColors[i],
          ),
    ]);    

    debugMode = true; 

  }

  @override // defines functionality for key interaction                                                   
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep); // uses bat step which is defined as a const in config.dart
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
    }
    return KeyEventResult.handled;
  }        
  
}
