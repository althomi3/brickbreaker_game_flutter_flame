import 'package:flutter/material.dart';                



// Game dimensions
const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02;

// Bat dimensions
const batWidth = gameWidth * 0.2;                             
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;   // defines the steps a bat moves on user interaction

// Brick dimensions
const brickGutter = gameWidth * 0.015;                          
final brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1)))
    / brickColors.length;
const brickHeight = gameHeight * 0.03;
const difficultyModifier = 1.03;  

const brickColors = [                                           
  Color(0xfff94144),
  Color(0xfff3722c),
  Color(0xfff8961e),
  Color(0xfff9844a),
  Color(0xfff9c74f),
  Color(0xff90be6d),
  Color(0xff43aa8b),
  Color(0xff4d908e),
  Color(0xff277da1),
  Color(0xff577590),
];




