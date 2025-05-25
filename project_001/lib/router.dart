import 'package:auto_route/auto_route.dart';
import 'package:advanced_notes_app/main.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MyHomePageRoute.page,
          initial: true,
          path: '/',
          title: (context, data) => 'Flutter Demo Home Page',
        ),
        // Add other routes later
      ];
}

class MyHomePageRoute {
  static var page = PageInfo('MyHomePageRoute', builder: (RouteData data) {
    return MyHomePage();
  });
}
