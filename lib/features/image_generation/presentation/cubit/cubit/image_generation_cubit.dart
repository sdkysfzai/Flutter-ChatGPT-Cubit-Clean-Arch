import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/custom_exceptions.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/data/models/image_generation_model.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/domain/usecase/image_generation_usecase.dart';

part 'image_generation_state.dart';

class ImageGenerationCubit extends Cubit<ImageGenerationState> {
  final ImageGenerationUseCase imageGenerationUseCase;
  ImageGenerationCubit({required this.imageGenerationUseCase})
      : super(ImageGenerationInitial());

  Future<void> generateImage(String query) async {
    emit(ImageGenerationLoading());
    try {
      final imageGenerationData = await imageGenerationUseCase.call(query);
      emit(ImageGenerationLoaded(imageGenerationModel: imageGenerationData));
    } on SocketException catch (e) {
      emit(ImageGenerationError(error: e.toString()));
    } on ServerException catch (e) {
      emit(ImageGenerationError(error: e.toString()));
    }
  }
}
