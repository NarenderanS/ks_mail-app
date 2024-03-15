import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/core/error/failures.dart';
import 'package:ks_mail/src/data/datasources/local/mail_list_local_datasource.dart';
import 'package:ks_mail/src/data/repositories/mail_list_repository_impl.dart';
import 'package:ks_mail/src/domain/entities/mail.dart';
import 'package:ks_mail/src/domain/repositories/mail_list_repository.dart';

import '../../domain/entities/user_details.dart';
import '../../utils/constants/commom_functions.dart';
import '../../utils/constants/variables.dart';
import '../../utils/date_time.dart';

final mailListLocalDataSourceProvider =
    Provider<MailListLocalDataSource>((ref) => MailListLocalDataSource());

final mailListRepositoryProvider = Provider<MailListRepository>((ref) {
  final mailListLocalDataSource = ref.read(mailListLocalDataSourceProvider);
  return MailListRepositoryImpl(mailListLocalDataSource);
});

final mailListNotifierProvider =
    StateNotifierProvider<MailListNotifier, List<Mail>>((ref) {
  final mailListRepository = ref.read(mailListRepositoryProvider);
  return MailListNotifier(mailListRepository);
});

class MailListNotifier extends StateNotifier<List<Mail>> {
  MailListRepository mailListRepository;
  MailListNotifier(this.mailListRepository) : super([]);
  Future<List<Mail>> getMailsFromDB() async {
    final Either<Failure, List<Mail>> mailsOrFailure =
        await mailListRepository.getMailsFromDB();
    return mailsOrFailure.fold((error) => state = [], (mails) => state = mails);
  }

  List<Mail> getUserMails() {
    return state
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
  }

  List<Mail> getStarredMails() {
    return state
        .where((mail) =>
            mail.starredBy.contains(currentUser!.id) &&
            !mail.deletedBy.contains(currentUser!.id) &&
            !mail.completelyDeleted.contains(currentUser!.id))
        .toList()
        .reversed
        .toList();
  }

  Mail getMailById(int mailId) {
    return state.where((mail) => mail.id == mailId).toList()[0];
  }

  List<Mail> getUserSentMails() {
    return state
        .where((mail) =>
            mail.from.id == currentUser!.id &&
            !mail.deletedBy.contains(currentUser!.id) &&
            !mail.completelyDeleted.contains(currentUser!.id) &&
            mail.draft == false)
        .toList()
        .reversed
        .toList();
  }

  List<Mail> getUserDraft() {
    return state
        .where((mail) =>
            mail.from.id == currentUser!.id &&
            mail.draft == true &&
            mail.completelyDeleted.isEmpty &&
            mail.deletedBy.isEmpty)
        .toList()
        .reversed
        .toList();
  }

  List<Mail> getUserBinMails() {
    return state
        .where((mail) =>
            mail.deletedBy.contains(currentUser!.id) &&
            !mail.completelyDeleted.contains(currentUser!.id))
        .toList()
        .reversed
        .toList();
  }

  Future<int> addDraft(
      {int? id,
      List<UserDetails>? toData,
      List<UserDetails>? bccData,
      List<UserDetails>? ccData,
      String? subjectData,
      String? bodyData}) async {
    DateTimeFormat dateTimeFormat = DateTimeFormat();

    Mail newMail = Mail(
        id: id ?? 0,
        from: mapToUserDetails(currentUser!),
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
    newMail.id = await mailListRepository.addMail(newMail);
    state = [...state, newMail];
    return newMail.id!;
  }

  Future<void> editDraft(
      {required int id,
      List<UserDetails>? toData,
      List<UserDetails>? bccData,
      List<UserDetails>? ccData,
      String? subjectData,
      String? bodyData}) async {
    DateTimeFormat dateTimeFormat = DateTimeFormat();
    Mail editedMail = Mail(
        id: id,
        from: mapToUserDetails(currentUser!),
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
        createdAt: state[id - 1].createdAt,
        updatedAt: dateTimeFormat.getDateTime());
    await mailListRepository.editDraft(editedMail);
    final List<Mail> updatedMails = List.from(state);
    updatedMails[id - 1] = editedMail;
    state = updatedMails;
  }

  Future<void> addMail(
      {required int id,
      List<UserDetails>? toData,
      List<UserDetails>? bccData,
      List<UserDetails>? ccData,
      String? subjectData,
      String? bodyData}) async {
    DateTimeFormat dateTimeFormat = DateTimeFormat();
    Mail newMail = (Mail(
        id: id,
        from: mapToUserDetails(currentUser!),
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
      newMail.id = await mailListRepository.addMail(newMail);
      state = [...state, newMail];
    } else {
      state[id - 1] = newMail;
    }
  }

  Future<void> moveToBin(int mailId) async {
    await mailListRepository.moveToBin(mailId);
    final List<Mail> updatedMails = List.from(state);
    updatedMails[mailId - 1].deletedBy.add(currentUser!.id!);
    state = updatedMails;
  }

  Future<void> moveFromBin(int mailId) async {
    await mailListRepository.moveFromBin(mailId);
    final List<Mail> updatedMails = List.from(state);
    updatedMails[mailId - 1].deletedBy.remove(currentUser!.id);
    state = updatedMails;
  }

  Future<void> deleteMail(int mailId) async {
    await mailListRepository.deleteMail(mailId);
    final List<Mail> updatedMails = List.from(state);
    updatedMails[mailId - 1].completelyDeleted.add(currentUser!.id!);
    state = updatedMails;
  }

  Future<void> emptyBin(int userId) async {
    final List<Mail> updatedMails = [];
    for (Mail mail in state) {
      if (mail.deletedBy.contains(currentUser!.id)) {
        await mailListRepository.deleteMail(mail.id!);
        mail.completelyDeleted.add(currentUser!.id!);
      }
      updatedMails.add(mail);
    }
    state = updatedMails;
  }

  Future<void> updateStar(int mailId) async {
    final List<Mail> updatedMails = List.from(state);
    if (updatedMails[mailId - 1].starredBy.contains(currentUser!.id)) {
      await mailListRepository.removeStarred(mailId);
      updatedMails[mailId - 1].starredBy.remove(currentUser!.id);
    } else {
      await mailListRepository.upadateStar(mailId);
      updatedMails[mailId - 1].starredBy.add(currentUser!.id!);
    }
    state = updatedMails;
  }

  Future<void> updateReadedMail(int mailId) async {
    final List<Mail> updatedMails = List.from(state);
    if (!updatedMails[mailId - 1].readedBy.contains(currentUser!.id)) {
      await mailListRepository.upadateReadedMail(mailId);
      updatedMails[mailId - 1].readedBy.add(currentUser!.id!);
    }
    state = updatedMails;
  }

  Future<void> undoReadedMail(int mailId) async {
    final List<Mail> updatedMails = List.from(state);
    if (updatedMails[mailId - 1].readedBy.contains(currentUser!.id)) {
      await mailListRepository.undoReadedMail(mailId);
      updatedMails[mailId - 1].readedBy.remove(currentUser!.id);
    }
    state = updatedMails;
  }
}
