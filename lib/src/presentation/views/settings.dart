import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/back_icon_button_widget.dart';
import 'package:ks_mail/src/presentation/riverpod/localization.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});
  static String id = "settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool selected = ref.watch(localizationProvider) == 'en';
    return Scaffold(
      appBar: AppBar(leading: const BackIconButtonWidget()),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context)!.change_lang,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.read(localizationProvider.notifier).setLanguage("en");
            },
            child: ListTile(
              title: const Text("English"),
              trailing: selected ? selectedIcon : null,
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.read(localizationProvider.notifier).setLanguage("de");
            },
            child: ListTile(
              title: const Text("German"),
              trailing: !selected ? selectedIcon : null,
            ),
          )
        ],
      ),
    );
  }
}
