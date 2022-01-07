import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:wordgame/wordgame_game.dart';

class SoundButton {
  final LangawGame game;

  Sprite disabledSprite = Sprite('ui/icon-sound-disabled.png');
  Sprite enabledSprite = Sprite('ui/icon-sound-enabled.png');
  Rect rect = const Rect.fromLTWH(0, 0, 1, 1);
  bool isEnabled = true;

  SoundButton(this.game) {
    resize();
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
  }

  void onTapDown() {
    isEnabled = !isEnabled;
  }
}
