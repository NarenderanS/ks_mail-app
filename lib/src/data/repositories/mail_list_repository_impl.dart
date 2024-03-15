import 'package:dartz/dartz.dart';
import 'package:ks_mail/core/error/failures.dart';
import 'package:ks_mail/src/data/datasources/local/mail_list_local_datasource.dart';
import 'package:ks_mail/src/domain/entities/mail.dart';
import 'package:ks_mail/src/domain/repositories/mail_list_repository.dart';

class MailListRepositoryImpl extends MailListRepository {
  final MailListLocalDataSource mailListLocalDataSource;
  MailListRepositoryImpl(this.mailListLocalDataSource);
  @override
  Future<Either<Failure, List<Mail>>> getMailsFromDB() async {
    try {
      final List<Mail> getMailsFromDB =
          await mailListLocalDataSource.getAllMailsFromDB();
      return Right(getMailsFromDB);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<void> editDraft(Mail mail) async {
    mailListLocalDataSource.editDraft(mail);
  }

  @override
  Future<int> addMail(Mail mail) async {
    return mailListLocalDataSource.addMail(mail);
  }

  @override
  Future<void> deleteMail(int mailId) async {
    mailListLocalDataSource.deleteMail(mailId);
  }

  

  @override
  Future<void> moveFromBin(int mailId) async {
    mailListLocalDataSource.moveFromBin(mailId);
  }

  @override
  Future<void> moveToBin(int mailId) async {
    mailListLocalDataSource.moveToBin(mailId);
  }

  @override
  Future<void> undoReadedMail(int mailId) async {
    mailListLocalDataSource.undoReadedMail(mailId);
  }

  @override
  Future<void> upadateReadedMail(int mailId) async {
    mailListLocalDataSource.upadateReadedMail(mailId);
  }

  @override
  Future<void> upadateStar(int mailId) async {
    mailListLocalDataSource.upadateStar(mailId);
  }
  @override
  Future<void> removeStarred(int mailId) async {
    mailListLocalDataSource.deleteStarred(mailId);
  }
}
