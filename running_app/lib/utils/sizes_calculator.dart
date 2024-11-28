import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as rendering;

double getTextHeight(String text, TextStyle? style, BuildContext context, double horizontalPadding, int? maxLines) {
  final renderParagraph = rendering.RenderParagraph(
      maxLines: maxLines,
      TextSpan(
        style: style,
        text: text,
      ),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(context).textScaler);

  final width = MediaQuery.of(context).size.width - horizontalPadding;
  final height = renderParagraph.getMaxIntrinsicHeight(width);
  return height;
}

double getTextWidth(BuildContext context, String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    textScaler: MediaQuery.textScalerOf(context),
  );

  textPainter.layout();
  return textPainter.width;
}
