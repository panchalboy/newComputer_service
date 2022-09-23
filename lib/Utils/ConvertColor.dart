class ConvertHexToColor {
  hexCode(String colorCode) {
    String newColorCode = '0xff' + colorCode;
    newColorCode = newColorCode.replaceAll("#", '');
    int colorInt = int.parse(newColorCode);
    return colorInt;
  }
}
