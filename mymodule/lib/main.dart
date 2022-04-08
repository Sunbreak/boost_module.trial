import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

void main() {
  CustomFlutterBinding();
  runApp(App());
}

class CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(
      routefactory,
      appBuilder: (home) {
        return MaterialApp(
          home: home,
          debugShowCheckedModeBanner: true,
          builder: (_, __) => home,
        );
      },
    );
  }

  Route<dynamic>? routefactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name];
    return func?.call(settings, uniqueId);
  }

  static Map<String, FlutterBoostRouteFactory> routerMap = {
    'flutter': (settings, uniqueId) {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('FlutterPage'),
            ),
            body: const Center(
              child: Text('Hello, Flutter'),
            ),
          );
        },
      );
    },
  };
}
