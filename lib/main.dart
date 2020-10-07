import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucento/providers.dart';
import 'package:lucento/ui/routers/routers.dart' as r;
import 'package:lucento/ui/utils/theme.dart';
import 'package:lucento/ui/views/root.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: RootScreen(),
        onGenerateRoute: r.Router.generateRoute,
      ),
    );
  }
}
