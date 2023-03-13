import 'dart:ui';

class AppColors{
  static const darkBlue =  Color(0xff0C3C84);
  static const yellow =  Color(0xffEB9E29);
  static const lightBlue =  Color(0xff3899D5);
  static const greyText =  Color(0xff525252);//unselected menu item
  static const blueText =  Color(0xff2C4D82);// blue text color
  static const greyBg =  Color(0xffEBEBEB);
  static const redColor =  Color(0xffC20304);
  static const orangeColor =  Color(0xffF08200);
  static const geenOnlineColor =  Color(0xff005A3D);
  static const greyDropDownColor =  Color(0xffA7AEB4);
  static const inputFieldColor =  Color(0xff8CB9DD);
  static const greyContainerColor =  Color(0xffE5E7E9);
  static const lbl1Color =  Color(0xff0c3c84);
  static const lbl2Color =  Color(0xff2780bc);
  static const lbl3Color =  Color(0xffd8eb29);
  static const lightBlueShade =  Color(0xff3282BA);

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