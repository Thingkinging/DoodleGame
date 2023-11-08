import 'package:flame/game.dart';
import 'package:flame_game/game/doodle_dash.dart';
import 'package:flame_game/game/widgets/score_display.dart';
import 'package:flutter/material.dart';

class GameOverlay extends StatefulWidget {
  final Game game;
  GameOverlay(this.game, {super.key});

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: ScoreDisplay(game: widget.game),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: ElevatedButton(
              child: isPaused
                  ? Icon(
                      Icons.play_arrow,
                      size: 48,
                    )
                  : Icon(
                      Icons.pause,
                      size: 48,
                    ),
              onPressed: () {
                (widget.game as DoodleDash).togglePauseState();
                setState(() {
                  isPaused = !isPaused;
                });
              },
            ),
          ),
          if (isPaused)
            Positioned(
                top: MediaQuery.of(context).size.height / 2 - 72.0,
                right: MediaQuery.of(context).size.width / 2 - 72.0,
                child: Icon(
                  Icons.pause_circle,
                  size: 144,
                  color: Colors.black12,
                )),
        ],
      ),
    );
  }
}
