import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/views/home.dart';
import 'package:ks_mail/src/presentation/views/settings.dart';
import 'package:ks_mail/src/presentation/widgets/drawer_widgets/drawer_body_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/presentation/riverpod/navigator.dart';

import '../../../utils/constants/commom_functions.dart';
import '../../../utils/constants/variables.dart';
import '../../views/apps.dart';
import '../../views/login.dart';

// ignore: must_be_immutable
class DrawerWidget extends ConsumerWidget {
  DrawerWidget({super.key});
  late int selected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    selected = ref.watch(navigatorProvider);
    return Drawer(
      // backgroundColor: Colors.black87,
      // backgroundColor: const Color.fromARGB(255, 224, 236, 247),
      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          //App name and User mail in Drawer header
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.app_name,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    )),
                Text(currentUser!.mail)
              ],
            ),
          ),
          //Inbox
          DrawerBodyContent(
              text: AppLocalizations.of(context)!.inbox,
              icon: Icons.inbox_outlined,
              onTap: () {
                _drawerClick(context, ref, 0);
              },
              isSelected: selected == 0),
          //Starred
          DrawerBodyContent(
              text: AppLocalizations.of(context)!.starred,
              icon: Icons.star_border_outlined,
              onTap: () {
                _drawerClick(context, ref, 1);
              },
              isSelected: selected == 1),
          //Sent
          DrawerBodyContent(
              text: AppLocalizations.of(context)!.sent,
              icon: Icons.send_outlined,
              onTap: () {
                _drawerClick(context, ref, 2);
              },
              isSelected: selected == 2),
          //Draft
          DrawerBodyContent(
              text: AppLocalizations.of(context)!.draft,
              icon: Icons.insert_drive_file_outlined,
              onTap: () {
                _drawerClick(context, ref, 3);
              },
              isSelected: selected == 3),
          //Bin
          DrawerBodyContent(
              text: AppLocalizations.of(context)!.bin,
              icon: Icons.delete_outlined,
              onTap: () {
                _drawerClick(context, ref, 4);
              },
              isSelected: selected == 4),
          const Divider(),
          //Settings
          DrawerBodyContent(
              text: AppLocalizations.of(context)!.settings,
              icon: Icons.settings_outlined,
              onTap: () {
                Navigator.pushNamed(context, Settings.id);
              },
              isSelected: selected == 5),
          //Apps
          DrawerBodyContent(
              text:AppLocalizations.of(context)!.o_apps,
              icon: Icons.apps_rounded,
              onTap: () {
                Navigator.pushNamed(context, AppPage.id);
              },
              isSelected: selected == 6),
          //Signout
          DrawerBodyContent(
              text: AppLocalizations.of(context)!.signout,
              icon: Icons.logout_outlined,
              onTap: () {
                snackBar(
                    context: context,
                    text: AppLocalizations.of(context)!.logout_success,
                    color: Colors.green);
                ref.read(navigatorProvider.notifier).updateCategory(0);
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.id, (route) => false);
              }),
        ],
      ),
    );
  }

  void _drawerClick(BuildContext context, WidgetRef ref, int select) {
    ref.read(navigatorProvider.notifier).updateCategory(select);
    Navigator.popAndPushNamed(context, HomePage.id);
  }
}
