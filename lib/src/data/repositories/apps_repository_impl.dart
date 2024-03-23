import 'package:ks_mail/src/data/datasources/remote/apps_remote_datasource.dart';
import 'package:ks_mail/src/data/models/api_response_model.dart';

import '../../domain/repositories/apps_repository.dart';

class AppsRepositoryImpl extends AppsRepository {
  final AppsDataSource appsDataSource;
  AppsRepositoryImpl(this.appsDataSource);

  @override
  Future<List<ApiResponse>> getAllApps() async {
    return await appsDataSource.getAllApps();
  }
}
