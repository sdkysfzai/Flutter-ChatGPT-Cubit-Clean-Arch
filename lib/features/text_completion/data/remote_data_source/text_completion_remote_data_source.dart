import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/text_completion/data/models/text_completion_model.dart';

abstract class TextCompletionRemoteDataSource {
  Future<TextCompletionModel> getTextCompletion(String query);
}
