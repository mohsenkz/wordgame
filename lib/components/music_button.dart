import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:wordgame/bgm.dart';
import 'package:wordgame/wordgame_game.dart';

class MusicButton {
  final LangawGame game;
  Rect rect = const Rect.fromLTWH(0, 0, 1, 1);
  Sprite enabledSprite = Sprite('ui/icon-music-enabled.png');
  Sprite disabledSprite = Sprite('ui/icon-music-disabled.png');
  bool isEnabled = true;

  MusicButton(this.game) {
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
      game.tileSize * .25,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      BGM.pause();
    } else {
      isEnabled = true;
      BGM.resume();
    }
  }
}
