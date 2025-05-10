   import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/components.dart';
import 'config.dart';

// defines our game by extending FlameGame

class BrickBreaker extends FlameGame {
  BrickBreaker()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth, // defined in config file
            height: gameHeight, // defined in config file
          ),
        );

  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft; // anchors viewfinder to top left

    world.add(PlayArea()); // ads play area which defines the game dimensions
  }
}
