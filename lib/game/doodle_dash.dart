import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'managers/managers.dart';
import 'package:flame_game/game/world.dart';
import 'package:flutter/material.dart';

enum Character { dash, sparky }

class DoodleDash extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  DoodleDash({super.children});

  final World _world = World();
  GameManager gameManager = GameManager();
  LevelManager levelManager = LevelManager();
  int screenBufferSpace = 300;
  ObjectManager objectManager = ObjectManager();

  @override
  FutureOr<void> onLoad() async {
    await add(_world);

    await add(gameManager);

    overlays.add('gameOverlay');

    await add(levelManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameManager.isIntro) {
      // overlays.add('mainMenuOverlay');
      return;
    }

    if (gameManager.isPlaying) {
      checkLevelUp();
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void initializeGameStart() {
    gameManager.reset();

    if (children.contains(objectManager)) objectManager.removeFromParent();

    levelManager.reset();

    objectManager = ObjectManager(
        minVerticalDistanceToNextPlatform: levelManager.minDistance,
        maxVerticalDistanceToNextPlatform: levelManager.maxDistance);

    add(objectManager);

    objectManager.configure(levelManager.level, levelManager.difficulty);
  }

  void setCharacter() {}

  void startGame() {
    initializeGameStart();
    gameManager.state = GameState.playing;
    // overlays.remove('mainMenuOverlay');
  }

  void resetGame() {
    startGame();
    // overlays.remove('gameOverOverlay');
  }

  void togglePauseState() {
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }

  void checkLevelUp() {
    if (levelManager.shouldLevelUp(gameManager.scroe.value)) {
      levelManager.increaseLevel();

      objectManager.configure(levelManager.level, levelManager.difficulty);
    }
  }
}
