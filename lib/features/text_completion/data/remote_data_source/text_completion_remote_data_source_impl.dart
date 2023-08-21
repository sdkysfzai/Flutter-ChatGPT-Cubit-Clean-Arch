import 'dart:convert';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/custom_exceptions.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/open_ai_data.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/global/provider/provider.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/text_completion/data/models/text_completion_model.dart';
import 'package:http/http.dart' as http;

import 'text_completion_remote_data_source.dart';

class TextCompletionRemoteDataSourceImpl
    implements TextCompletionRemoteDataSource {
  final http.Client httpClient;

  TextCompletionRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<TextCompletionModel> getTextCompletion(String query) async {
    const String endPointVal = "completions";

    Map<String, String> rowParams = {
      "model": "text-davinci-003",
      "prompt": query,
    };

    final encodedParams = json.encode(rowParams);

    final response = await httpClient.post(
      Uri.parse(endPoint(endPointVal)),
      body: encodedParams,
      headers: headerBearerOption(OPEN_AI_KEY),
    );
    // final response = await httpClient.get(Uri.parse(
    //     'http://127.0.0.1:5500/api_response/text_completion_response.json'));

    if (response.statusCode == 200) {
      return TextCompletionModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: "Text Completion Server Exception");
    }
  }
}
