import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';

import '../../../utils/constants/commom_functions.dart';
import '../../views/profile.dart';

class SearchAppbar extends ConsumerWidget {
  const SearchAppbar(
      {super.key, required this.keyvalue, required this.filterList});
  //Key to open drawer
  final GlobalKey<ScaffoldState> keyvalue;
  final void Function(String value) filterList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
        onTapOutside: (event) => unfocus(context),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.search,
          // To open drawer
          prefixIcon: GestureDetector(
              onTap: () {
                keyvalue.currentState!.openDrawer();
              },
              child: menuIcon),
          prefixIconColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.focused)
                  ? Colors.black
                  : Colors.black87),
          // User Profile
          suffixIcon: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfilePage.id);
            },
            child: profileIcon,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black26)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(30)),
        ),
        onChanged: (value) => filterList(value));
  }
}
