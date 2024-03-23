import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/mail.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/presentation/riverpod/mail_provider.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';

import '../../domain/entities/home_page.dart';
import '../../domain/entities/new_mail.dart';
import '../../presentation/views/mail_content.dart';
import 'variables.dart';

// Used to check the provided usersList contains currentUser or not.
// inbuild contains method had not given expected result.
bool isContainsCurrentUser(List<UserDetails> userslist) {
  for (UserDetails user in userslist) {
    if (user.id == currentUser!.id) {
      return true;
    }
  }
  return false;
}

// Used to check whether the provided userList contains user mailId or not.
// Used in new mail to identify the provided mail has match in userlist or not.
bool isContainsMail(List<UserDetails> userslist, mailId) {
  for (UserDetails user in userslist) {
    if (user.mail == mailId) {
      return true;
    }
  }
  return false;
}

// To unfocus the selected or focused textfield used in seach appbar
void unfocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

// To get home page data and title text
getHomePageData(
    {required WidgetRef ref,
    required BuildContext context,
    required int page}) {
  List<Mail> mailList = [];
  switch (page) {
    case 0: //inbox
      mailList = ref
          .watch(mailListNotifierProvider)
          .where((mail) =>
              (isContainsCurrentUser(mail.to) ||
                  isContainsCurrentUser(mail.cc) ||
                  isContainsCurrentUser(mail.bcc)) &&
              !mail.deletedBy.contains(currentUser!.id) &&
              mail.draft != true &&
              !mail.completelyDeleted.contains(currentUser!.id))
          .toList()
          .reversed
          .toList();

      return PageData(
          titleText: AppLocalizations.of(context)!.inbox, mailList: mailList);
    case 1: //starred
      mailList = ref
          .watch(mailListNotifierProvider)
          .where((mail) =>
              mail.starredBy.contains(currentUser!.id) &&
              !mail.deletedBy.contains(currentUser!.id) &&
              !mail.completelyDeleted.contains(currentUser!.id))
          .toList()
          .reversed
          .toList();
      return PageData(
          titleText: AppLocalizations.of(context)!.starred, mailList: mailList);

    case 2: //sent
      mailList = ref
          .watch(mailListNotifierProvider)
          .where((mail) =>
              mail.from.id == currentUser!.id &&
              !mail.deletedBy.contains(currentUser!.id) &&
              !mail.completelyDeleted.contains(currentUser!.id) &&
              mail.draft == false)
          .toList()
          .reversed
          .toList();
      return PageData(
          titleText: AppLocalizations.of(context)!.sent, mailList: mailList);

    case 3: // draft
      mailList = ref
          .watch(mailListNotifierProvider)
          .where((mail) =>
              mail.from.id == currentUser!.id &&
              mail.draft == true &&
              mail.completelyDeleted.isEmpty &&
              mail.deletedBy.isEmpty)
          .toList()
          .reversed
          .toList();
      return PageData(
          titleText: AppLocalizations.of(context)!.draft, mailList: mailList);

    case 4: //bin
      mailList = ref
          .watch(mailListNotifierProvider)
          .where((mail) =>
              mail.deletedBy.contains(currentUser!.id) &&
              !mail.completelyDeleted.contains(currentUser!.id))
          .toList()
          .reversed
          .toList();
      return PageData(
          titleText: AppLocalizations.of(context)!.bin, mailList: mailList);
  }
}

// To show bottom popup messages
void snackBar(
    {required BuildContext context, Color? color, required String text}) {
  final scaffoldContext = ScaffoldMessenger.of(context);
  scaffoldContext.showSnackBar(
    SnackBar(
      backgroundColor: color ?? Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}

// // To show bottom popup messages with undo option
// void snackBarWithUndo(
//     {required BuildContext context,
//     Color? color,
//     required String text,
//     required WidgetRef ref,
//     required int mailId}) {
//   final scaffoldContext = ScaffoldMessenger.of(context);
//   scaffoldContext.showSnackBar(
//     SnackBar(
//       backgroundColor: color ?? Colors.red,
//       content: Text(text),
//       duration: const Duration(seconds: 2),
//       action: SnackBarAction(
//           label: 'Undo',
//           onPressed: () {
//             moveFromBin(
//                 context: context, ref: ref, mailId: mailId, back: false);
//           }),
//     ),
//   );
// }

// Move to bin or delete permanently based on delete number.
deleteMail(
    {required BuildContext context,
    required WidgetRef ref,
    required int mailId,
    int? delete,
    bool? swipe = false}) async {
  if (delete == 4) {
    ref.read(mailListNotifierProvider.notifier).deleteMail(mailId);
    snackBar(
      context: context,
      text: AppLocalizations.of(context)!.content_mail_del_per,
    );
  } else {
    ref.read(mailListNotifierProvider.notifier).moveToBin(mailId);
    snackBar(context: context, text: AppLocalizations.of(context)!.content_mail_move_to_bin);
  }
  if (!swipe!) {
    Navigator.pop(context);
  }
}
// Move from bin to original place
Future<void> moveFromBin(
    {required BuildContext context,
    required WidgetRef ref,
    required int mailId,
    bool? back = true}) async {
  ref.read(mailListNotifierProvider.notifier).moveFromBin(mailId);
  snackBar(
      context: context,
      text: AppLocalizations.of(context)!.content_mail_moved_back,
      color: Colors.green);
  if (back!) Navigator.pop(context);
}

// This is used in home page to mark mail as readed.
boldToNormalText(
    {required BuildContext context,
    required WidgetRef ref,
    required int mailId,
    required int page}) {
  if (page != 3) {
    ref.read(mailListNotifierProvider.notifier).updateReadedMail(mailId);
  }
  Navigator.pushNamed(context, MailContentPage.id,
      arguments: NewMail(mailId, page));
}

// This is used in mail_content appBar to mark mail as unreaded.
normalToBoldText({
  required BuildContext context,
  required WidgetRef ref,
  required int mailId,
}) {
  ref.read(mailListNotifierProvider.notifier).undoReadedMail(mailId);
  Navigator.pop(context);
}

// This will send the to,cc and bcc. This will show in home & mail_content page
String getData(
    {required int page,
    required List<UserDetails> toList,
    required List<UserDetails> ccList,
    required List<UserDetails> bccList,
    required String from}) {
  String data = '';
  if ((toList.isNotEmpty || ccList.isNotEmpty || bccList.isNotEmpty) &&
      (isContainsCurrentUser(toList) ||
          isContainsCurrentUser(ccList) ||
          isContainsCurrentUser(bccList) ||
          from == currentUser!.mail)) {
    data +=
        "${page == 2 ? "To" : "to"}: ${getUsernamesFromList(mailList: toList).replaceAll("\n", ",")} ";
    // print("to data :$data");
  }
  if (ccList.isNotEmpty) {
    data +=
        "${page == 2 ? "Cc" : "cc"}: ${getUsernamesFromList(mailList: ccList).replaceAll("\n", ",")} ";
    // print("cc data: $data");
  }
  if (bccList.isNotEmpty && from == currentUser!.mail) {
    data +=
        "${page == 2 ? "Bcc" : "bcc"}: ${getUsernamesFromList(mailList: bccList).replaceAll("\n", ",")} ";

    // print("bcc data: $data");
  } else if (bccList.isNotEmpty && isContainsCurrentUser(bccList)) {
    data += page == 2 ? "BCC" : "bcc:" "You";
    // print("bcc data: $data");
  }
  return data;
}

// This will return all Users username in the provided as a single String with \n separator.
String getUsernamesFromList({required List<UserDetails> mailList}) {
  String users = mailList.map((user) {
    if (user.id == currentUser!.id) {
      return "me";
    }
    // print(user.username);
    return user.username;
  }).join("\n");
  return users;
}

// Dialog box with content and ok for close will display.This will trigger from send_mail_button_widget.
Future<dynamic> alertDialogBox(
    {required BuildContext context, required String contentText}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      // Content Wiil display here
      content: Text(
        contentText,
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.start,
      ),
      actions: [
        TextButton(
          style: buttonStyle,
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context)!.ok,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

// getHomeData(
//     {required WidgetRef ref,
//     required BuildContext context,
//     required int page}) {
//   List<Mail> mailList;
//   switch (page) {
//     case 0: //inbox
//       mailList = ref.watch(mailListNotifierProvider.notifier).getUserMails();
//       return PageData(
//           titleText: AppLocalizations.of(context)!.inbox, mailList: mailList);
//     case 1: //starred
//       mailList = ref.watch(mailListNotifierProvider.notifier).getStarredMails();
//       return PageData(
//           titleText: AppLocalizations.of(context)!.starred, mailList: mailList);
//     case 2: //sent
//       mailList =
//           ref.watch(mailListNotifierProvider.notifier).getUserSentMails();
//       return PageData(
//           titleText: AppLocalizations.of(context)!.sent, mailList: mailList);
//     case 3: // draft
//       mailList = ref.watch(mailListNotifierProvider.notifier).getUserDraft();
//       return PageData(
//           titleText: AppLocalizations.of(context)!.draft, mailList: mailList);
//     case 4: //bin
//       mailList = ref.watch(mailListNotifierProvider.notifier).getUserBinMails();
//       return PageData(
//           titleText: AppLocalizations.of(context)!.bin, mailList: mailList);
//   }
// }













// Textfield autocomplete
                  //  Autocomplete<String>(
                  //   // initialValue: toController.value,
                  //   optionsBuilder: (toController) {
                  //     if (toController.text == '') {
                  //       return const Iterable<String>.empty();
                  //     }
                  //     return currentUser.knownMails.where((mailId) {
                  //       if (!isContainsMail(toList, mailId)) {
                  //         return mailId
                  //             .contains(toController.text.toLowerCase());
                  //       }
                  //       return false;
                  //     });
                  //   },
                  //   onSelected: (String selection) {
                  //     print(toController.text);
                  //     setState(() {
                  //       print("to: $selection");
                  //       UserDetails user = ref
                  //           .read(userProvider.notifier)
                  //           .getUserByMail(selection);
                  //       if (user.mail == selection) {
                  //         toList.add(user);
                  //         toController.text = '';
                  //       } else {
                  //         snakeBar(
                  //             context: context,
                  //             text: "Mail Id not found in our database");
                  //       }
                  //     });
                  //     print(toList);
                  //   },
                  //   // child: TextFormField(),
                  // );
