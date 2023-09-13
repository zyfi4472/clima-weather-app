import 'dart:io';
import 'package:clima_weather_app/cubit/cubit/price_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screen/price_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() => {
      HttpOverrides.global = MyHttpOverrides(),
      runApp(const MyApp()),
    };

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: BlocProvider(
        create: (context) => PriceCubit(),
        child: const PriceScreen(),
      ),
    );
  }
}
