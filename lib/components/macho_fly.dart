import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:wordgame/components/fly.dart';
import 'package:wordgame/wordgame_game.dart';

class MachoFly extends Fly {
  @override
  double get speed => game.tileSize * 2.5;

  MachoFly(LangawGame game, double x, double y) : super(game) {
    resize(x: x, y: y);
    flyingSprite = [];
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }

  @override
  void resize({double x = 0, double y = 0}) {
    x = flyRect.left;
    y = flyRect.top;
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.35, game.tileSize * 1.35);
    super.resize();
  }
}
