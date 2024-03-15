
import '../../domain/entities/mail.dart';

class MailModel {
  int? id;
  int? fromId;
  String? subject;
  String? body;
  int? draft;
  String? createdAt;
  String? updatedAt;
  MailModel(
      {this.id,
      this.fromId,
      this.subject,
      this.body,
      this.draft,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromId': fromId,
      'subject': subject,
      'body': body,
      'draft': draft,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

MailModel mapToMailModel(Mail mail) {
  return MailModel(
    id: mail.id,
    fromId: mail.from.id,
    subject: mail.subject,
    body: mail.body,
    draft: mail.draft ? 1 : 0,
    createdAt: mail.createdAt,
    updatedAt: mail.updatedAt,
  );
}
