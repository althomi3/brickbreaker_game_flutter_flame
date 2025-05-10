import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'bat.dart';

import '../brick_breaker.dart';                                 // And this import
import 'play_area.dart';

// defines play ball
class Ball extends CircleComponent with CollisionCallbacks, HasGameReference<BrickBreaker> { // mixins for collision detection
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill,
              children: [CircleHitbox()],
              );
            

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt; // defines velocity and position through velocity
  }

  // adds callback for collision detection. callback called in brick_breaker
  @override                                                     
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other); // intersectionPoints = position where two objects collide
    if (other is PlayArea) { // checks if object collides with something else than PlayArea, e.g., Bricks
      if (intersectionPoints.first.y <= 0) { // checks if there is a collision on the y axis and then adjusts velocity to opposite direction
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        add(RemoveEffect( // removes ball from game world                                      
          delay: 0.35,
        ));
      }
    } else if (other is Bat) { // if ball collides with bat, then the velocity and position are adjusted
      velocity.y = -velocity.y; // y velocity is reversed to that ball is kicked up
      velocity.x = velocity.x + // x velocity is adjusted so that ball gets a new angle
          (position.x - other.position.x) / other.size.x * game.width * 0.3;

      }
     else {
      debugPrint('collision with $other');
    }
  }    

}
