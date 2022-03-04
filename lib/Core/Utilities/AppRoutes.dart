import 'package:get/get.dart';
import 'package:wallx/Presentation/Pages/Home/home_page.dart';
import 'package:wallx/Presentation/Pages/exportpages.dart';

class AppRoutes {
  static const String INITIAL = "/";
  static const String HOME = "/home";

  static List<GetPage> routes = [
    GetPage(
      name: INITIAL,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
    ),
  ];
}
