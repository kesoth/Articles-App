import 'package:articles_app/custom_navbar.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/utils/screen_bindings.dart';
import 'package:articles_app/views/screens/authentication/login_screen.dart';
import 'package:articles_app/views/screens/authentication/signup_screen.dart';
import 'package:articles_app/views/screens/home/home_screen.dart';
import 'package:articles_app/views/screens/p1/p1article_screen.dart';
import 'package:articles_app/views/screens/p3/p3articles_screen.dart';
import 'package:articles_app/views/screens/p3/p3gallery_screen.dart';
import 'package:articles_app/views/screens/p3/p3titles_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: kLoginRoute,
          page: () => LoginScreen(),
          binding: ScreenBindings()),
      GetPage(
        name: kSignUpRoute,
        page: () =>  SignupScreen(),
      ),
      GetPage(
        name: kHomeRoute,
        page: () => const HomeScreen(),
      ),
      GetPage(
        name: kP1ArticlesRoute,
        page: () => const P1ArticleScreen(),
      ),
      GetPage(
        name: kP2ArticlesRoute,
        page: () => const P1ArticleScreen(),
      ),
      GetPage(
        name: kP3ArticlesRoute,
        page: () => const P3ArticlesScreen(),
      ),
      GetPage(
        name: kP3TitlesRoute,
        page: () => const P3TitlesScreen(),
      ),
      GetPage(
        name: kP3GalleryRoute,
        page: () => const P3GalleryScreen(),
      ),
      GetPage(
        name: kNavBar,
        page: () => const CustomNavBar(),
      ),
    ];
  }
}
