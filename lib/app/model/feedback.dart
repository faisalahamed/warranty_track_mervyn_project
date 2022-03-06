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
}
