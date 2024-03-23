import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/data/datasources/remote/apps_remote_datasource.dart';
import 'package:ks_mail/src/data/models/api_response_model.dart';
import 'package:ks_mail/src/data/models/apps_model.dart';
import 'package:ks_mail/src/data/repositories/apps_repository_impl.dart';
import 'package:ks_mail/src/domain/repositories/apps_repository.dart';

import '../../domain/entities/apps.dart';

final appsDataSourceProvider = Provider<AppsDataSource>((ref) {
  final AppsModel appsModel = AppsModel(Dio());
  return AppsDataSource(appsModel);
});

final appsRepositoryProvider = Provider<AppsRepository>((ref) {
  final appsDataSource = ref.read(appsDataSourceProvider);
  return AppsRepositoryImpl(appsDataSource);
});

final appsListProvider = StateNotifierProvider((ref) {
  final appsRepository = ref.read(appsRepositoryProvider);
  return AppListNotifier(appsRepository);
});

class AppListNotifier extends StateNotifier<List<App>> {
  AppsRepository appsRepository;
  AppListNotifier(this.appsRepository) : super([]);
  Future<List<App>> getAllApps() async {
    if (state.isEmpty) {
      List<ApiResponse> datas = await appsRepository.getAllApps();
      List<App> appList = [];
      for (ApiResponse data in datas) {
        appList.add(App.toMap(data));
      }
      state = appList;
    }
    return state;
  }
}
