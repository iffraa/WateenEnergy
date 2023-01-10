import 'dart:ui';

class AppColors{
  static const darkBlue =  Color(0xff2C4D82);
  static const lightBlue =  Color(0xff3899D5);
  static const greyText =  Color(0xff525252);//unselected menu item
  static const blueText =  Color(0xff2C4D82);// blue text color
  static const greyBg =  Color(0xffEBEBEB);
  static const redColor =  Color(0xffC20304);
  static const orangeColor =  Color(0xffF08200);
  static const geenOnlineColor =  Color(0xff005A3D);
  static const greyDropDownColor =  Color(0xffA7AEB4);

}


class HexColor extends Color {

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}