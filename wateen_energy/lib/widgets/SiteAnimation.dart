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
    
    super.initState();
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
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.h,
        color: Colors.white,
        //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: FutureBuilder(
          future: loadImage("assets/images/battery.png"),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            return 
             AnimatedBuilder(
              // Inner yellow container
              animation: _animationController,
              builder: (_, constraints) => Container(
                width: MediaQuery.of(context).size.width,
                height: 45.h,
    
                // width: constraints.widthConstraints().maxWidth,
                // height: constraints.heightConstraints().maxHeight,
                // color: Colors.yellow,
                color: Colors.white,
                child: CustomPaint(
                    painter: FaceOutlinePainter(
                        _animationController.value, widget.animation, image)),
              ),
            );
          }
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  double progress;
  var animation;
   ui.Image? image1;
  FaceOutlinePainter(this.progress, this.animation, this.image1);

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
      ..strokeWidth = 1.5
      ..color = Colors.grey;

       final paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Color(0xff2C4D82);
       final circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Color(0xff2C4D82);
      final ceneterCirclePaint = Paint()
      ..style = PaintingStyle.fill
      // ..strokeWidth = 1.5
      ..color = Color(0xff2C4D82);
     

    Offset topCircleOffset =
        Offset(size.width * 0.06.h, size.height * 0.015.h);
    //top circle
    canvas.drawCircle(topCircleOffset, 4.h, circlePaint);
    drawText(
        canvas, "${animation["values"][0]}", Offset(size.width * 0.059.h, size.height * 0.012.h),Color(0xff2C4D82));
        drawText(
        canvas, "${animation["units"][0]}", Offset(size.width * 0.057.h, size.height * 0.018.h),Color(0xff2C4D82));
    final Rect destination = Rect.fromLTWH(
        size.width * 0.057.h, size.height * 0.005.h, 15.00, 15.00);
    final Rect source =
        Rect.fromLTWH(0, 0, image1!.width.toDouble()??0.00, image1!.height.toDouble());
    canvas.drawImageRect(image1!, source, destination, Paint());
    // canvas.drawImage(
    //     image, Offset(size.width * 0.052.h, size.height * 0.012.h), Paint());
    //top right
    canvas.drawCircle(
        Offset(size.width * 0.012.h, size.height * 0.063.h), 4.h, circlePaint);
    drawText(
        canvas, "${animation["values"][1]}", Offset(size.width * 0.009.h, size.height * 0.062.h),Color(0xff2C4D82));
        drawText(
        canvas, "${animation["units"][1]}", Offset(size.width * 0.009.h, size.height * 0.068.h),Color(0xff2C4D82));
    final Rect destination2 = Rect.fromLTWH(
        size.width * 0.009.h, size.height * 0.055.h, 15.00, 15.00);
    final Rect source2 =
        Rect.fromLTWH(0, 0, image1!.width.toDouble(), image1!.height.toDouble());
    canvas.drawImageRect(image1!, source2, destination2, Paint());
    drawTopToRightLine(canvas, paint, size,paint1);
    drawTopToLeftLine(canvas,paint,size,paint1);
    drawRightToCenterLine(canvas, paint, size,paint1);
    drawTopToCenterLine(canvas, paint, size,paint1);
    //draw centre circle
    canvas.drawCircle(
        Offset(size.width * 0.06.h,size.height * 0.063.h), 4.h, ceneterCirclePaint);
    drawText(
        canvas, "${animation["values"][2]}", Offset(size.width * 0.056.h, size.height * 0.062.h),Colors.white);
         drawText(
        canvas, "${animation["units"][2]}", Offset(size.width * 0.057.h, size.height * 0.068.h),Colors.white);
    final Rect destination3 = Rect.fromLTWH(
        size.width * 0.057.h, size.height * 0.055.h, 15.00, 15.00);
    final Rect source3 =
        Rect.fromLTWH(0, 0, image1!.width.toDouble(), image1!.height.toDouble());
    canvas.drawImageRect(image1!, source3, destination3, Paint());
    //bottom circle
    canvas.drawCircle(
        Offset(size.width * 0.06.h, size.height * 0.111.h), 4.h, circlePaint);

    drawText(
        canvas, "${animation["values"][3]}", Offset(size.width * 0.059.h, size.height * 0.108.h),Color(0xff2C4D82));
        drawText(
        canvas, "${animation["units"][3]}", Offset(size.width * 0.057.h, size.height * 0.113.h),Color(0xff2C4D82));
    final Rect destination4 = Rect.fromLTWH(
        size.width * 0.057.h, size.height * 0.102.h, 15.00, 15.00);
    final Rect source4 =
        Rect.fromLTWH(0, 0, image1!.width.toDouble(), image1!.height.toDouble());
    canvas.drawImageRect(image1!, source4, destination4, Paint());
    drawBottomToCenterLine(canvas, paint, size,paint1);

    //top left circle
    canvas.drawCircle(
        Offset(size.width * 0.11.h, size.height * 0.063.h), 4.h, circlePaint);
    drawText(
        canvas, "${animation["values"][4]}", Offset(size.width * 0.109.h, size.height * 0.060.h),Color(0xff2C4D82));
        drawText(
        canvas, "${animation["units"][4]}", Offset(size.width * 0.107.h, size.height * 0.066.h),Color(0xff2C4D82));
    final Rect destination5 = Rect.fromLTWH(
        size.width * 0.1077.h, size.height * 0.053.h, 15.00, 15.00);
    final Rect source5 =
        Rect.fromLTWH(0, 0, image1!.width.toDouble(), image1!.height.toDouble());
    canvas.drawImageRect(image1!, source5, destination5, Paint());
    drawLeftToCenterLine(canvas, paint, size,paint1);
    drawLeftToBottomLine(canvas, paint, size,paint1);
    drawRightToBottomLine(canvas, paint, size,paint1);
    
  }
  void drawLeftToBottomLine(Canvas canvas, Paint paint, Size size, Paint paint1){
final p1 = Offset(size.width * 0.108.h, size.height * 0.074.h); //8
    final p2 =Offset(size.width * 0.072.h, size.height * 0.112.h); //15
   if (animation["genVatVal"] == 1) { //15
    canvas.drawLine(
      p1,
      p2,
      paint1,
    );}else{
      canvas.drawLine(
      p1,
      p2,
      paint,
    );
    }
    if (animation["genVatVal"] == 1) {
      drawArrow(p1, p2, paint, canvas);
    }
}
  void drawRightToBottomLine(Canvas canvas, Paint paint, Size size, Paint paint1){
final p1 = Offset(size.width * 0.011.h, size.height * 0.074.h); //8
    final p2 =Offset(size.width * 0.048.h, size.height * 0.112.h); //15
     if (animation["genGridVal"] == 1) { //15
    canvas.drawLine(
      p1,
      p2,
      paint1,
    );}else{
      canvas.drawLine(
      p1,
      p2,
      paint,
    );
    }
    if (animation["genGridVal"] == 1) {
      drawArrow(p1, p2, paint, canvas);
    }
}
void drawTopToLeftLine(Canvas canvas, Paint paint, Size size, Paint paint1){
final p1 = Offset(size.width * 0.072.h, 6.0.h); //8
    final p2 =Offset(size.width * 0.107.h, size.height * 0.052.h);
     if (animation["SolarBatteryVal"] == 1) { //15
    canvas.drawLine(
      p1,
      p2,
      paint1,
    );}else{
      canvas.drawLine(
      p1,
      p2,
      paint,
    );
    }
    if (animation["SolarBatteryVal"] == 1) {
      drawArrow(p1, p2, paint, canvas);
    }
}
  void drawTopToRightLine(Canvas canvas, Paint paint, Size size, Paint paint1) {
    final p1 = Offset(size.width * 0.048.h, 6.0.h); //8
    final p2 = Offset(size.width * 0.014.h, size.height * 0.052.h); //15

    //  canvas.drawLine(Offset(0.0, 0.0), Offset(size.width - size.width * _progress, size.height - size.height * _progress), _paint);

    // progress
    //     .drive(Tween(begin: size.width * 0.046.h, end: size.width * 0.026.h));
    // progress.forward();
 if (animation["solarGridVal"] == 1) {
    canvas.drawLine(
      p1,
      p2,
      paint1,
    );}else{
      canvas.drawLine(
      p1,
      p2,
      paint,
    );
    }
    if (animation["solarGridVal"] == 1) {
      drawArrow(p1, p2, paint1, canvas);
    }

    // final dX = p2.dx - p1.dx;
    // final dY = p2.dy - p1.dy;
    // final angle = math.atan2(dY, dX);
    // final arrowSize = 15;
    // final arrowAngle = 25 * math.pi / 180;
    // final arrowHead = Path();
    // arrowHead.moveTo(
    //     p2.dx - (progress * (arrowSize * math.cos(angle - arrowAngle))),
    //     p2.dy - arrowSize * math.sin(angle - arrowAngle));
    // arrowHead.lineTo(p2.dx, p2.dy);
    // arrowHead.lineTo(
    //     p2.dx - (progress * (arrowSize * math.cos(angle + arrowAngle))),
    //     p2.dy - arrowSize * math.sin(angle + arrowAngle));
    // arrowHead.close();
    // canvas.drawPath(arrowHead, paint);
  }

  void drawLeftToCenterLine(Canvas canvas, Paint paint, Size size, Paint paint1) {
    if (animation["batteryVal"] == 1) {
    canvas.drawLine(
      Offset(size.width * 0.072.h, size.height * 0.065.h),
      Offset(size.width * 0.098.h, size.height * 0.065.h),
      paint1,
    );}else{
       canvas.drawLine(
      Offset(size.width * 0.072.h, size.height * 0.065.h),
      Offset(size.width * 0.098.h, size.height * 0.065.h),
      paint,
    );
    }
    if (animation["batteryVal"] == 1) {
      drawArrow( Offset(size.width * 0.072.h, size.height * 0.065.h),
      Offset(size.width * 0.098.h, size.height * 0.065.h), paint1, canvas);
    }
  }
drawTopToCenterLine(Canvas canvas, Paint paint, Size size, Paint paint1) {
    if (animation["solarVal"] == 1) {
    canvas.drawLine(
    Offset(size.width * 0.060.h, 9.3.h),
      Offset(size.width * 0.060.h, 19.5.h),
      paint1,
    );}else{
      canvas.drawLine(
     Offset(size.width * 0.060.h, 9.3.h),
      Offset(size.width * 0.060.h, 19.5.h),
      paint,
    );
    }
    if (animation["solarVal"] == 1) {
      drawArrow( Offset(size.width * 0.060.h, 9.3.h),
      Offset(size.width * 0.060.h, 19.5.h), paint1, canvas);
    }
  }

  void drawRightToCenterLine(Canvas canvas, Paint paint, Size size, Paint paint1) {
    if (animation["gridVal"] == 1) {
    canvas.drawLine(
      Offset(size.width * 0.024.h, size.height * 0.065.h),
      Offset(size.width * 0.048.h, size.height * 0.065.h),
      paint1,
    );}else{
      canvas.drawLine(
      Offset(size.width * 0.024.h, size.height * 0.065.h),
      Offset(size.width * 0.048.h, size.height * 0.065.h),
      paint,
    ); 
    }
    if (animation["gridVal"] == 1) {
      drawArrow( Offset(size.width * 0.024.h, size.height * 0.065.h),
      Offset(size.width * 0.048.h, size.height * 0.065.h), paint1, canvas);
    }
  }

  void drawBottomToCenterLine(Canvas canvas, Paint paint, Size size, Paint paint1) {
   if (animation["generatorVal"] == 1) {
    canvas.drawLine(
      Offset(size.width * 0.060.h, size.height * 0.1.h),
      Offset(size.width * 0.060.h, size.height * 0.074.h),
      paint1,
    );}else{
       canvas.drawLine(
      Offset(size.width * 0.060.h, size.height * 0.1.h),
      Offset(size.width * 0.060.h, size.height * 0.074.h),
      paint,
    );
    }
    if (animation["generatorVal"] == 1) {
      drawArrow(Offset(size.width * 0.060.h, size.height * 0.1.h),
      Offset(size.width * 0.060.h, size.height * 0.074.h), paint1, canvas);
    }
  }

  void drawText(Canvas canvas, String data, Offset offset, Color color) {
    TextSpan span =
        new TextSpan(style: new TextStyle(color: color,fontSize: 12), text: data);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, offset);
  }

  //reverse postion of p1 and p2 for arrow direction
  void drawArrow(Offset p1, Offset p2, Paint paint, Canvas canvas) {
    final p3 = Offset(
        progress * (p2.dx - p1.dx) + p1.dx, progress * (p2.dy - p1.dy) + p1.dy);
    final dX = p3.dx - p1.dx;
    final dY = p3.dy - p1.dy;
    final angle = math.atan2(dY, dX);
    final arrowSize = 10;
    final arrowAngle = 40 * math.pi / 180;
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

