import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:responsive_app/common/consts.dart';
import 'package:responsive_app/models/random_image.dart';

class ImageApiClient {
  ImageApiClient() {
    _client = http.Client();
  }
  http.Client _client;
  Future<List<RandomImage>> getRandomImages() async {
    final int random = Random().nextInt(10);
    final http.Response response =
        await _client.get('${Consts.apiUrl}/list?page=$random');

    if (response.statusCode == 200) {
      final List<RandomImage> randomImages = List<RandomImage>.from(
        json.decode(response.body).map(
              (x) => RandomImage.fromMap(x),
            ),
      );
      return randomImages;
    } else {
      throw Exception();
    }
  }
}
