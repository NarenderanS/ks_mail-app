class ApiResponse {
  int? id;
  String? appname;
  String? filesize;
  String? downloads;
  String? applogo;
  String? review;
  ApiResponse(
      {this.id,
      this.appname,
      this.downloads,
      this.filesize,
      this.applogo,
      this.review});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        id: json['id'],
        appname: json['appname'],
        filesize: json['filesize'].toString(),
        downloads: json['downloads'].toString(),
        review: json['review'].toString(),
        applogo: json['applogo']);
  }
  @override
  String toString() {
    return "id:$id, appname:$appname, filesize:$filesize, downloads:$downloads, review:$review, applogo: $applogo";
  }
}
