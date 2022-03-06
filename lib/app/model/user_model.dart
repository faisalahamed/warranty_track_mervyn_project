class UserModel {
  UserModel({
    this.fullname,
    required this.uid,
    required this.email,
    required this.shared,
    this.reportcounter,
  });
  late final String? fullname;
  late final String uid;
  late final String email;
  late bool shared;
  late int? reportcounter;

  UserModel.fromJson(Map<String, dynamic> json, String uuid) {
    fullname = json['fullname'];
    uid = uuid;
    email = json['email'];
    shared = json['shared'];
    reportcounter = json['reportcounter'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullname'] = fullname;
    _data['uid'] = uid;
    _data['email'] = email;
    _data['shared'] = shared;
    _data['reportcounter'] = reportcounter;
    return _data;
  }
}
