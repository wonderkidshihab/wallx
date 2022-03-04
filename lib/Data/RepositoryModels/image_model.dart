import 'package:wallx/Core/Utilities/api_manager.dart';
import 'package:wallx/Core/Utilities/exportutilities.dart';

class ImageModel {
  ImageModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });
  late final String id;
  late final String author;
  late final int width;
  late final int height;
  late final String url;
  late final String downloadUrl;

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['author'] = author;
    _data['width'] = width;
    _data['height'] = height;
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
      final List<ImageModel> images = response
          .map<ImageModel>((image) => ImageModel.fromJson(image))
          .toList();
      return images;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
