import 'package:flutter/material.dart';

class PrefixTextFieldWithFunctionWidget extends StatelessWidget {
  const PrefixTextFieldWithFunctionWidget(
      {super.key,
      required this.toController,
      required this.onTap,
      required this.text,
      required this.onFieldSubmit,
      required this.filterList});

  final TextEditingController toController;
  final VoidCallback onTap;
  final void Function(String value) onFieldSubmit;
  final String text;
  final void Function(String value) filterList;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: toController,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 17),
          ),
        ),
        suffixIcon: GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.keyboard_arrow_down_outlined)),
      ),
      onFieldSubmitted: onFieldSubmit,
      onChanged: (value) => filterList(value),
    );
  }
}

class PrefixTextFieldWidget extends StatelessWidget {
  const PrefixTextFieldWidget(
      {super.key,
      required this.controller,
      this.text,
      this.hintText,
      this.onFieldSubmit,
      this.filterList});

  final TextEditingController controller;
  final String? text;
  final String? hintText;
  final void Function(String value)? onFieldSubmit;
  final void Function(String value)? filterList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
              child: Text(
                text ?? "",
                style: const TextStyle(fontSize: 17),
              ),
            ),
            hintText: hintText ?? "",
          ),
          onFieldSubmitted: onFieldSubmit,
          onChanged: (value) => filterList == null ? () {} : filterList!(value),
        ),
        // Visibility(child: Text("asa"),),
      ],
    );
  }
}

class HintTextFieldWidget extends StatelessWidget {
  const HintTextFieldWidget(
      {super.key, required this.controller, this.hintText});

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText ?? "",
      ),
    );
  }
}




// class TextFieldWidget extends StatelessWidget {
//   const TextFieldWidget(
//       {super.key,
//       required this.text,
//       this.icon,
//       required this.textHide,
//       required this.controller});
//   final bool textHide;
//   final String text;
//   final TextEditingController controller;
//   final Icon? icon;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextFormField(
//         controller: controller,
//         // style: const TextStyle(fontSize: 20),
//         cursorColor: Colors.lightBlueAccent,
//         // autofocus: true,
//         // textAlign:TextAlign.center,
//         // keyboardType: TextInputType.emailAddress,
//         obscureText: textHide,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return "Please Enter some text";
//           }
//           return null;
//         },
//         decoration: textFieldDecoration(text,icon),
//       ),
//     );
//   }
// }
