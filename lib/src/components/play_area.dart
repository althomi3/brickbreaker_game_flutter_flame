import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart'; // package to manage hitboxes

import '../brick_breaker.dart';


// Defines Play Area
class PlayArea extends RectangleComponent with HasGameReference<BrickBreaker> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xfff2e8cf),
          children: [RectangleHitbox()], // adds Hitbox as a child of the RectangleComponent matches size of parent component = game and prevents ball from dropping out of the game
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}

