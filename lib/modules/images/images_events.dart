import 'package:equatable/equatable.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();
}

class FetchImages extends ImagesEvent {
  @override
  List<Object> get props => [];
}
