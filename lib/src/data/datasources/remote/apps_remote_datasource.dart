// import 'package:dio/dio.dart';
import 'package:ks_mail/src/data/models/api_response_model.dart';
import 'package:ks_mail/src/data/models/apps_model.dart';

class AppsDataSource {
  final AppsModel appsModel;
  AppsDataSource(this.appsModel);
  Future<List<ApiResponse>> getAllApps() async {
    List<ApiResponse> apps = await appsModel.getAllApps();
    // final dio = Dio();
    // print("################################");
    print(apps);
    // print("################################");
    // Response response =
    //     await dio.get('https://api-generator.retool.com/yQNReW/data');
    // List<ApiResponse> apps = [];
    // // print("-----------------From ds---------------------");
    // for (Map<String, dynamic> app in response.data) {
    //   ApiResponse mappedResponse = ApiResponse.fromJson(app);
    //   // print(mappedResponse);
    //   apps.add(mappedResponse);
    // }
    // print(apps);
    return apps;
  }
}
