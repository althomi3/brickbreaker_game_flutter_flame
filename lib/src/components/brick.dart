import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';
import '../config.dart';
import 'ball.dart';
import 'bat.dart';

class Brick extends RectangleComponent // extends Rectangle and uses collision detection
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Brick({required super.position, required Color color})
      : super(
          size: Vector2(brickWidth, brickHeight),
          anchor: Anchor.center,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
          children: [RectangleHitbox()],
        );

  @override
  void onCollisionStart( // defines logic for collision when ball hits the brick
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent(); // brick will be removed
    game.score.value++; // increase score when brick brocken

    // win the game:
    if (game.world.children.query<Brick>().length == 1) { // defines to remove all bricks when there is only one brick left
      game.playState = PlayState.won;  // sets game state to won when bricks removed
      game.world.removeAll(game.world.children.query<Ball>()); // removes ball
      game.world.removeAll(game.world.children.query<Bat>()); // removes bat
    }
  }
}
