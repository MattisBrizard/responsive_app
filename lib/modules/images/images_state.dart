import 'package:equatable/equatable.dart';
import 'package:responsive_app/models/random_image.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();
}

class ImagesInitial extends ImagesState {
  @override
  List<Object> get props => [];
}

class ImagesLoading extends ImagesState {
  @override
  List<Object> get props => [];
}

class ImagesLoaded extends ImagesState {
  const ImagesLoaded(this.images);
  final List<RandomImage> images;

  @override
  List<Object> get props => [images];
}

class ImagesError extends ImagesState {
  const ImagesError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
