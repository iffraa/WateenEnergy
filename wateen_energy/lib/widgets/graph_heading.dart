import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class GraphHeading extends StatelessWidget {
  final String text;

  const GraphHeading(this.text);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Text(text,style:TextStyle(fontWeight: FontWeight.w700,fontSize: _scale.chartHeading),textAlign: TextAlign.start,);
    ;
  }
}
