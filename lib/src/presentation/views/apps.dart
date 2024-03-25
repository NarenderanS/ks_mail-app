import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/riverpod/app_provider.dart';
import 'package:ks_mail/src/utils/constants/colors.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/apps.dart';
import '../widgets/list_view_widgets/app_list_view_widget.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  static String id = 'app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.o_apps),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return FutureBuilder(
            future: ref.read(appsListProvider.notifier).getAllApps(),
            builder: (context, snapshot) {
              // While fetching the data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: green700,
                ));
              }
              // If error occured
              else if (snapshot.hasError) {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      noInternetIcon,
                      verticalSpace10px,
                      Text(
                        AppLocalizations.of(context)!.no_internet,
                        style: const TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              // Data fetched
              else {
                final List<App> data = snapshot.data!;
                return AppListViewWidget(appList: data);
              }
            },
          );
        },
      ),
    );
  }
}
