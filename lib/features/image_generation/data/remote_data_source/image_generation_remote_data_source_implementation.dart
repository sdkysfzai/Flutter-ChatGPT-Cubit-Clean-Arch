import 'dart:convert';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/custom_exceptions.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/open_ai_data.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/global/provider/provider.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/data/models/image_generation_model.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/data/remote_data_source/image_generation_remote_data_source.dart';
import 'package:http/http.dart' as http;

class ImageGenerationRemoteDataSourceImpl
    implements ImageGenerationRemoteDataSource {
  final http.Client httpClient;

  ImageGenerationRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<ImageGenerationModel> getGenerateImages(String query) async {
    const String endPointVal = "images/generations";

    // ['256x256', '512x512', '1024x1024']
    Map<String, dynamic> rowParams = {
      "n": 10,
      "size": "256x256",
      "prompt": query,
    };

    final encodedParams = json.encode(rowParams);

    final response = await httpClient.post(
      Uri.parse(endPoint(endPointVal)),
      body: encodedParams,
      headers: headerBearerOption(OPEN_AI_KEY),
    );
    //Local server for testing use plugin "Live Server" in vscode and open the project files
    //The API response folder will act as backend server

    // final response = await httpClient.get(Uri.parse(
    //     'http://127.0.0.1:5500/api_response/image_generation_response.json'));

    if (response.statusCode == 200) {
      return ImageGenerationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: "Image Generation Server Exception");
    }
  }
}
