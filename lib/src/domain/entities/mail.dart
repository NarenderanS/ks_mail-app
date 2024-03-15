import 'user_details.dart';

class Mail {
  int? id;
  final UserDetails from;
  final List<UserDetails> to;
  final List<UserDetails> bcc;
  final List<UserDetails> cc;
  final String subject;
  final String body;
  final bool draft;
  final List<int> readedBy;
  final List<int> starredBy;
  final List<int> deletedBy;
  final List<int> completelyDeleted;
  final String createdAt;
  final String updatedAt;

  Mail({
    this.id,
    required this.from,
    required this.to,
    required this.bcc,
    required this.cc,
    required this.subject,
    required this.body,
    required this.draft,
    required this.readedBy,
    required this.starredBy,
    required this.deletedBy,
    required this.completelyDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  Mail updateMail(
      {List<UserDetails>? toContent,
      List<UserDetails>? bccContent,
      List<UserDetails>? ccContent,
      String? subjectContent,
      String? bodyContent,
      bool? draftContent,
      List<int>? updatedDeletedBy,
      List<int>? updatedStarredBy,
      List<int>? upadateReadedBy,
      List<int>? updatedCompletelyDeleted,
      String? updatedDateTime}) {
    return Mail(
        id: id,
        from: from,
        to: toContent ?? to,
        bcc: bccContent ?? bcc,
        cc: ccContent ?? cc,
        subject: subjectContent ?? subject,
        body: bodyContent ?? body,
        draft: draftContent ?? draft,
        readedBy: upadateReadedBy ?? readedBy,
        starredBy: updatedStarredBy ?? starredBy,
        deletedBy: updatedDeletedBy ?? deletedBy,
        completelyDeleted: updatedCompletelyDeleted ?? completelyDeleted,
        createdAt: createdAt,
        updatedAt: updatedDateTime ?? updatedAt);
  }

  @override
  String toString() {
    return 'Mail{id: $id,\n from: $from,\n to: $to,\n bcc: $bcc,\n cc: $cc, subject: $subject,\n body: $body,\n draft: $draft,\n readedBy: $readedBy,\n starredBy: $starredBy, \ndeletedBy: $deletedBy,\n completelyDeleted: $completelyDeleted,\n createdAt: $createdAt,\n updatedAt: $updatedAt}';
  }
}
