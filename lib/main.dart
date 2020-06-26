import 'package:flutter/material.dart';
import 'package:flutter_carros/pages/favoritos/favoritos_model.dart';
import 'package:flutter_carros/pages/splash_page.dart';
import 'package:flutter_carros/utils/event_bus.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventBus>(
          create: (context) => EventBus(),
          dispose: (context, bus) => bus.dispose(),
        ),
        ChangeNotifierProvider<FavoritosModel>(
          create: (context) => FavoritosModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white),
        home: SplashPage(),
      ),
    );
  }
}
