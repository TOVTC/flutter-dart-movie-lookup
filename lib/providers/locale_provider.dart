import 'dart:ui';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  // whatever is passed to super is the intial value stored by "state"
  LocaleNotifier() : super(Locale(Platform.localeName.split('_')[0], Platform.localeName.split('_')[1]));

  void setLocale() {
    if (state == const Locale('en', 'US')) {
      state = const Locale('es', 'ES');
    } else {
      state = const Locale('en', 'US');
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});