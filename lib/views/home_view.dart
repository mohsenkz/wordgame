import 'package:wordgame/wordgame_game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class HomeView {
  final LangawGame game;

  Sprite titleSprite = Sprite('branding/title.png');
  Rect titleRect = const Rect.fromLTWH(0, 0, 1, 1);

  HomeView(this.game) {
    resize();
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 4),
      game.tileSize * 7,
      game.tileSize * 4,
    );
  }
}
