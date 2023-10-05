class GovsModel {
  List<Data>? data;
  String? message;
  List<Null>? error;
  int? status;

  GovsModel({this.data, this.message, this.error, this.status});

  GovsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    if (json['error'] != null) {
      error = <Null>[];
      json['error'].forEach((v) {
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.error != null) {
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? governorateNameEn;

  Data({this.id, this.governorateNameEn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateNameEn = json['governorate_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['governorate_name_en'] = this.governorateNameEn;
    return data;
  }
}
