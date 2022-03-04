import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallx/Core/Utilities/AppConstrains.dart';
import 'package:wallx/Data/RepositoryModels/image_model.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "assets/images/preview.png",
                      height: 40,
                      width: 40,
                    ),
                  ),
                  AppConstrains.width10,
                  Text(
                    "WallX",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: () => ImageModel.getImages(1),
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() =>
                              ImageViewPage(image: controller.images[index]));
                        },
                        child: Hero(
                          tag: controller.images[index].id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ExtendedImage.network(
                              controller.images[index].url,
                              cache: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.images.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getInitialData() async {
    await controller.getImages();
  }
}
