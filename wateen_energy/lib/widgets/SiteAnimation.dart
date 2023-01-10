import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math' as math;

class SiteAnimation extends StatefulWidget {
  @override
  State<SiteAnimation> createState() => _SiteAnimationState();
}

class _SiteAnimationState extends State<SiteAnimation>
    with SingleTickerProviderStateMixin {
  double _progress = 1.0;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    animation = Tween(begin: 0.46.h, end: 7.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.h,
      color: Colors.white,
      //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: LayoutBuilder(
        // Inner yellow container
        builder: (_, constraints) => Container(
          width: MediaQuery.of(context).size.width,
          height: 40.h,

          // width: constraints.widthConstraints().maxWidth,
          // height: constraints.heightConstraints().maxHeight,
          color: Colors.yellow,
          child: CustomPaint(painter: FaceOutlinePainter(controller)),
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
   final AnimationController progress;

  FaceOutlinePainter(this.progress);

  Path getRightLinePath(Size size) {
    var path = Path();
    path.moveTo(size.width * 0.05.h, 9.h);
    path.lineTo(size.width * 0.03.h, 19.5.h);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.indigo;

    Offset topCircleOffset =
        Offset(size.width * 0.055.h, size.height * 0.015.h);
    //top circle
    canvas.drawCircle(topCircleOffset, 4.h, paint);
    drawText(
        canvas, "0 KW", Offset(size.width * 0.052.h, size.height * 0.012.h));

    //top right
    canvas.drawCircle(
        Offset(size.width * 0.022.h, size.height * 0.055.h), 4.h, paint);
    drawText(
        canvas, "220 KW", Offset(size.width * 0.016.h, size.height * 0.055.h));
    drawTopToRightLine(canvas, paint, size);

    drawRightToCenterLine(canvas, paint, size);

    //draw centre circle
    canvas.drawCircle(
        Offset(size.width * 0.055.h, size.height * 0.055.h), 4.h, paint);
    drawText(
        canvas, "320 KW", Offset(size.width * 0.049.h, size.height * 0.055.h));

    //bottom circle
    canvas.drawCircle(
        Offset(size.width * 0.055.h, size.height * 0.096.h), 4.h, paint);
    drawText(
        canvas, "550 KW", Offset(size.width * 0.049.h, size.height * 0.096.h));
    drawBottomToCenterLine(canvas, paint, size);

    //top left circle
    canvas.drawCircle(
        Offset(size.width * 0.09.h, size.height * 0.055.h), 4.h, paint);
    drawText(
        canvas, "550 KW", Offset(size.width * 0.084.h, size.height * 0.055.h));
    drawLeftToCenterLine(canvas, paint, size);
  }

  void drawTopToRightLine(Canvas canvas, Paint paint, Size size) {
    final p1 = Offset(size.width * 0.046.h , 7.h); //8
    final p2 = Offset(size.width * 0.026.h , 17.h); //15

    //  canvas.drawLine(Offset(0.0, 0.0), Offset(size.width - size.width * _progress, size.height - size.height * _progress), _paint);

progress.drive(Tween(begin: size.width * 0.046.h, end: size.width * 0.026.h ));
progress.forward();

    canvas.drawLine(
      p1,
      p2,
      paint,
    );
    drawArrow(p1, p2, paint, canvas);

  }

  void drawLeftToCenterLine(Canvas canvas, Paint paint, Size size) {
    canvas.drawLine(
      Offset(size.width * 0.064.h, size.height * 0.056.h),
      Offset(size.width * 0.081.h, size.height * 0.056.h),
      paint,
    );
    drawArrow(Offset(size.width * 0.081.h, size.height * 0.056.h),
    Offset(size.width * 0.064.h, size.height * 0.056.h), paint, canvas);
  }


  void drawRightToCenterLine(Canvas canvas, Paint paint, Size size) {
    canvas.drawLine(
      Offset(size.width * 0.031.h, size.height * 0.056.h),
      Offset(size.width * 0.046.h, size.height * 0.056.h),
      paint,
    );
    drawArrow(Offset(size.width * 0.021.h, size.height * 0.054.h),
        Offset(size.width * 0.046.h, size.height * 0.0562.h), paint, canvas);
  }

  void drawBottomToCenterLine(Canvas canvas, Paint paint, Size size) {
    canvas.drawLine(
      Offset(size.width * 0.055.h, size.height * 0.086.h),
      Offset(size.width * 0.055.h, size.height * 0.065.h),
      paint,
    );
    drawArrow(Offset(size.width * 0.055.h, size.height * 0.064.h),
        Offset(size.width * 0.055.h, size.height * 0.084.h), paint, canvas);
  }

  void drawText(Canvas canvas, String data, Offset offset) {
    TextSpan span =
        new TextSpan(style: new TextStyle(color: Colors.blue[800]), text: data);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, offset);
  }

  //reverse postion of p1 and p2 for arrow direction
  void drawArrow(Offset p1, Offset p2, Paint paint, Canvas canvas) {
    final dX = p2.dx - p1.dx;
    final dY = p2.dy - p1.dy;
    final angle = math.atan2(dY, dX);
    final arrowSize = 15;
    final arrowAngle = 25 * math.pi / 180;
    final path = Path();

    path.moveTo(p2.dx - arrowSize * math.cos(angle - arrowAngle),
        p2.dy - arrowSize * math.sin(angle - arrowAngle));
    path.lineTo(p2.dx, p2.dy);
    path.lineTo(p2.dx - arrowSize * math.cos(angle + arrowAngle),
        p2.dy - arrowSize * math.sin(angle + arrowAngle));
    path.close();
    canvas.drawPath(path, paint);
  }

   @override
   bool shouldRepaint(FaceOutlinePainter oldDelegate) {
     return oldDelegate.progress != progress;
   }
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    //                                             <-- Insert your painting code here.
    /* final path = Path()
      ..moveTo(50, 50)
      ..lineTo(200, 200)
      ..quadraticBezierTo(200, 0, 150, 100);
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawPath(path, paint);*/

    var paint = Paint();
    paint.color = Colors.amber;
    paint.strokeWidth = 5;
    canvas.drawLine(
      Offset(0, size.height / 3),
      Offset(size.width, size.height / 3),
      paint,
    );

    paint.color = Colors.blue;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 4, paint);

    paint.color = Colors.green;

    var path = Path();
    path.moveTo(size.width / 3, size.height * 3 / 4);
    path.lineTo(size.width / 2, size.height * 5 / 6);
    path.lineTo(size.width * 3 / 4, size.height * 4 / 6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
