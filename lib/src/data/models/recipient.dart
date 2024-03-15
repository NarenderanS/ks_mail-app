import 'package:ks_mail/src/domain/entities/mail.dart';

class RecipientModel {
  int? id;
  int? mailId;
  int? userId;
  String? recipientType;
  RecipientModel({this.id, this.mailId, this.userId, this.recipientType});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mailId': mailId,
      'userId': userId,
      'recipientType': recipientType,
    };
  }
}

List<RecipientModel> mapToRecipientModel(Mail mail, mailId) {
  List<RecipientModel> recipients = [];
  recipients.addAll(mail.to.map((user) =>
      RecipientModel(mailId: mailId, userId: user.id, recipientType: 'To')));
  recipients.addAll(mail.cc.map((user) =>
      RecipientModel(mailId: mailId, userId: user.id, recipientType: 'Cc')));
  recipients.addAll(mail.bcc.map((user) =>
      RecipientModel(mailId: mailId, userId: user.id, recipientType: 'Bcc')));
  return recipients;
}
