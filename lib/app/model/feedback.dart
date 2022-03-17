import 'dart:convert';

import 'package:http/http.dart' as http;

class FeedbackMail {
  final http.Client _client = http.Client();
  final String _basUrl = "https://api.emailjs.com/api/v1.0/email/send";

  void sendMailApi(
    String name,
    String email,
    String feedback,
    Function done,
  ) async {
    await _client
        .post(
      Uri.parse(_basUrl),
      headers: {
        "origin": "http://localhost",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "service_id": "service_b8ae1su",
        "template_id": "template_qz148bn",
        "user_id": "user_Cja66w309pycUYFyWDPL5",
        "template_params": {
          "full_name": name,
          "from_name": email,
          "message": feedback,
        },
      }),
    )
        .then((_) {
      done();
    });
  }

  void sendSpamApi({
    required String reported_by,
    required String uploader_uid,
    // required String uploader_email,
    required String item_name,
    required String item_price,
    required String item_reported,
    required String item_receipt,
    required String item_image,
    // required String reporter_email,
    required Function done,
  }) async {
    await _client
        .post(
      Uri.parse(_basUrl),
      headers: {
        "origin": "http://localhost",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "service_id": "service_b8ae1su",
        "template_id": "template_0cvbeyh",
        "user_id": "user_Cja66w309pycUYFyWDPL5",
        "template_params": {
          "reported_by": reported_by,
          "uploader_uid": uploader_uid,
          // "uploader_email": uploader_email,
          "item_name": item_name,
          "item_price": item_price,
          "item_image": item_image,
          "item_receipt": item_receipt,
          "item_reported": item_reported,
          // "from_name": email,
        },
      }),
    )
        .then((_) {
      done();
    });
  }
}
