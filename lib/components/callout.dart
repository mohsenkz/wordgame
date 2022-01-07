import 'package:wordgame/components/fly.dart';
import 'package:flutter/painting.dart';
import 'package:wordgame/view.dart';
import 'package:wordgame/bgm.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'dart:ui';

class Callout {
  final Fly fly;
  Rect rect = const Rect.fromLTWH(0, 0, 1, 1);
  Sprite sprite = Sprite('ui/callout.png');
  double value = 1;

  TextPainter tp = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  Offset textOffset = const Offset(0, 0);

  Callout(this.fly);

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    tp.paint(c, textOffset);
  }

  void update(double t) {
    if (fly.game.activeView == View.playing) {
      value = value - .5 * t;
      if (value <= 0) {
        if (fly.game.soundButton.isEnabled) {
          Flame.audio.play(
              'sfx/haha' + (fly.game.rnd.nextInt(5) + 1).toString() + '.ogg');
        }
        BGM.play(BGMType.home);
        fly.game.activeView = View.lost;
      }
    }

    rect = Rect.fromLTWH(
      fly.flyRect.left - (fly.game.tileSize * .75),
      fly.flyRect.top - (fly.game.tileSize * .625),
      fly.game.tileSize * .75,
      fly.game.tileSize * .75,
    );

    tp.text = TextSpan(
      text: (value * 10).toInt().toString(),
      style: TextStyle(
        color: Color(0xffffffff),
        fontSize: fly.game.tileSize * .375,
      ),
    );
    tp.layout();
    textOffset = Offset(
      rect.center.dx - (tp.width / 2),
      rect.top + (rect.height * .4) - (tp.height / 2),
    );
  }
}
