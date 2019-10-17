import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:responsive_app/models/random_image.dart';
import 'package:responsive_app/modules/images/images_bloc.dart';
import 'package:responsive_app/modules/images/images_events.dart';
import 'package:responsive_app/modules/images/images_state.dart';
import 'package:responsive_app/repository/image_repository.dart';

class _MockImageRepository extends Mock implements ImageRepository {}

void main() {
  ImagesBloc imagesBloc;
  ImageRepository imageRepository;

  setUp(() {
    imageRepository = _MockImageRepository();
    imagesBloc = ImagesBloc(imageRepository: imageRepository);
  });
  tearDown(() => imagesBloc?.close());

  test('ImagesBloc initial state is ImagesInitial', () {
    expect(imagesBloc.initialState, ImagesInitial());
  });

  group('receive FetchImages event', () {
    test(
        'emits [ImagesInitial, ImagesLoading, ImagesLoaded] when image repository returns images',
        () {
      final RandomImage image = RandomImage(
        id: 'id',
        author: 'Author',
        height: 100,
        width: 200,
        downloadUrl: 'downloadUrl',
        url: 'url',
      );
      when(imageRepository.getRandomImages()).thenAnswer(
        (_) => Future.value([image]),
      );
      expectLater(
        imagesBloc,
        emitsInOrder([
          ImagesInitial(),
          ImagesLoading(),
          ImagesLoaded([image]),
        ]),
      );
      imagesBloc.add(FetchImages());
    });
    test(
        'emits [ImagesInitial, ImagesLoading, ImagesError] when image repository returns exception',
        () {
      when(imageRepository.getRandomImages()).thenThrow(
        (_) => Future.value(Exception()),
      );
      expectLater(
        imagesBloc,
        emitsInOrder([
          ImagesInitial(),
          ImagesLoading(),
          const ImagesError('Error fetching images'),
        ]),
      );
      imagesBloc.add(FetchImages());
    });
  });
}
