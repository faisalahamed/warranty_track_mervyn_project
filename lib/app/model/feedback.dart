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
        "service_id": "service_krk9tbo",
        "template_id": "template_ulvkf8a",
        "user_id": "user_fCghKsIlAoSTphM3pIB3W",
        "template_params": {
          "full_name": name,
          "email_id": email,
          "feedback": feedback,
        },
      }),
    )
        .then((_) {
      done();
    });
  }
}
