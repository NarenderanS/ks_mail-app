import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/back_icon_button_widget.dart';
import 'package:ks_mail/src/presentation/state_management/localization.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});
  static String id = "settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(leading: const BackIconButtonWidget()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Change Language'),
          GestureDetector(
            onTap: () {
              print("a");
              ref.read(localizationProvider.notifier).setLanguage("en");
            },
            child: const Text("English"),
          ),
          GestureDetector(
            onTap: () {
              ref.read(localizationProvider.notifier).setLanguage("de");
            },
            child: const Text("German"),
          )
        ],
      ),
    );
  }
}
