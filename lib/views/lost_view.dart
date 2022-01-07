import 'package:wordgame/wordgame_game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class LostView {
  final LangawGame game;
  Rect rect = const Rect.fromLTWH(0, 0, 1, 1);
  Sprite sprite = Sprite('bg/lose-splash.png');

  LostView(this.game) {
    resize();
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
  }
}
