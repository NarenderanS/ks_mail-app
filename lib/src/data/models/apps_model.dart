import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ks_mail/src/data/models/api_response_model.dart';

part 'apps_model.g.dart';

@RestApi(baseUrl: 'https://api-generator.retool.com/QR8LUJ/')
abstract class AppsModel {
  factory AppsModel(Dio dio, {String baseUrl}) = _AppsModel;
  @GET('data')
  Future<List<ApiResponse>> getAllApps();
}
