import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = Provider((ref) {
  return const Locale('es', 'ES');
});