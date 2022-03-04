import 'package:get/get.dart';
import 'package:wallx/Presentation/Pages/exportpages.dart';

class AppRoutes {
  static const String INITIAL = "/";

  static List<GetPage> routes = [
    GetPage(
      name: INITIAL,
      page: () => SplashScreen(),
    ),
  ];
}
