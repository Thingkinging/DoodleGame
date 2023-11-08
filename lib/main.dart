import 'package:flame/game.dart';
import 'package:flame_game/game/doodle_dash.dart';
import 'package:flame_game/game/widgets/game_over_overlay.dart';
import 'package:flame_game/game/widgets/game_overlay.dart';
import 'package:flame_game/game/widgets/main_menu_overlay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game/util/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doodle Dash',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.audiowideTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Doodle Dash'),
    );
  }
}

final Game game = DoodleDash();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: 800,
              minWidth: 500,
            ),
            child: GameWidget(
              game: game,
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                'gameOverlay': (context, game) => GameOverlay(game),
                'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                'gameOverOverlay': (context, game) => GameOverOverlay(game),
              },
            ),
          );
        }),
      ),
    );
  }
}
