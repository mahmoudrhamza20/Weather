import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/pages/home_page.dart';
import 'services/weather_service.dart';

void main() {
  runApp(BlocProvider(
     create: (context) => WeatherCubit(WeatherService()),
    child: WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: WeatherCubit.get(context).weatherModel == null ? Colors.blue : WeatherCubit.get(context).weatherModel!.getThemeColor(),
      ),
      home: HomePage(),
    );
  }
}
