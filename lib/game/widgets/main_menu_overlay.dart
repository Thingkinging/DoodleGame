import 'package:flame/game.dart';
import 'package:flame_game/game/doodle_dash.dart';
import 'package:flutter/material.dart';

class MainMenuOverlay extends StatefulWidget {
  final Game game;

  const MainMenuOverlay(this.game, {super.key});

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  Character character = Character.dash;

  @override
  Widget build(BuildContext context) {
    DoodleDash game = widget.game as DoodleDash;

    return LayoutBuilder(
      builder: (context, constraints) {
        final characterWidth = constraints.maxWidth / 5;

        final TextStyle titleStyle = (constraints.maxWidth > 830)
            ? Theme.of(context).textTheme.displayLarge!
            : Theme.of(context).textTheme.displaySmall!;

        final bool screenHeightIsSmall = constraints.maxHeight < 760;

        return Material(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Doodle Dash',
                      style: titleStyle.copyWith(
                        height: 7,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: Text('Select your character:',
                          style: Theme.of(context).textTheme.headlineSmall!),
                    ),
                    Container(height: 20),
                    if (!screenHeightIsSmall) SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CharacterButton(
                          character: Character.sparky,
                          selected: character == Character.sparky,
                          onSelectChar: () {
                            setState(() {
                              character = Character.sparky;
                            });
                          },
                          characterWidth: characterWidth,
                        ),
                      ],
                    ),
                    if (!screenHeightIsSmall) SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Difficulty:',
                            style: Theme.of(context).textTheme.bodyLarge!),
                        LevelPicker(
                          level: game.levelManager.selectedLevel.toDouble(),
                          label: game.levelManager.selectedLevel.toString(),
                          onChanged: ((value) {
                            setState(() {
                              game.levelManager.selectLevel(value.toInt());
                            });
                          }),
                        ),
                      ],
                    ),
                    if (!screenHeightIsSmall) SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          game.gameManager.selectCharacter(character);
                          game.startGame();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(100, 50),
                          ),
                          textStyle: MaterialStateProperty.all(
                              Theme.of(context).textTheme.titleLarge),
                        ),
                        child: Text('Start'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LevelPicker extends StatelessWidget {
  final double level;
  final String label;
  final void Function(double) onChanged;

  const LevelPicker({
    super.key,
    required this.level,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Slider(
        value: level,
        max: 5,
        min: 1,
        divisions: 4,
        label: label,
        onChanged: onChanged,
      ),
    );
  }
}

class CharacterButton extends StatelessWidget {
  final Character character;
  final bool selected;
  final void Function() onSelectChar;
  final double characterWidth;

  const CharacterButton({
    super.key,
    required this.character,
    this.selected = false,
    required this.onSelectChar,
    required this.characterWidth,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: (selected)
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(31, 64, 195, 255)))
          : null,
      onPressed: onSelectChar,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/game/${character.name}_center.png',
              height: characterWidth,
              width: characterWidth,
            ),
            SizedBox(height: 18),
            Text(
              character.name,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
