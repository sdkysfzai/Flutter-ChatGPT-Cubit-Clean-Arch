import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/custom_exceptions.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/text_completion/data/models/text_completion_model.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/text_completion/domain/usecase/text_completion_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'text_completion_state.dart';

class TextCompletionCubit extends Cubit<TextCompletionState> {
  final TextCompletionUseCase textCompletionUseCase;
  TextCompletionCubit({required this.textCompletionUseCase})
      : super(TextCompletionInitial());

  Future<void> textCompletion({required String query}) async {
    emit(TextCompletionLoading());
    try {
      final textCompletionModelData = await textCompletionUseCase.call(query);
      emit(TextCompletionLoaded(
          textCompletionModelData: textCompletionModelData));
    } on SocketException catch (e) {
      emit(TextCompletionFailure(errorMsg: e.message));
    } on ServerException catch (e) {
      emit(TextCompletionFailure(errorMsg: e.message));
    }
  }
}
