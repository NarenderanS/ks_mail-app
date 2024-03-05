import 'package:flutter/material.dart';

const linearGradient = LinearGradient(colors: [
  Color.fromARGB(255, 77, 198, 151),
  Color.fromRGBO(2, 170, 189, 1)
]);
const green = Color.fromRGBO(32, 201, 150, 1);
const green400 = Color.fromRGBO(74, 222, 128, 1);
const green500 = Color.fromRGBO(34, 197, 94, 1);
const green700 = Color.fromRGBO(7, 179, 99, 1);
const dullBlue = Color.fromARGB(255, 224, 236, 247);
const blue100 = Color.fromARGB(255, 187, 222, 251);
const blue200 = Color.fromARGB(255, 144, 202, 249);
const blue300 = Color.fromARGB(255, 100, 181, 246);

const logo = Image(
    image: AssetImage(
  "assets/images/MailAppLogo.jpg",
));
const welcomeMessage = Text(
  "Welcome to KS Mail",
  style: textStyle,
  textAlign: TextAlign.center,
);
const safePadding = EdgeInsets.all(30);
const textWhite = TextStyle(color: Colors.white);
const requiredField = Padding(
  padding: EdgeInsets.only(top: 10),
  child: Text(
    "*",
    style: TextStyle(color: Colors.red),
    textAlign: TextAlign.center,
  ),
);
const verticalSpace30px = SizedBox(
  height: 30,
);
const drawerTheme = DrawerThemeData(backgroundColor: dullBlue);
const dialogTheme = DialogTheme(
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(color: Colors.black));
const floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: blue100,
);
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

bool longpressAppBar = false;

const rowSpacer = TableRow(children: [
  SizedBox(
    height: 4,
  ),
  SizedBox(
    height: 4,
  )
]);

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
