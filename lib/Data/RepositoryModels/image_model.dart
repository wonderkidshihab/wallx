import 'dart:math';

import 'package:wallx/Core/Utilities/api_manager.dart';
import 'package:wallx/Core/Utilities/exportutilities.dart';

class ImageModel {
  ImageModel({
    required this.id,
    required this.url,
    required this.downloadUrl,
  });
  late final String id;
  late final String url;
  late final String downloadUrl;

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['url'] = url;
    _data['download_url'] = downloadUrl;
    return _data;
  }

  static getImages(int currentPage) async {
    final response = await ApiManager.get(
      AppAPIs.IMAGELIST,
      params: {
        'page': currentPage,
        'limit': 10,
      },
    );
    if (response != null) {
      final List<ImageModel> images = response.map<ImageModel>((image) {
        int randomNumber = Random().nextInt(1000);
        return ImageModel.fromJson({
          "id": randomNumber.toString(),
          "url": "https://picsum.photos/id/$randomNumber/200/200",
          "download_url": "https://picsum.photos/id/$randomNumber/1000/1000"
        });
      }).toList();
      return images;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
