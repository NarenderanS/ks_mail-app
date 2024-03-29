import '../../presentation/views/home.dart';
import '../../presentation/views/login.dart';
import '../../presentation/views/mail_content.dart';
import '../../presentation/views/new_mail.dart';
import '../../presentation/views/profile.dart';
import '../../presentation/views/register.dart';
import '../../presentation/views/settings.dart';

var appRoutes = {
  LoginPage.id: (context) => LoginPage(),
  RegisterPage.id: (context) => RegisterPage(),
  HomePage.id: (context) => const HomePage(),
  NewMailPage.id: (context) => NewMailPage(),
  MailContentPage.id: (context) => const MailContentPage(),
  Settings.id: (context) => const Settings(),
  ProfilePage.id: (context) => const ProfilePage()
};
