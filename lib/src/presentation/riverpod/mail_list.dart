import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/utils/constants/mail.dart';
import 'package:ks_mail/src/utils/date_time.dart';
import 'package:ks_mail/src/presentation/riverpod/user.dart';

import '../../domain/entities/mail.dart';

class MailListNotifier extends StateNotifier<List<Mail>> {
  MailListNotifier(List list) : super(mails);

  List<Mail> getUserMail() {
    return state
        .where((mail) =>
            (mail.to.contains(currentUser!) ||
                mail.bcc.contains(currentUser!) ||
                mail.cc.contains(currentUser!)) &&
            !mail.deletedBy.contains(currentUser!.id) &&
            mail.draft != true)
        .toList();
  }

  List<Mail> getStarredMails() {
    return state
        .where((mail) =>
            mail.starredBy.contains(currentUser!.id) &&
            !mail.deletedBy.contains(currentUser!.id) &&
            mail.draft != true)
        .toList();
  }

  List<Mail> getUserSentMails() {
    return state
        .where((mail) =>
            mail.from.mail == currentUser!.mail &&
            !mail.deletedBy.contains(currentUser!.id) &&
            mail.draft == false)
        .toList()
        .reversed
        .toList();
  }

  List<Mail> getUserDraft() {
    return state
        .where((mail) =>
            mail.from.mail == currentUser!.mail &&
            mail.draft == true &&
            mail.deletedBy.isEmpty)
        .toList()
        .reversed
        .toList();
  }

  List<Mail> getUserBinMails() {
    return state
        .where((mail) => mail.deletedBy.contains(currentUser!.id))
        .toList()
        .reversed
        .toList();
  }

  int getMailListLength() {
    return state.length;
  }

  getMail(int id) {
    return state.where((mail) => mail.id == id);
  }

  List<String> getUserKnownMails(String userMail) {
    List<String> mailIdList = [];
    for (var mail in state) {
      List<String> toMails = mail.to.map((user) => user.mail).toList();
      if (toMails.contains(userMail) && !mailIdList.contains(mail.from.mail)) {
        mailIdList.add(mail.from.mail);
      }
      // print(mailIdList);
    }
    return mailIdList;
  }

  int addDraft(
      {List<UserDetails>? toData,
      List<UserDetails>? bccData,
      List<UserDetails>? ccData,
      String? subjectData,
      String? bodyData}) {
    DateTimeFormat dateTimeFormat = DateTimeFormat();

    Mail newMail = Mail(
        id: getMailListLength() + 1,
        from: currentUser!,
        to: toData ?? [],
        bcc: bccData ?? [],
        cc: ccData ?? [],
        subject: subjectData ?? "(no subject)",
        body: bodyData ?? "(no body)",
        draft: true,
        readedBy: [],
        deletedBy: [],
        starredBy: [],
        completelyDeleted: [],
        createdAt: dateTimeFormat.getDateTime(),
        updatedAt: "");
    state = [...state, newMail];
    return newMail.id;
  }

  void editDraft(
      {required int id,
      List<UserDetails>? toData,
      List<UserDetails>? bccData,
      List<UserDetails>? ccData,
      String? subjectData,
      String? bodyData}) {
    final List<Mail> updatedMails = List.from(state);
    DateTimeFormat dateTimeFormat = DateTimeFormat();
    // print("$id from mailList");
    updatedMails[id - 1] = Mail(
        id: id,
        from: currentUser!,
        to: toData ?? [],
        bcc: bccData ?? [],
        cc: ccData ?? [],
        subject: subjectData!.isEmpty ? "(no subject)" : subjectData,
        body: bodyData ?? "",
        draft: true,
        readedBy: [],
        deletedBy: [],
        starredBy: [],
        completelyDeleted: [],
        createdAt: updatedMails[id - 1].createdAt,
        updatedAt: dateTimeFormat.getDateTime());
    ;
    state = updatedMails;
  }

  void addMail(
      {required int id,
      List<UserDetails>? toData,
      List<UserDetails>? bccData,
      List<UserDetails>? ccData,
      String? subjectData,
      String? bodyData}) {
    DateTimeFormat dateTimeFormat = DateTimeFormat();
    Mail newMail = (Mail(
        id: id != 0 ? id : getMailListLength() + 1,
        from: currentUser!,
        to: toData ?? [],
        bcc: bccData ?? [],
        cc: ccData ?? [],
        subject: subjectData!.isEmpty ? "(no subject)" : subjectData,
        body: bodyData!.isEmpty ? "" : bodyData,
        draft: false,
        readedBy: [],
        deletedBy: [],
        starredBy: [],
        completelyDeleted: [],
        createdAt: dateTimeFormat.getDateTime(),
        updatedAt: ""));
    if (id == 0) {
      state = [...state, newMail];
    } else {
      state[id - 1] = newMail;
    }
  }

  moveToBin(int id) {
    final List<Mail> updatedMails = List.from(state);
    updatedMails[id - 1].deletedBy.add(currentUser!.id!);
    state = updatedMails;
  }

  moveFromBin(int id) {
    final List<Mail> updatedMails = List.from(state);
    updatedMails[id - 1].deletedBy.remove(currentUser!.id);
    state = updatedMails;
  }

  deleteMail(int id) {
    // print(id);
    final List<Mail> updatedMails = List.from(state);
    updatedMails[id - 1].completelyDeleted.add(currentUser!.id!);
    state = updatedMails;
  }

  emptyBin() {
    final List<Mail> updatedMails = List.from(state);
    state = updatedMails.map((mail) {
      if (mail.deletedBy.contains(currentUser!.id)) {
        mail.completelyDeleted.add(currentUser!.id!);
      }
      return mail;
    }).toList();
  }

  void upadateStar(int id) {
    int currentUserId = currentUser!.id!;
    // bool star = !state[id - 1].isStarred!;
    final List<Mail> updatedMails = List.from(state);
    updatedMails[id - 1].starredBy.contains(currentUserId)
        ? updatedMails[id - 1].starredBy.remove(currentUserId)
        : updatedMails[id - 1].starredBy.add(currentUserId);

    // updatedMails[id - 1] = updatedMails[id - 1].updateMail(star: star);
    // updatedMails[id-1].isStarred=!updatedMails[id-1].isStarred!;
    // Mail mail = state[id - 1];
    // bool star = !state[id - 1].starred!;
    // updatedMails[id - 1] = Mail(
    //   id: mail.id,
    //   userId: mail.userId,
    //   from: mail.from,
    //   to: mail.to,
    //   senderName: mail.senderName,
    //   subject: mail.subject,
    //   body: mail.body,
    //   draft: mail.draft,
    //   date: mail.date,
    //   time: mail.time,
    //   displayDate: mail.displayDate,
    //   readed: mail.readed,
    //   starred: star,
    // );
    // print(state[id].starred);
    state = updatedMails;
  }

  void upadateReadedMail(int id) {
    final List<Mail> updatedMails = List.from(state);
    if (!state[id - 1].readedBy.contains(currentUser!.id)) {
      state[id - 1].readedBy.add(currentUser!.id!);
    }
    state = updatedMails;
  }

  void undoReadedMail(int id) {
    print("passed");
    final List<Mail> updatedMails = List.from(state);
    if (state[id - 1].readedBy.contains(currentUser!.id)) {
      state[id - 1].readedBy.remove(currentUser!.id!);
    }
    state = updatedMails;
  }
}

final mailListProvider =
    StateNotifierProvider<MailListNotifier, List<Mail>>((ref) {
  return MailListNotifier([]);
});
