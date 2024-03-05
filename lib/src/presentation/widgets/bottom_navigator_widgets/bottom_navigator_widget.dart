import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/utils/constants/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/presentation/riverpod/navigator.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(navigatorProvider);
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              size: 21,
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.star,
              size: 21,
            ),
            label: AppLocalizations.of(context)!.starred,
          ),
        ],
        currentIndex: currentIndex < 2 ? currentIndex : 0,
        selectedItemColor: currentIndex < 2 ? blue300 : Colors.grey.shade600,
        onTap: (value) {
          ref.read(navigatorProvider.notifier).updateCategory(value);
        });
  }
}
