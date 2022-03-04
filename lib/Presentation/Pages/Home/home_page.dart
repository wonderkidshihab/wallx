import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallx/Presentation/Controllers/image_controller_controller.dart';
import 'package:wallx/Presentation/Pages/ImageView/image_view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.put(ImageController());
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getInitialData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.currentPage++;
        controller.getImagesPaginated();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                ),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(ImageViewPage(image: controller.images[index]));
                    },
                    child: Hero(
                      tag: controller.images[index].id,
                      child: ExtendedImage.network(
                        controller.images[index].downloadUrl,
                        cache: true,
                      ),
                    ),
                  );
                },
                itemCount: controller.images.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getInitialData() async {
    await controller.getImages();
  }
}
