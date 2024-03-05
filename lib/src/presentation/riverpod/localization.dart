import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// @immutable
// class Localization {
//   final String? currentLanguage;
//   const Localization({this.currentLanguage});
// }

class LocalizationNotifier extends StateNotifier<String> {
  LocalizationNotifier(super.state);
  String getLanguage() {
    return state;
  }

  setLanguage(String language) {
    debugPrint(language);
    state = language;
  }
}

final localizationProvider =
    StateNotifierProvider((ref) => LocalizationNotifier("en"));
