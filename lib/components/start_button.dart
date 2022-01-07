import 'package:wordgame/wordgame_game.dart';
import 'package:wordgame/view.dart';
import 'package:flame/sprite.dart';
import 'package:wordgame/bgm.dart';
import 'dart:ui';

class StartButton {
  final LangawGame game;

  Rect rect = const Rect.fromLTWH(0, 0, 1, 1);
  Sprite sprite = Sprite('ui/start-button.png');

  StartButton(this.game) {
    resize();
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
  }

  void onTapDown() {
    game.score = 0;
    game.activeView = View.playing;
    game.spawner.start();
    BGM.play(BGMType.playing);
  }
}
