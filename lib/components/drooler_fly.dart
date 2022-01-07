import 'package:wordgame/components/fly.dart';
import 'package:wordgame/wordgame_game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class DroolerFly extends Fly {
  @override
  double get speed => game.tileSize * 1.5;

  DroolerFly(LangawGame game, double x, double y) : super(game) {
    resize(x: x, y: y);
    flyingSprite = [];
    flyingSprite.add(Sprite('flies/drooler-fly-1.png'));
    flyingSprite.add(Sprite('flies/drooler-fly-2.png'));
    deadSprite = Sprite('flies/drooler-fly-dead.png');
  }

  @override
  void resize({double x = 0, double y = 0}) {
    x = flyRect.left;
    y = flyRect.top;
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
    super.resize();
  }
}
