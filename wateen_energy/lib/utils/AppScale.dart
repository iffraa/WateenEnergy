import 'package:flutter/cupertino.dart';

class AppScale {
  BuildContext _ctxt;

  AppScale(this._ctxt);

  double get appBarHeading => scaledWidth(0.05);
  double get heading => scaledWidth(0.045);
  double get subHeading => scaledWidth(0.04);
  double get chartHeading => scaledWidth(0.036);
  double get formButton => scaledHeight(0.027);
  double get navButton => scaledHeight(0.02);
  double get axisHeading => scaledHeight(0.015);
  double get siteConQTxt => scaledHeight(0.013);
  double get smallestTxt => scaledHeight(0.009);
  double get sTxt => scaledHeight(0.018);
  double get ssTxt => scaledHeight(0.016);
  double get sssTxt => scaledHeight(0.017);

  double get normalTxt => scaledHeight(0.019);
  double get listTxt => scaledHeight(0.024);

  double scaledWidth(double widthScale) {
    return MediaQuery.of(_ctxt).size.width * widthScale;
  }

  double scaledHeight(double heightScale) {
    return MediaQuery.of(_ctxt).size.height * heightScale;
  }
}
