import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalizationNotifier extends StateNotifier<String> {
  LocalizationNotifier() : super("en");
  String getLanguage() {
    return state;
  }

  setLanguage(String language) {
    debugPrint(language);
    state = language;
  }
}

final localizationProvider =
    StateNotifierProvider<LocalizationNotifier, String>(
        (ref) => LocalizationNotifier());
