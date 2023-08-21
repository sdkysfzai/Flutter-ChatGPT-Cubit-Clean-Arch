part of 'image_generation_cubit.dart';

sealed class ImageGenerationState extends Equatable {
  const ImageGenerationState();

  @override
  List<Object> get props => [];
}

final class ImageGenerationInitial extends ImageGenerationState {}

final class ImageGenerationLoading extends ImageGenerationState {}

final class ImageGenerationLoaded extends ImageGenerationState {
  final ImageGenerationModel imageGenerationModel;
  const ImageGenerationLoaded({required this.imageGenerationModel});

  @override
  List<Object> get props => [imageGenerationModel];
}

final class ImageGenerationError extends ImageGenerationState {
  final String error;
  const ImageGenerationError({required this.error});

  @override
  List<Object> get props => [error];
}
