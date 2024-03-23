import 'package:ks_mail/src/data/models/api_response_model.dart';

abstract class AppsRepository{
  Future<List<ApiResponse>> getAllApps();
}