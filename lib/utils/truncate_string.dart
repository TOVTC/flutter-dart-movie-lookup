import 'package:flutter/material.dart';

String truncateString(double maxWidth, String text, TextStyle? style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    maxLines: 1
  );

  int start = 0;
  int end = text.length;

  while (start < end) {
    int middle = (start + end) ~/2;
    String substring = text.substring(0, middle + 1);

    textPainter.text = TextSpan(text: substring, style: style);
    textPainter.layout();

    double width = textPainter.width;

    if (width <= maxWidth) {
      start = middle + 1;
    } else {
      end = middle; 
    }
  }

  if (text.substring(0, start).length == text.length) {
    return text;
  } else {
    return '${text.substring(0, start - 2)}...';
  }
}
