import 'package:ks_mail/src/domain/entities/mail.dart';

class MailStatusModel {
  int? id;
  int? mailId;
  int? userId;
  String? statusType;
  MailStatusModel({this.id, this.mailId, this.userId, this.statusType});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mailId': mailId,
      'userId': userId,
      'statusType': statusType,
    };
  }
}

List<MailStatusModel> mapToMailStatusModel(Mail mail, mailId) {
  List<MailStatusModel> statuses = [];
  statuses.addAll(mail.readedBy.map((userId) =>
      MailStatusModel(mailId: mailId, userId: userId, statusType: 'Read')));
  statuses.addAll(mail.starredBy.map((userId) =>
      MailStatusModel(mailId: mailId, userId: userId, statusType: 'Starred')));
  statuses.addAll(mail.deletedBy.map((userId) =>
      MailStatusModel(mailId: mailId, userId: userId, statusType: 'Deleted')));
  statuses.addAll(mail.completelyDeleted.map((userId) => MailStatusModel(
      mailId: mailId, userId: userId, statusType: 'CompletelyDeleted')));
  return statuses;
}
