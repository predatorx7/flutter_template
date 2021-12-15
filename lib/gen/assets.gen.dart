/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $GoogleFontsGen {
  const $GoogleFontsGen();

  /// File path: google_fonts/NunitoSans-Black.ttf
  String get nunitoSansBlack => 'google_fonts/NunitoSans-Black.ttf';

  /// File path: google_fonts/NunitoSans-BlackItalic.ttf
  String get nunitoSansBlackItalic => 'google_fonts/NunitoSans-BlackItalic.ttf';

  /// File path: google_fonts/NunitoSans-Bold.ttf
  String get nunitoSansBold => 'google_fonts/NunitoSans-Bold.ttf';

  /// File path: google_fonts/NunitoSans-BoldItalic.ttf
  String get nunitoSansBoldItalic => 'google_fonts/NunitoSans-BoldItalic.ttf';

  /// File path: google_fonts/NunitoSans-ExtraBold.ttf
  String get nunitoSansExtraBold => 'google_fonts/NunitoSans-ExtraBold.ttf';

  /// File path: google_fonts/NunitoSans-ExtraBoldItalic.ttf
  String get nunitoSansExtraBoldItalic =>
      'google_fonts/NunitoSans-ExtraBoldItalic.ttf';

  /// File path: google_fonts/NunitoSans-ExtraLight.ttf
  String get nunitoSansExtraLight => 'google_fonts/NunitoSans-ExtraLight.ttf';

  /// File path: google_fonts/NunitoSans-ExtraLightItalic.ttf
  String get nunitoSansExtraLightItalic =>
      'google_fonts/NunitoSans-ExtraLightItalic.ttf';

  /// File path: google_fonts/NunitoSans-Italic.ttf
  String get nunitoSansItalic => 'google_fonts/NunitoSans-Italic.ttf';

  /// File path: google_fonts/NunitoSans-Light.ttf
  String get nunitoSansLight => 'google_fonts/NunitoSans-Light.ttf';

  /// File path: google_fonts/NunitoSans-LightItalic.ttf
  String get nunitoSansLightItalic => 'google_fonts/NunitoSans-LightItalic.ttf';

  /// File path: google_fonts/NunitoSans-Regular.ttf
  String get nunitoSansRegular => 'google_fonts/NunitoSans-Regular.ttf';

  /// File path: google_fonts/NunitoSans-SemiBold.ttf
  String get nunitoSansSemiBold => 'google_fonts/NunitoSans-SemiBold.ttf';

  /// File path: google_fonts/NunitoSans-SemiBoldItalic.ttf
  String get nunitoSansSemiBoldItalic =>
      'google_fonts/NunitoSans-SemiBoldItalic.ttf';

  /// File path: google_fonts/OFL.txt
  String get ofl => 'google_fonts/OFL.txt';
}

class $AssetsAnimGen {
  const $AssetsAnimGen();

  /// File path: assets/anim/eye.gif
  AssetGenImage get eye => const AssetGenImage('assets/anim/eye.gif');
}

class Assets {
  Assets._();

  static const $AssetsAnimGen anim = $AssetsAnimGen();
  static const $GoogleFontsGen googleFonts = $GoogleFontsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
