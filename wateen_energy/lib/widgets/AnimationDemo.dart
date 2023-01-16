import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SiteAnimationPath.dart';

class AnimatedPathDemo extends StatefulWidget {
  @override
  _AnimatedPathDemoState createState() => _AnimatedPathDemoState();
}

class _AnimatedPathDemoState extends State<AnimatedPathDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        color: Colors.lightBlueAccent,
        height: 300,
        width: 300,
        child: Column(
          children: [
            new CustomPaint(
              painter: new AnimatedPathPainter(_controller),
            ),
            FloatingActionButton(
              onPressed: _startAnimation,
              child: new Icon(Icons.play_arrow),
            )
          ],
        ),
      )

    ;
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
