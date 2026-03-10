class ResponseModel {
  String? message;
  dynamic data;
  int? statusCode;
  bool? success;
  List<dynamic>? list;
  dynamic meta;
  String? status;

  ResponseModel({
    this.message,
    this.data,
    this.statusCode,
    this.success,
    this.list,
    this.meta,
    this.status,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'] as String,
      data: json['data'] as dynamic,
      statusCode: json['statusCode'] as int,
      success: json['success'] as bool,
      list: json["list"] == null ? [] : List<dynamic>.from(json["list"].map((x) => x)),
      meta: json['meta'] as dynamic,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'data': data,
      'list': list,
      'statusCode': statusCode,
      'success': success,
      'meta': meta,
      'status': status,
    };
  }
}
