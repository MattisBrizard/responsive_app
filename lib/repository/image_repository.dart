import 'package:meta/meta.dart';
import 'package:responsive_app/api/image_api_client.dart';
import 'package:responsive_app/models/random_image.dart';

class ImageRepository {
  ImageRepository({@required this.client});
  final ImageApiClient client;

  Future<List<RandomImage>> getRandomImages() async {
    return client.getRandomImages();
  }
}
