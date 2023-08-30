import 'dart:ui';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  // whatever is passed to super is the intial value stored by "state"
  LocaleNotifier() : super(Locale(Platform.localeName.split('_')[0]));

  void setLocale() {
    if (state == const Locale('en')) {
      state = const Locale('es');
    } else {
      state = const Locale('en');
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});