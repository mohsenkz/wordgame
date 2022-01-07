import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordgame/components/highscore_display.dart';
import 'package:wordgame/components/credits_button.dart';
import 'package:wordgame/components/score_display.dart';
import 'package:wordgame/components/music_button.dart';
import 'package:wordgame/components/sound_button.dart';
import 'package:wordgame/components/start_button.dart';
import 'package:wordgame/components/drooler_fly.dart';
import 'package:wordgame/components/help_button.dart';
import 'package:wordgame/components/hungry_fly.dart';
import 'package:wordgame/components/house_fly.dart';
import 'package:wordgame/components/macho_fly.dart';
import 'package:wordgame/components/agile_fly.dart';
import 'package:wordgame/components/backyard.dart';
import 'package:wordgame/controllers/spawner.dart';
import 'package:wordgame/views/credits_view.dart';
import 'package:wordgame/views/help_view.dart';
import 'package:wordgame/views/home_view.dart';
import 'package:wordgame/views/lost_view.dart';
import 'package:wordgame/components/fly.dart';
import 'package:flutter/gestures.dart';
import 'package:wordgame/view.dart';
import 'package:wordgame/bgm.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'dart:math';
import 'dart:ui';

class LangawGame extends Game {
  final SharedPreferences storage;
  late double tileSize = 0;
  late Size screenSize;
  late Random rnd;

  late HighscoreDisplay highscoreDisplay;
  late CreditsButton creditsButton;
  late ScoreDisplay scoreDisplay;
  late MusicButton musicButton;
  late SoundButton soundButton;
  late StartButton startButton;
  late CreditsView creditsView;
  late HelpButton helpButton;
  late Backyard background;
  late FlySpawner spawner;
  late HomeView homeView;
  late LostView lostView;
  late HelpView helpView;

  View activeView = View.home;
  List<Fly> flies = [];
  int score = 0;

  LangawGame(this.storage) {
    initialize();
  }

  Future<void> initialize() async {
    rnd = Random();
    flies = [];
    score = 0;

    resize(Size.zero);

    highscoreDisplay = HighscoreDisplay(this);
    creditsButton = CreditsButton(this);
    scoreDisplay = ScoreDisplay(this);
    creditsView = CreditsView(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    background = Backyard(this);
    spawner = FlySpawner(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    helpView = HelpView(this);

    BGM.play(BGMType.home);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.025))) +
        (tileSize * 1.5);

    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);

    highscoreDisplay.render(canvas);
    if (activeView == View.playing || activeView == View.lost) {
      scoreDisplay.render(canvas);
    }

    for (var fly in flies) {
      fly.render(canvas);
    }

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }
    musicButton.render(canvas);
    soundButton.render(canvas);
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  @override
  void update(double t) {
    spawner.update(t);
    for (var fly in flies) {
      fly.update(t);
    }
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    if (activeView == View.playing) scoreDisplay.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

    background.resize();

    highscoreDisplay.resize();
    scoreDisplay.resize();
    for (var fly in flies) {
      fly.resize();
    }

    homeView.resize();
    lostView.resize();
    helpView.resize();
    creditsView.resize();

    startButton.resize();
    helpButton.resize();
    creditsButton.resize();
    musicButton.resize();
    soundButton.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // dialog boxes
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    // music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    // help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    // start button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // flies
    if (!isHandled) {
      bool didHitAFly = false;
      for (var fly in flies) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      }

      if (activeView == View.playing && !didHitAFly) {
        if (soundButton.isEnabled) {
          Flame.audio
              .play('sfx/haha' + (rnd.nextInt(5) + 1).toString() + '.ogg');
        }
        BGM.play(BGMType.home);
        activeView = View.lost;
      }
    }
  }
}
