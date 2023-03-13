import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/chart_visibility_cn.dart';
import '../utils/colour.dart';

class ChartLabel extends StatefulWidget {
  final String text;
  final int index;

   ChartLabel(this.text,this.index );

  @override
  State<ChartLabel> createState() => _ChartLabelState();
}

class _ChartLabelState extends State<ChartLabel> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return InkWell(
      onTap: (){
        setState(() {
          isVisible = !isVisible;
        });
        Provider.of<ChartVisibilityCN>(context, listen: false).addLabel(widget.text, isVisible);

      },
      child: Row(
        children: [
          Container(
            height: 0.8.h,
            width: 4.h,
            decoration: BoxDecoration(//(foo==1)? something1():(foo==2)? something2(): something3();
                color: widget.index == 0 ? AppColors.lbl1Color : widget.index == 1 ? AppColors.yellow   : AppColors.lbl3Color,
                borderRadius: BorderRadius.all(Radius.circular(1.h))),
          ) ,
          SizedBox(
            width: 2.h,
          ),
          Text(
            widget.text,
            style:  isVisible ? TextStyle(fontSize: _scale.axisHeading  )  :
            TextStyle(fontSize: _scale.axisHeading,decoration:   TextDecoration.lineThrough ,decorationStyle: TextDecorationStyle.solid,
                decorationColor: Colors.black,
             ) ,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 4.h,
          ),

        ],
      ),
    );
  }
}
