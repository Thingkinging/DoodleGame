import 'package:flame/components.dart';
import 'package:flame_game/game/doodle_dash.dart';
import 'package:flutter/material.dart';

enum GameState { intro, playing, gameOver }

class GameManager extends Component with HasGameRef<DoodleDash> {
  GameManager();

  Character character = Character.dash;
  ValueNotifier<int> scroe = ValueNotifier(0);
  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  void reset() {
    scroe.value = 0;
    state = GameState.intro;
  }

  void increaseScore() {
    scroe.value++;
  }

  void selectCharacter(Character selectedCharacter) {
    character = selectedCharacter;
  }
}
