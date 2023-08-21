import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/open_ai_data.dart';

String endPoint(String endPoint) => "$BASE_URL/$endPoint";
Map<String, String> headerBearerOption(String token) =>
    {"content-type": "application/json", "Authorization": "Bearer $token"};
