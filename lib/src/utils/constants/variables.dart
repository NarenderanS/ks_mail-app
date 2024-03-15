import 'package:ks_mail/src/domain/entities/user.dart';

late User? currentUser;
// Only idea
bool longpressAppBar = false;

// For Database
// Columns
const id = 'id';
const username = 'username';
const mail = 'mail';
const phoneNo = 'phoneNo';
const password = 'password';
const createdAt = 'createdAt';
const updatedAt = 'updatedAt';
const mailId = 'mailId';
const userId = 'userId';
const from = 'fromId';
const subject = 'subject';
const body = 'body';
const draft = 'draft';
const statusType = 'statusType';
const recipientType = 'recipientType';

class Table {
  static const user = 'User';
  static const mail = 'Mail';
  static const recipient = 'Recipients';
  static const status = 'MailStatus';
}

class Status {
  static const starred = 'Starred';
  static const read = 'Read';
  static const delete = 'Delete';
  static const completeltyDeleted = 'CompletelyDeleted';
}

class RecipientType {
  static const to = 'To';
  static const cc = 'Cc';
  static const bcc = 'Bcc';
}
