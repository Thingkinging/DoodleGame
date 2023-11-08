import 'package:flame/game.dart';
import 'package:flame_game/game/doodle_dash.dart';
import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  final Game game;
  final bool isLight;

  const ScoreDisplay({super.key, required this.game, this.isLight = false});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as DoodleDash).gameManager.scroe,
      builder: (context, value, child) {
        return Text(
          'Score: $value',
          style: Theme.of(context).textTheme.displaySmall!,
        );
      },
    );
  }
}
