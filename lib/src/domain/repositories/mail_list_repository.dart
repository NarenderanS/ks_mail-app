import 'package:dartz/dartz.dart';
import 'package:ks_mail/core/error/failures.dart';
import 'package:ks_mail/src/domain/entities/mail.dart';

abstract class MailListRepository {
  Future<Either<Failure, List<Mail>>> getMailsFromDB();
  Future<int> addMail(Mail mail);
  Future<void> moveToBin(int mailId);
  Future<void> moveFromBin(int mailId);
  Future<void> deleteMail(int mailId);
  Future<void> upadateStar(int mailId);
  Future<void> removeStarred(int mailId);
  Future<void> upadateReadedMail(int mailId);
  Future<void> undoReadedMail(int mailId);
  Future<void> editDraft(Mail mail);


}
