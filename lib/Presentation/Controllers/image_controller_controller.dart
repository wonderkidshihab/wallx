import 'package:get/get.dart';
import 'package:wallx/Data/RepositoryModels/image_model.dart';

class ImageController extends GetxController {
  RxList<ImageModel> images = <ImageModel>[].obs;
  int currentPage = 0;

  getImages() async {
    images.clear();
    currentPage = 1;
    images.addAll(await ImageModel.getImages(currentPage));
    update();
  }

  getImagesPaginated() async {
    images.addAll(await ImageModel.getImages(currentPage));
    update();
  }
}
