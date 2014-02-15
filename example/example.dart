library example02;

import 'dart:html' as html;
import 'dart:math' as math;
//import 'package:stagexl/stagexl.dart';
import '../lib/stagexl.dart';

var canvas = html.querySelector('#stage');
var stage = new Stage(canvas, webGL: true, color: Color.White);
var renderLoop = new RenderLoop();
var resourceManager = new ResourceManager();

void main() {

  renderLoop.addStage(stage);

  resourceManager = new ResourceManager()
    ..addBitmapData("house", "images/House.png")
    ..addBitmapData("sun", "images/Sun.png")
    ..addBitmapData("tree", "images/Tree.png");

  resourceManager.load().then((result) {

    //var colorMatrixFilter = new ColorMatrixFilter.grayscale();
    var colorMatrixFilter = new ColorMatrixFilter.invert();
    //var colorMatrixFilter = new ColorMatrixFilter.identity();
    //var colorMatrixFilter = new ColorMatrixFilter.adjust(contrast: 1);
    var blurFilter = new BlurFilter(8, 8);
    var glowFilter = new GlowFilter(Color.Red, 16, 16);
    var dropShadowFilter = new DropShadowFilter(10, math.PI / 4, Color.Red, 8, 8);

    var world1 = new World();
    world1.addTo(stage);
    world1.x = - 100;

    var world2 = new World();
    world2.addTo(stage);
    world2.x = 100;

    //world1.alpha = 0.5;
    //world2.alpha = 0.5;

    //world1.filters= [colorMatrixFilter];
    //world2.filters= [colorMatrixFilter];

    //world1.filters= [blurFilter];
    //world2.filters= [blurFilter];

    //world1.filters= [glowFilter];
    //world2.filters= [glowFilter];

    world1.filters= [dropShadowFilter];
    world2.filters= [dropShadowFilter];

    //world1.filters= [colorMatrixFilter, blurFilter];
    //world2.filters= [colorMatrixFilter, blurFilter];

    //world1.filters= [glowFilter, colorMatrixFilter];
    //world2.filters= [glowFilter, colorMatrixFilter];

    world2.applyCache(220, 120, 240, 240, debugBorder: false);

  }).catchError((e) => print(e));
}

//-------------------------------------------------------------------------------------------------

class World extends Sprite {

  World() {

    var sun = new Bitmap(resourceManager.getBitmapData("sun"));
    sun.pivotX = 65;
    sun.pivotY = 62;
    sun.x = 320;
    sun.y = 200;
    sun.addTo(this);

    var house = new Bitmap(resourceManager.getBitmapData("house"));
    house.x = 250;
    house.y = 200;
    house.addTo(this);

    var tree = new Bitmap(resourceManager.getBitmapData("tree"));
    tree.x = 300;
    tree.y = 200;
    tree.addTo(this);

    stage.juggler.tween(sun, 60.0, (x) => x).animate.rotation.to(20 * math.PI);
  }
}
