import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigatorNotifier extends StateNotifier<int> {
  NavigatorNotifier(super._state);

  int getCategory() {
    return state;
  }

  updateCategory(int i) {
    state = i;
  }
}

final navigatorProvider = StateNotifierProvider<NavigatorNotifier, int>(
    (ref) => NavigatorNotifier(0));
