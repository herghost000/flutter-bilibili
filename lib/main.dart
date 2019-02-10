import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'config/application.dart';
import 'router/routes.dart';
import 'util/provider.dart';

void main() async{
  final provider = new Provider();
  await provider.init(true);
  runApp(AppComponent());
}

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return new AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {

  AppComponentState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
    Application.theme = ThemeData(primarySwatch: Colors.pink, primaryColor: Colors.pink[300]);
  }

  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      theme: Application.theme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
