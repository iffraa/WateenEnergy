import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math' as math;

class SiteAnimation extends StatefulWidget {
  SiteAnimation({Key? key, required this.animation});
  final animation;
  @override
  State<SiteAnimation> createState() => _SiteAnimationState();
}

class _SiteAnimationState extends State<SiteAnimation>
    with SingleTickerProviderStateMixin {
  double _progress = 1.0;
  late Animation<double> animation;
  late AnimationController _animationController;
  Path? _path;

  Map<String, ui.Image?> assetUiImages = {};

  ui.Image? image;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    // controller =
    //     AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    // animation = Tween(begin: 0.46.h, end: 7.0).animate(controller)
    //   ..addListener(() {
    //     setState(() {
    //       _progress = animation.value;
    //     });
    //   });

    // controller.forward();
    // _path = drawPath();
    // print(widget.animation);

    loadingImages();

    super.initState();
  }

  Future<void> loadingImages() async {
    try {
      final assetImages = {
        'house': "assets/images/house_an.png",
        'electric_pole': "assets/images/electric_pole_an.png",
        'generator': "assets/images/generator_an.png",
        'system': "assets/images/system_an.png",
        'battery': "assets/images/battery_an.png",
      };


      final result = <String, ui.Image?>{};

      final data = assetImages.entries.toList();

      for (var i = 0; i < data.length; i++) {
        final img = await loadImage(data[i].value);

        result[data[i].key] = img;
      }

      assetUiImages = result;
      setState(() {});
    } catch (e) {
      debugPrint("$e");
    }
  }

  loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo frame = await codec.getNextFrame();
    setState(() {
      image = frame.image;
    });
    return image;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Path drawPath() {
    Size size = Size(300, 300);
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.zero,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width - 10.h ,
          //color: Colors.white,
          child: CustomPaint(
              painter: FaceOutlinePainter(
            _animationController.value,
            widget.animation,
            assetUiImages,
            MediaQuery.of(context).size.width * 0.3,
          )),
        );
      },
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  static const circleRadius = 30.0;

  final Offset center = const Offset(0, 0);

  final double distanceFromCenterToSiteCircle;

  double progress;

  dynamic animation;

  final Map<String, ui.Image?> images;

  FaceOutlinePainter(
    this.progress,
    this.animation,
    this.images,
    this.distanceFromCenterToSiteCircle,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final centerCirclePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.5
      ..color = const Color(0xff2C4D82);

    final sideCirclePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xff2C4D82);

    // Draw top-center circle
    canvas.drawCircle(
      center + Offset(-distanceFromCenterToSiteCircle, 0),
      circleRadius,
      sideCirclePaint,
    );

    // Draw bottom-center circle
    canvas.drawCircle(
      center + Offset(distanceFromCenterToSiteCircle, 0),
      circleRadius,
      sideCirclePaint,
    );

    // Draw left-center circle
    canvas.drawCircle(
      center + Offset(0, -distanceFromCenterToSiteCircle),
      circleRadius,
      sideCirclePaint,
    );

    // Draw right-center circle
    canvas.drawCircle(
      center + Offset(0, distanceFromCenterToSiteCircle),
      circleRadius,
      sideCirclePaint,
    );

// ---------------------DRAWING TEXT-----------------------

    // Draw top circle text
    drawCircleTextAndIcon(
      canvas: canvas,
      image: images['system'],
      valueText: "${animation["values"][0]}",
      unitText: "${animation["units"][0]}",
      offset: center + Offset(0, -distanceFromCenterToSiteCircle),
      color: const Color(0xff2C4D82),
    );
    // Draw left circle text
    drawCircleTextAndIcon(
      canvas: canvas,
      image: images['electric_pole'],
      valueText: "${animation["values"][1]}",
      unitText: "${animation["units"][1]}",
      offset: center + Offset(0 - distanceFromCenterToSiteCircle, 0),
      color: const Color(0xff2C4D82),
    );
    // Draw bottom circle text
    drawCircleTextAndIcon(
      canvas: canvas,
      image: images['generator'],
      valueText: "${animation["values"][3]}",
      unitText: "${animation["units"][3]}",
      offset: center + Offset(0, distanceFromCenterToSiteCircle),
      color: const Color(0xff2C4D82),
    );
    // Draw right circle text
    drawCircleTextAndIcon(
      canvas: canvas,
      image: images['battery'],
      valueText: "${animation["values"][4]}",
      unitText: "${animation["units"][4]}",
      offset: center + Offset(distanceFromCenterToSiteCircle, 0),
      color: const Color(0xff2C4D82),
    );

// ---------------------DRAWING CONNECTION LINES-----------------------
    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.grey;

    final paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = const Color(0xff2C4D82);

    drawTopToRightLine(canvas, paint, paint1);
    drawTopToLeftLine(canvas, paint, paint1);
    drawRightToCenterLine(canvas, paint, paint1);
    drawTopToCenterLine(canvas, paint, paint1);

    drawBottomToCenterLine(canvas, paint, paint1);

    drawLeftToCenterLine(canvas, paint, paint1);
    drawLeftToBottomLine(canvas, paint, paint1);
    drawRightToBottomLine(canvas, paint, paint1);

// -------------------- CENTER canvas ------------------
    // Draw center circle
    canvas.drawCircle(center, circleRadius, centerCirclePaint);
    // Draw center circle text
    drawCircleTextAndIcon(
      canvas: canvas,
      image: images['house'],
      valueText: "${animation["values"][2]}",
      unitText: "${animation["units"][2]}",
      offset: center,
    );
  }

  void drawCircleTextAndIcon({
    required Canvas canvas,
    ui.Image? image,
    String valueText = "",
    String unitText = "",
    required Offset offset,
    Color color = Colors.white,
  }) {
    offset = offset + const Offset(-10, -5);

    if (image != null) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = const Color(0xff2C4D82)
        ..strokeWidth = 3;
      canvas.drawImage(image, offset + const Offset(0, -20), paint);
    }

    // Round value to 2 decimal places
    final numMiddleText = num.tryParse(valueText);
    if (numMiddleText != null && numMiddleText is double) {
      valueText = numMiddleText.toStringAsFixed(2);
    }

    final middleSpan = TextSpan(
      style: TextStyle(color: color, fontSize: 10),
      text: valueText,
    );

    final tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.text = middleSpan;
    tp.layout(minWidth: 70, maxWidth: 70);
    tp.paint(canvas, offset + const Offset(-25, 7));

    final bottomSpan = TextSpan(
      style: TextStyle(color: color, fontSize: 10),
      text: unitText,
    );

    tp.text = bottomSpan;
    tp.layout(minWidth: 70, maxWidth: 70);
    tp.paint(canvas, offset + const Offset(-25, 20));
  }

  void drawLeftToBottomLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx - distanceFromCenterToSiteCircle,
      center.dy + circleRadius,
    );

    final p2 = Offset(
      center.dx - circleRadius,
      center.dy + distanceFromCenterToSiteCircle,
    );

    if (animation["genVatVal"] == 1) {
      //15
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["genVatVal"] == 1) {
      drawArrow(p1, p2, paint, canvas);
    }
  }

  void drawRightToBottomLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx + distanceFromCenterToSiteCircle,
      center.dy + circleRadius,
    );

    final p2 = Offset(
      center.dx + circleRadius,
      center.dy + distanceFromCenterToSiteCircle,
    );

    if (animation["genGridVal"] == 1) {
      //15
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["genGridVal"] == 1) {
      drawArrow(p1, p2, paint, canvas);
    }
  }

  void drawTopToLeftLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx - circleRadius,
      center.dy - distanceFromCenterToSiteCircle,
    );

    final p2 = Offset(
      center.dx - distanceFromCenterToSiteCircle,
      center.dy - circleRadius,
    );

    if (animation["SolarBatteryVal"] == 1) {
      //15
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["SolarBatteryVal"] == 1) {
      drawArrow(p1, p2, paint, canvas);
    }
  }

  void drawTopToRightLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx + circleRadius,
      center.dy - distanceFromCenterToSiteCircle,
    );

    final p2 = Offset(
      center.dx + distanceFromCenterToSiteCircle,
      center.dy - circleRadius,
    );

    if (animation["solarGridVal"] == 1) {
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["solarGridVal"] == 1) {
      drawArrow(p1, p2, paint1, canvas);
    }
  }

  void drawLeftToCenterLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx - distanceFromCenterToSiteCircle + circleRadius,
      center.dy,
    );

    final p2 = Offset(center.dx, center.dy);

    if (animation["gridVal"] == 1) {
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["gridVal"] == 1) {
      drawArrow(p1 + const Offset(10, 0), p2, paint1, canvas);
    }
  }

  void drawTopToCenterLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx,
      center.dy - distanceFromCenterToSiteCircle + circleRadius,
    );

    final p2 = Offset(center.dx, center.dy);

    if (animation["solarVal"] == 1) {
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["solarVal"] == 1) {
      drawArrow(p1 + const Offset(0, 10), p2, paint1, canvas);
    }
  }

  void drawRightToCenterLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx + distanceFromCenterToSiteCircle - circleRadius,
      center.dy,
    );

    final p2 = Offset(center.dx, center.dy);

    if (animation["batteryVal"] == 1) {
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["batteryVal"] == 1) {
      drawArrow(p1 + const Offset(-10, 0), p2, paint1, canvas);
    }
  }

  void drawBottomToCenterLine(Canvas canvas, Paint paint, Paint paint1) {
    final p1 = Offset(
      center.dx,
      center.dy + distanceFromCenterToSiteCircle - circleRadius,
    );

    final p2 = Offset(center.dx, center.dy);

    if (animation["generatorVal"] == 1) {
      canvas.drawLine(p1, p2, paint1);
    } else {
      canvas.drawLine(p1, p2, paint);
    }
    if (animation["generatorVal"] == 1) {
      drawArrow(p1 + const Offset(0, -10), p2, paint1, canvas);
    }
  }

  //reverse postion of p1 and p2 for arrow direction
  void drawArrow(Offset p1, Offset p2, Paint paint, Canvas canvas) {
    final p3 = Offset(
        progress * (p2.dx - p1.dx) + p1.dx, progress * (p2.dy - p1.dy) + p1.dy);
    final dX = p3.dx - p1.dx;
    final dY = p3.dy - p1.dy;
    final angle = math.atan2(dY, dX);
    const arrowSize = 10;
    const arrowAngle = 40 * math.pi / 180;
    final path = Path();
    // path.moveTo(25, 30);

    // print("p1--- $p1");
    // final path = Path()
    // ..moveTo(p3.dx, p3.dy)
    // ..lineTo(p3.dx - arrowSize * math.cos(angle - arrowAngle),
    //     p3.dy + arrowSize * math.sin(angle - arrowAngle))
    // ..lineTo(p3.dx - arrowSize * math.cos(angle - arrowAngle),
    //     p3.dy - arrowSize * math.sin(angle - arrowAngle));

    path.moveTo(
        p1.dx +
            (p2.dx - p1.dx) * progress -
            arrowSize * math.cos(angle - arrowAngle),
        p1.dy +
            (p2.dy - p1.dy) * progress -
            arrowSize * math.sin(angle - arrowAngle));
    path.lineTo(
        p1.dx + (p2.dx - p1.dx) * progress, p1.dy + (p2.dy - p1.dy) * progress);
    path.lineTo(
        p1.dx +
            (p2.dx - p1.dx) * progress -
            arrowSize * math.cos(angle + arrowAngle),
        p1.dy +
            (p2.dy - p1.dy) * progress -
            arrowSize * math.sin(angle + arrowAngle));
    // path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
