import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:wallx/Core/Utilities/api_manager.dart';
import 'package:wallx/Data/RepositoryModels/image_model.dart';

class ImageViewPage extends StatefulWidget {
  final ImageModel image;
  const ImageViewPage({Key? key, required this.image}) : super(key: key);

  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  String? filepath;

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: widget.image.id,
                  child: ExtendedImage.network(
                    widget.image.downloadUrl,
                    fit: BoxFit.contain,
                    cache: true,
                    mode: ExtendedImageMode.gesture,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                  filepath != null
                      ? IconButton(
                          icon: Icon(Icons.wallpaper),
                          onPressed: () async {
                            await Get.defaultDialog(
                              title: 'WallX',
                              titlePadding: EdgeInsets.all(20),
                              content: Text(
                                'Do you want to set this image as wallpaper?',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () async {
                                    int location = WallpaperManager.BOTH_SCREEN;
                                    bool result = await WallpaperManager
                                        .setWallpaperFromFile(
                                      filepath!,
                                      location,
                                    );
                                    Get.back();
                                    Get.snackbar(
                                      'WallX',
                                      result
                                          ? 'Wallpaper set successfully'
                                          : 'Error setting wallpaper',
                                    );
                                  },
                                ),
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () => Get.back(),
                                ),
                              ],
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getImage() async {
    filepath = await ApiManager.getImageFile(widget.image.downloadUrl);
    setState(() {});
  }
}
