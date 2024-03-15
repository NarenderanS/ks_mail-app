import 'package:ks_mail/src/data/datasources/local/database/db_helper.dart';
import 'package:ks_mail/src/data/datasources/local/user_local_datasource.dart';
import 'package:ks_mail/src/data/models/mail.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/utils/constants/variables.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/mail.dart';
import '../../models/mail_status.dart';
import '../../models/recipient.dart';

class MailListLocalDataSource {
  MailListLocalDataSource();
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  int currentUserId = currentUser!.id!;

  Future getAllMailsFromDB() async {
    Database db = await getDatabase();
    List mailsFromDB = await db.query(Table.mail);
    print('All mails :${mailsFromDB.length}');
    return await mapToMailList(mailsFromDB);
  }

  Future<List<UserDetails>> getRecipients(
      int mailId, String recipientType) async {
    final Database database = await getDatabase();
    List<Map<String, dynamic>> results = await database.query(Table.recipient,
        where: 'mailId = ? AND recipientType = ?',
        whereArgs: [mailId, recipientType]);
    List<UserDetails> recipients = [];
    for (var recipientData in results) {
      recipients
          .add(await userLocalDataSource.getUserById(recipientData[userId]));
    }
    return recipients;
  }

  Future<List<int>> getMailStatus(int mailId, String statusType) async {
    final Database database = await getDatabase();
    List<Map<String, dynamic>> results = await database.query(Table.status,
        where: 'mailId = ? AND statusType = ?',
        whereArgs: [mailId, statusType]);
    return results.map<int>((mailStatus) => mailStatus[userId]).toList();
  }

  void editDraft(Mail mail) async {
    print("${mail.id} from edit draft ds");
    final Database database = await getDatabase();
    await database
        .delete(Table.recipient, where: 'mailId=?', whereArgs: [mail.id]);
    await database
        .delete(Table.status, where: 'mailId=?', whereArgs: [mail.id]);
    int mailId = await addMail(mail);
    print("after edited $mailId");
  }

  Future<int> addMail(Mail mail) async {
    final Database database = await getDatabase();
    int mailId;
    // add data to mailTable
    if (mail.id == 0) {
      mail.id = null;
      mailId = await database.insert(
        Table.mail,
        mapToMailModel(mail).toMap(),
      );

      print('add $mailId');
    }
    //Edit draft mail
    else {
      await database.update(Table.mail, mapToMailModel(mail).toMap(),
          where: 'id=?', whereArgs: [mail.id]);
      mailId = mail.id!;
      print('update $mailId');
      // mails![mail.id! - 1] = mail;
    }
    // add data to recipentTable
    List<RecipientModel> recipients = mapToRecipientModel(mail, mailId);
    for (var recipient in recipients) {
      await database.insert(
        Table.recipient,
        recipient.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    // add data to mailStatusTable
    List<MailStatusModel> statuses = mapToMailStatusModel(mail, mailId);
    for (var status in statuses) {
      await database.insert(
        Table.status,
        status.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    print("Mail ${mailId} added to db");
    return mailId;
  }

  void moveToBin(int mailId) async {
    print("move to bin ds $mailId");
    final Database database = await getDatabase();
    await database.insert(
      Table.status,
      MailStatusModel(
              mailId: mailId, userId: currentUserId, statusType: Status.delete)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Mail moved to bin ds $mailId");
  }

  void moveFromBin(int mailId) async {
    print("move from bin ds $mailId");
    final Database database = await getDatabase();
    await database.delete(
      Table.status,
      where: 'mailId = ? AND userId = ? AND statusType = ?',
      whereArgs: [mailId, currentUserId, Status.delete],
    );
    print("Removed read ds $mailId");

    // getUserBinMails(currentUser!.id);
  }

  void deleteMail(int mailId) async {
    // print("delete permanently ds $id");
    final Database database = await getDatabase();
    await database.insert(
      Table.status,
      MailStatusModel(
              mailId: mailId,
              userId: currentUserId,
              statusType: Status.completeltyDeleted)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Mail deleted ds $mailId");
  }

  void upadateStar(int mailId) async {
    final Database database = await getDatabase();
    await database.insert(
      Table.status,
      MailStatusModel(
              mailId: mailId, userId: currentUserId, statusType: Status.starred)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("update star ds $mailId");
  }

  void deleteStarred(int mailId) async {
    final Database database = await getDatabase();
    await database.delete(
      Table.status,
      where: 'mailId = ? AND userId = ? AND statusType = ?',
      whereArgs: [mailId, currentUserId, Status.starred],
    );
    print("Removed star ds $mailId");
  }

  void upadateReadedMail(int mailId) async {
    // print("update Readed mail ds $mailId");
    final Database database = await getDatabase();
    await database.insert(
      Table.status,
      MailStatusModel(
              mailId: mailId, userId: currentUserId, statusType: Status.read)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("update read ds $mailId");
  }

  void undoReadedMail(int mailId) async {
    final Database database = await getDatabase();
    // print("undo Readed mail ds $mailId");
    await database.delete(
      Table.status,
      where: 'mailId = ? AND userId = ? AND statusType = ?',
      whereArgs: [mailId, currentUserId, Status.read],
    );
    print("Removed read ds $mailId");
  }

  Future<List<Mail>> mapToMailList(List<dynamic> mailsFromDB) async {
    List<Mail> mappedMails = [];
    List<int> addedMailIds = [];
    for (Map<String, dynamic> mail in mailsFromDB) {
      // print('ds map to Mail : ${mail['id']}');
      Mail mappedMail = await mapToMail(mail);
      if (!addedMailIds.contains(mappedMail.id)) {
        // print('ds :${mappedMail.id} ${mappedMails.length}');
        addedMailIds.add(mappedMail.id!);
        mappedMails.add(mappedMail);
      }
    }
    print(addedMailIds);

    return mappedMails;
  }

  Future<Mail> mapToMail(Map<String, dynamic> mailModalData) async {
    // Get UserDetails for fromId
    UserDetails from =
        await userLocalDataSource.getUserById(mailModalData['fromId']);

    // Get Recipients for mailId
    List<UserDetails> to =
        await getRecipients(mailModalData['id'], RecipientType.to);
    List<UserDetails> cc =
        await getRecipients(mailModalData['id'], RecipientType.cc);
    List<UserDetails> bcc =
        await getRecipients(mailModalData['id'], RecipientType.bcc);

    // Get MailStatus for mailId
    List<int> readedBy = await getMailStatus(mailModalData['id'], Status.read);
    List<int> starredBy =
        await getMailStatus(mailModalData['id'], Status.starred);
    List<int> deletedBy =
        await getMailStatus(mailModalData['id'], Status.delete);
    List<int> completelyDeleted =
        await getMailStatus(mailModalData['id'], Status.completeltyDeleted);
    // print("To mails---- $to\n");
    // print("Cc mails---- $cc\n");
    // print("bcc mails---- $bcc\n");
    // print("Starred mails---- $starredBy\n");
    // print("Readed mails---- $readedBy\n");
    // print("Deleted mails---- $deletedBy\n");
    // print("Completelydelete mails---- $completelyDeleted\n");
    return Mail(
      id: mailModalData['id'],
      from: from,
      to: to,
      cc: cc,
      bcc: bcc,
      subject: mailModalData['subject'],
      body: mailModalData['body'],
      draft: mailModalData['draft'] == 1,
      readedBy: readedBy,
      starredBy: starredBy,
      deletedBy: deletedBy,
      completelyDeleted: completelyDeleted,
      createdAt: mailModalData['createdAt'],
      updatedAt: mailModalData['updatedAt'],
    );
  }
}
