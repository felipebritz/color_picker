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
      theme: ThemeData.dark(),
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

  var color = colorList[0];
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
                        colors: colorList,
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(size * 0.08),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
                    border: Border.all(width: 2),
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
    final index = (angle * colorList.length / 360).truncate();
    return colorList[index];
  }

  void _ajustPickerPosition(int angle) {
    final center = size / 2 + size * 0.01;
    final hipotenusa = size / 2 - size * 0.04;

    var posX = center + cos(angle * pi / 180) * hipotenusa;
    var posY = center + sin(angle * pi / 180) * hipotenusa;

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

  static const colorList = [
    Color.fromARGB(255, 255, 180, 107),
    Color.fromARGB(255, 255, 184, 114),
    Color.fromARGB(255, 255, 187, 120),
    Color.fromARGB(255, 255, 190, 126),
    Color.fromARGB(255, 255, 193, 132),
    Color.fromARGB(255, 255, 196, 137),
    Color.fromARGB(255, 255, 199, 143),
    Color.fromARGB(255, 255, 201, 148),
    Color.fromARGB(255, 255, 204, 153),
    Color.fromARGB(255, 255, 206, 159),
    Color.fromARGB(255, 255, 209, 163),
    Color.fromARGB(255, 255, 211, 168),
    Color.fromARGB(255, 255, 213, 173),
    Color.fromARGB(255, 255, 215, 177),
    Color.fromARGB(255, 255, 217, 182),
    Color.fromARGB(255, 255, 219, 186),
    Color.fromARGB(255, 255, 221, 190),
    Color.fromARGB(255, 255, 223, 194),
    Color.fromARGB(255, 255, 225, 198),
    Color.fromARGB(255, 255, 227, 202),
    Color.fromARGB(255, 255, 228, 206),
    Color.fromARGB(255, 255, 230, 210),
    Color.fromARGB(255, 255, 232, 213),
    Color.fromARGB(255, 255, 233, 217),
    Color.fromARGB(255, 255, 235, 220),
    Color.fromARGB(255, 255, 236, 224),
    Color.fromARGB(255, 255, 238, 227),
    Color.fromARGB(255, 255, 239, 230),
    Color.fromARGB(255, 255, 240, 233),
    Color.fromARGB(255, 255, 242, 236),
    Color.fromARGB(255, 255, 243, 239),
    Color.fromARGB(255, 255, 244, 242),
    Color.fromARGB(255, 255, 245, 245),
    Color.fromARGB(255, 255, 246, 247),
    Color.fromARGB(255, 255, 248, 251),
    Color.fromARGB(255, 255, 249, 253),
    Color.fromARGB(255, 254, 249, 255),
    Color.fromARGB(255, 252, 247, 255),
    Color.fromARGB(255, 249, 246, 255),
    Color.fromARGB(255, 247, 245, 255),
    Color.fromARGB(255, 245, 243, 255),
    Color.fromARGB(255, 243, 242, 255),
    Color.fromARGB(255, 240, 241, 255),
    Color.fromARGB(255, 239, 240, 255),
    Color.fromARGB(255, 237, 239, 255),
    Color.fromARGB(255, 235, 238, 255),
    Color.fromARGB(255, 233, 237, 255),
    Color.fromARGB(255, 231, 236, 255),
    Color.fromARGB(255, 230, 235, 255),
    Color.fromARGB(255, 228, 234, 255),
    Color.fromARGB(255, 227, 233, 255),
    Color.fromARGB(255, 225, 232, 255),
    Color.fromARGB(255, 224, 231, 255),
    Color.fromARGB(255, 222, 230, 255),
    Color.fromARGB(255, 221, 230, 255),
    Color.fromARGB(255, 220, 229, 255),
    Color.fromARGB(255, 218, 229, 255),
    Color.fromARGB(255, 217, 227, 255),
    Color.fromARGB(255, 216, 227, 255),
    Color.fromARGB(255, 215, 226, 255),
    Color.fromARGB(255, 215, 226, 255),
    Color.fromARGB(255, 216, 227, 255),
    Color.fromARGB(255, 217, 227, 255),
    Color.fromARGB(255, 218, 229, 255),
    Color.fromARGB(255, 220, 229, 255),
    Color.fromARGB(255, 221, 230, 255),
    Color.fromARGB(255, 222, 230, 255),
    Color.fromARGB(255, 224, 231, 255),
    Color.fromARGB(255, 225, 232, 255),
    Color.fromARGB(255, 227, 233, 255),
    Color.fromARGB(255, 228, 234, 255),
    Color.fromARGB(255, 230, 235, 255),
    Color.fromARGB(255, 231, 236, 255),
    Color.fromARGB(255, 233, 237, 255),
    Color.fromARGB(255, 235, 238, 255),
    Color.fromARGB(255, 237, 239, 255),
    Color.fromARGB(255, 239, 240, 255),
    Color.fromARGB(255, 240, 241, 255),
    Color.fromARGB(255, 243, 242, 255),
    Color.fromARGB(255, 245, 243, 255),
    Color.fromARGB(255, 247, 245, 255),
    Color.fromARGB(255, 249, 246, 255),
    Color.fromARGB(255, 252, 247, 255),
    Color.fromARGB(255, 254, 249, 255),
    Color.fromARGB(255, 255, 249, 253),
    Color.fromARGB(255, 255, 248, 251),
    Color.fromARGB(255, 255, 246, 247),
    Color.fromARGB(255, 255, 245, 245),
    Color.fromARGB(255, 255, 244, 242),
    Color.fromARGB(255, 255, 243, 239),
    Color.fromARGB(255, 255, 242, 236),
    Color.fromARGB(255, 255, 240, 233),
    Color.fromARGB(255, 255, 239, 230),
    Color.fromARGB(255, 255, 238, 227),
    Color.fromARGB(255, 255, 236, 224),
    Color.fromARGB(255, 255, 235, 220),
    Color.fromARGB(255, 255, 233, 217),
    Color.fromARGB(255, 255, 232, 213),
    Color.fromARGB(255, 255, 230, 210),
    Color.fromARGB(255, 255, 228, 206),
    Color.fromARGB(255, 255, 227, 202),
    Color.fromARGB(255, 255, 225, 198),
    Color.fromARGB(255, 255, 223, 194),
    Color.fromARGB(255, 255, 221, 190),
    Color.fromARGB(255, 255, 219, 186),
    Color.fromARGB(255, 255, 217, 182),
    Color.fromARGB(255, 255, 215, 177),
    Color.fromARGB(255, 255, 213, 173),
    Color.fromARGB(255, 255, 211, 168),
    Color.fromARGB(255, 255, 209, 163),
    Color.fromARGB(255, 255, 206, 159),
    Color.fromARGB(255, 255, 204, 153),
    Color.fromARGB(255, 255, 201, 148),
    Color.fromARGB(255, 255, 199, 143),
    Color.fromARGB(255, 255, 196, 137),
    Color.fromARGB(255, 255, 193, 132),
    Color.fromARGB(255, 255, 190, 126),
    Color.fromARGB(255, 255, 187, 120),
    Color.fromARGB(255, 255, 184, 114),
    Color.fromARGB(255, 255, 180, 107),
  ];
}
