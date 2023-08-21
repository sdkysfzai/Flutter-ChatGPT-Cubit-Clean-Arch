import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/data/models/image_generation_model.dart';

abstract class ImageGenerationRepository {
  Future<ImageGenerationModel> getGenerateImages(String query);
}
