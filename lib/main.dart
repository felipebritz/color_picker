import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double size = 300;

  var color = Color.fromARGB(255, 255, 0, 0);
  var angle = 0;
  var pickerPositionX = 0.0;
  var pickerPositionY = 0.0;

  @override
  void initState() {
    _ajustPickerPosition(angle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          onPanStart: (details) {
            _update(details.localPosition);
          },
          onPanUpdate: (details) {
            _update(details.localPosition);
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(size * 0.01),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          Color.fromARGB(255, 255, 0, 0),
                          Color.fromARGB(255, 255, 255, 0),
                          Color.fromARGB(255, 0, 255, 0),
                          Color.fromARGB(255, 0, 255, 255),
                          Color.fromARGB(255, 0, 0, 255),
                          Color.fromARGB(255, 255, 0, 255),
                          Color.fromARGB(255, 255, 0, 0),
                        ],
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(size * 0.08),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size * 0.20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: pickerPositionX,
                top: pickerPositionY,
                child: Container(
                  width: size * 0.1,
                  height: size * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(
                      width: 2
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _angleInDegrees(double size, double posX, double posY) {
    final sideAdj = posX - size / 2;
    final sideOp = posY - size / 2;

    if (sideAdj == 0 && sideOp > 0) {
      return 90;
    } else if (sideAdj == 0 && sideOp < 0) {
      return 270;
    } else if (sideAdj == 0 && sideOp == 0) {
      return 0;
    }

    var angle = atan(sideOp / sideAdj) * 180 / pi;

    if (sideAdj < 0) {
      angle += 180;
    } else if (sideAdj > 0 && sideOp < 0) {
      angle += 360;
    }

    return angle.toInt();
  }

  Color _colorFromAngle(int angle) {
    var red = 0;
    var green = 0;
    var blue = 0;

    var ajust = 0;

    if (angle >= 300) {
      ajust = (angle - 300) * 255 ~/ 60;
      red = 255;
      blue = 255 - ajust;
    } else if (angle >= 240) {
      ajust = (angle - 240) * 255 ~/ 60;
      red = ajust;
      blue = 255;
    } else if (angle >= 180) {
      ajust = (angle - 180) * 255 ~/ 60;
      green = 255 - ajust;
      blue = 255;
    } else if (angle >= 120) {
      ajust = (angle - 120) * 255 ~/ 60;
      green = 255;
      blue = ajust;
    } else if (angle >= 60) {
      ajust = (angle - 60) * 255 ~/ 60;
      red = 255 - ajust;
      green = 255;
    } else {
      ajust = angle * 255 ~/ 60;
      red = 255;
      green = ajust;
    }

    return Color.fromARGB(255, red, green, blue);
  }

  void _ajustPickerPosition(int angle){
    final center = size/2 + size*0.01;
    final hipotenusa = size/2 - size*0.04;

    var posX = center + cos(angle * pi / 180)*hipotenusa;
    var posY = center + sin(angle * pi / 180)*hipotenusa;

    posX -= size * 0.05;
    posY -= size * 0.05;

    pickerPositionX = posX;
    pickerPositionY = posY;
    
  }

  void _update(Offset localPosition) {
    setState(() {
      angle = _angleInDegrees(size, localPosition.dx, localPosition.dy);
      color = _colorFromAngle(angle);
      _ajustPickerPosition(angle);
    });
  }
}
