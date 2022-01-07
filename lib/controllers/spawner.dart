import 'package:wordgame/components/fly.dart';
import 'package:wordgame/wordgame_game.dart';

class FlySpawner {
  final LangawGame game;

  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int maxFliesOnScreen = 7;
  final int intervalChange = 3;
  int currentInterval = 0;
  int nextSpawn = 0;

  FlySpawner(this.game) {
    start();
    game.spawnFly();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    for (var fly in game.flies) {
      fly.isDead = true;
    }
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    for (var fly in game.flies) {
      if (!fly.isDead) livingFlies += 1;
    }

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnFly();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
