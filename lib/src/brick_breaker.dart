   import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:math' as math; // Add this import


import 'components/components.dart';
import 'config.dart';

// defines our game by extending FlameGame

class BrickBreaker extends FlameGame with HasCollisionDetection {
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
          radius: ballRadius,
          position: size / 2, // centers the ball's position
          velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2) // sets a random velocity for x and defines velocity for y
              .normalized() // normalized vector and keeps speed consistent
            ..scale(height / 4))); // scales up velocity to be 1/4th of screen height

      debugMode = true; 

  }
  
}
