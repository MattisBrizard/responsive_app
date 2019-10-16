import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:responsive_app/models/random_image.dart';
import 'package:responsive_app/modules/images/images_events.dart';
import 'package:responsive_app/modules/images/images_state.dart';
import 'package:responsive_app/repository/image_repository.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc({@required this.imageRepository});

  final ImageRepository imageRepository;

  @override
  ImagesState get initialState => ImagesInitial();

  @override
  Stream<ImagesState> mapEventToState(ImagesEvent event) async* {
    if (event is FetchImages) {
      try {
        yield ImagesLoading();
        final List<RandomImage> images =
            await imageRepository.getRandomImages();
        yield ImagesLoaded(images);
      } catch (e) {
        yield const ImagesError('Error fetching images');
      }
    }
  }
}
