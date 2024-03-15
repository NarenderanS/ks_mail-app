import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/data/datasources/local/database/db_helper.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';
import 'package:ks_mail/src/presentation/views/login.dart';
import 'package:ks_mail/src/presentation/views/register.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/rounded_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/presentation/riverpod/localization.dart';

import 'src/config/router/app_routes.dart';
import 'src/config/themes/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper dbConnection = DBHelper();
  dbConnection.database;

  // dbConnection.showTables();

  // user Table
  // DBHelper.deleteAllUserRows();

  // mail,recipient and status Table
  // DBHelper.deleteAllMailRows();

  // delete the tables
  // DBHelper.deleteTables();

  // delete database
  // DBHelper.deleteDatabase();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: Locale(ref.watch(localizationProvider)),
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'KS Mail',
        theme: appThemeData(),
        home: const WelcomePage(),
        routes: appRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: safePadding,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: Image.asset(
                'assets/images/MailAppLogo.jpg',
                fit: BoxFit.contain,
              ),
            )),
            verticalSpace30px,
            Text(
              AppLocalizations.of(context)!.welcome_message,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            verticalSpace30px,
            Button(
              text: AppLocalizations.of(context)!.login,
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            Text(AppLocalizations.of(context)!.or, textAlign: TextAlign.center),
            Button(
              text: AppLocalizations.of(context)!.register,
              color: const Color.fromARGB(255, 74, 195, 118),
              onPressed: () {
                Navigator.pushNamed(context, RegisterPage.id);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
