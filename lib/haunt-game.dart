import 'dart:ui';

import 'package:flame/component.dart';
import 'package:flame/game.dart';

import 'box2d/ninja_world.dart';

class HauntGame extends Game {
  Size dimensions;

  ParallaxComponent background;

  NinjaWorld ninjaWorld;

  HauntGame(this.dimensions) {
    var filenames = new List<String>();
    for (var i = 1; i <= 7; i++) {
      filenames.add("layers/layer_0${i}.png");
    }

    ninjaWorld = createNinjaWorld(dimensions);
    background = new ParallaxComponent(dimensions, filenames);

    window.onPointerDataPacket = (packet) {
      var pointer = packet.data.first;
      print("pointer: $pointer, ${pointer.pressure}, ${pointer.change}");
      input(pointer.physicalX, pointer.physicalY);
    };
  }

  NinjaWorld createNinjaWorld(Size dimensions) {
    var demo = new NinjaWorld(dimensions);
    demo.initializeWorld();
    return demo;
  }

  void input(double x, double y) {
    ninjaWorld.input(x, y);
  }

  @override
  void render(Canvas canvas) {
    if (!background.loaded) {
      return;
    }
//    background.render(canvas);
    ninjaWorld.render(canvas);
  }

  @override
  void update(double t) {
    if (!background.loaded) {
      return;
    }

//    background.update(t);
    ninjaWorld.update(t);
  }
}
