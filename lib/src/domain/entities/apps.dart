import '../../data/models/api_response_model.dart';

class App {
  int id;
  String appname;
  String filesize;
  String downloads;
  String applogo;
  String review;
  App(
      {required this.id,
      required this.appname,
      required this.downloads,
      required this.filesize,
      required this.review,
      required this.applogo});

  factory App.toMap(ApiResponse data) {
    return App(
        id: data.id!,
        appname: data.appname!,
        downloads: data.downloads!,
        filesize: data.filesize!,
        review: data.review!,
        applogo: data.applogo!);
  }
   @override
  String toString() {
    return "id:$id, appname:$appname, filesize:$filesize, downloads:$downloads, review:$review, applogo: $applogo";
  }
}
