import 'package:wordgame/wordgame_game.dart';
import 'package:wordgame/view.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class CreditsButton {
  final LangawGame game;
  Rect rect = const Rect.fromLTWH(0, 0, 1, 1);
  Sprite sprite = Sprite('ui/icon-credits.png');

  CreditsButton(this.game) {
    resize();
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 1.25),
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
  }

  void onTapDown() {
    game.activeView = View.credits;
  }
}
