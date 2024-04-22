import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const CText(
      this.data, {
        super.key,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaleFactor,
        this.maxLines,
        this.semanticsLabel,
        this.textWidthBasis,
        this.textHeightBehavior,
        this.selectionColor,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style?.copyWith(
        fontSize: (style!.fontSize ?? Theme.of(context).textTheme.bodyMedium!.fontSize!) / MediaQuery.of(context).textScaleFactor,
      ),

      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow ?? TextOverflow.ellipsis,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines ?? 999999,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}