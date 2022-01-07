import 'package:wordgame/wordgame_game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class HelpView {
  final LangawGame game;

  Sprite sprite = Sprite('ui/dialog-help.png');
  Rect rect = const Rect.fromLTWH(0, 0, 1, 1);

  HelpView(this.game) {
    resize();
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * .5,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 8,
      game.tileSize * 12,
    );
  }
}
