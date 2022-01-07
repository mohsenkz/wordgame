import 'package:wordgame/wordgame_game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class Backyard {
  final LangawGame game;
  Sprite bgSprite = Sprite('bg/backyard.png');
  Rect bgRect = const Rect.fromLTWH(0, 0, 1, 1);

  Backyard(this.game);

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void resize() {
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 9,
      game.tileSize * 23,
    );
  }

  void update(double t) {}
}
