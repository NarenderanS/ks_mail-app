import 'package:flutter/material.dart';
import 'package:ks_mail/src/utils/constants/colors.dart';

// Used in WelcomePage
const welcomeMessage = Text(
  "Welcome to KS Mail",
  style: textStyle,
  textAlign: TextAlign.center,
);

// Spacing

// Used in WlecomePage,Login,Profile,Register for margin
const safePadding = EdgeInsets.all(30);
// Used in Welcome Page
const verticalSpace30px = SizedBox(
  height: 30,
);
// Used in text widget- address card widget.
const rowSpacer = TableRow(children: [
  SizedBox(
    height: 4,
  ),
  SizedBox(
    height: 4,
  )
]);


// For Text fields
const requiredField = Padding(
  padding: EdgeInsets.only(top: 10),
  child: Text(
    "*",
    style: TextStyle(color: Colors.red),
    textAlign: TextAlign.center,
  ),
);
// Used in text field widgets-emaiil,password,phoneNo and username widget to customs the form field.
InputDecoration textFieldDecoration(String text, Icon? icon) {
  return InputDecoration(
    labelText: " *$text",
    // suffixIcon: requiredField,
    prefixIcon: icon,
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.lightBlueAccent),
        borderRadius: BorderRadius.circular(30)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

const drawerTheme = DrawerThemeData(backgroundColor: dullBlue);
const dialogTheme = DialogTheme(
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(color: Colors.black));
const floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: blue100,
);
// Text Styling
const textWhite = TextStyle(color: Colors.white);
const textStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black);
const linkText = TextStyle(
    color: Colors.lightBlue,
    decoration: TextDecoration.underline,
    decorationColor: Colors.lightBlue);
const smallFont = TextStyle(fontSize: 13);
const timeStyle = TextStyle(fontSize: 9, fontWeight: FontWeight.w600);
const titleUnreadedFont =
    TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700);
const subjectUnreadedFont = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w700,
);
const titleReadedFont = TextStyle(color: Colors.black, fontSize: 16);
const subjectReadedFont = TextStyle(fontSize: 13);

// Button style
var buttonStyle = ButtonStyle(
  overlayColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return const Color.fromARGB(179, 207, 204, 204);
      }
      return const Color.fromARGB(255, 255, 255, 255);
    },
  ),
);
// App Logo still not used.
const logo = Image(
    image: AssetImage(
  "assets/images/MailAppLogo.jpg",
));