part of 'theme.dart';

class CustomColorSet {
  final Color text;

  final Color bodyText;

  final Color subText;

  final Color primary;

  final Color white;

  final Color icon;

  final Color grey;

  final Color backgroundColor;

  final Color backgroundColorVariant;

  final Color secondary;

  final Color lightTextBody;

  final Color error;

  final Color transparent;

  final Color green;

  final Color black;

  final Color grey2;

  final Color stroke;

  final Color background;

  final Color buttonColor;

  final Color filledColor;

  final Color subtitle;

  final Color redLight;

  final Color textColor2;

  final Color red;

  CustomColorSet._({
    required this.text,
    required this.bodyText,
    required this.subText,
    required this.primary,
    required this.white,
    required this.icon,
    required this.grey,
    required this.backgroundColor,
    required this.backgroundColorVariant,
    required this.secondary,
    required this.lightTextBody,
    required this.error,
    required this.transparent,
    required this.green,
    required this.black,
    required this.grey2,
    required this.stroke,
    required this.background,
    required this.buttonColor,
    required this.filledColor,
    required this.subtitle,
    required this.redLight,
    required this.textColor2,
    required this.red,
  });

  factory CustomColorSet._create(CustomThemeMode mode) {
    final isLight = mode.isLight;

    final text = isLight ? Style.text : Style.white;

    final bodyText = isLight ? Style.bodyText : Style.white;

    final subText = isLight ? Style.subText : Style.lightTextBody;

    final grey2 = isLight ? Style.grey : Style.secondary;

    final backgroundColor = isLight ? Style.white : Style.backgroundColor;

    final backgroundColorVariant = isLight ? Style.white : Style.text;

    final lightTextBody = isLight ? Style.lightTextBody : Style.text;

    const background = Style.backgroundColor;

    const stroke = Style.stroke;

    const grey = Style.grey;

    const black = Style.black;

    const green = Style.green;

    const primary = Style.primary;

    const white = Style.white;

    const icon = Style.icon;

    const secondary = Style.secondary;

    const error = Style.error;

    const transparent = Style.transparent;

    const buttonColor = Style.buttonColor;

    const filledColor = Style.filledColor;

    const subtitle = Style.subtitle;

    const redLight = Style.redLight;

    const textColor2 = Style.textColor2;

    const red = Style.red;

    return CustomColorSet._(
      green: green,
      black: black,
      grey: grey,
      stroke: stroke,
      background: background,
      text: text,
      bodyText: bodyText,
      subText: subText,
      primary: primary,
      white: white,
      icon: icon,
      backgroundColor: backgroundColor,
      backgroundColorVariant: backgroundColorVariant,
      secondary: secondary,
      lightTextBody: lightTextBody,
      error: error,
      transparent: transparent,
      grey2: grey2,
      buttonColor: buttonColor,
      filledColor: filledColor,
      subtitle: subtitle,
      redLight: redLight,
      textColor2: textColor2,
      red: red,
    );
  }

  static CustomColorSet createOrUpdate(CustomThemeMode mode) {
    return CustomColorSet._create(mode);
  }
}
