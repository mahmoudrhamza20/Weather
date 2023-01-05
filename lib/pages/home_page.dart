import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import '../cubits/weather_cubit/weather_states.dart';


class HomePage extends StatelessWidget {

  WeatherModel? weatherModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>SearchPage(),)),
            icon: const Icon(Icons.search),),
        ],
        title: const Text('Weather App'),
      ),
      body:BlocBuilder<WeatherCubit,WeatherStates>(
        builder: (context, state){
          if(state is WeatherLoadingState){
            return const Center(child: CircularProgressIndicator());
          }else if(state is WeatherSuccessState){
            weatherModel = WeatherCubit.get(context).weatherModel;
            return SuccessBodyState(weatherModel: weatherModel);
          }else if(state is WeatherErrorState){
            return const Center(child: Text('Something went wrong please try again'));
          }else {
            return const InitialBodyState();
          }
        },
      ) ,
    );
  }
}

class InitialBodyState extends StatelessWidget {
  const InitialBodyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: 28,
              ),
            )
          ]
      ),
    );
  }
}

class SuccessBodyState extends StatelessWidget {
  const SuccessBodyState({Key? key, required this.weatherModel,}) : super(key: key);

  final WeatherModel? weatherModel;

  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                  colors: [
                    weatherModel!.getThemeColor(),
                    weatherModel!.getThemeColor()[300]!,
                    weatherModel!.getThemeColor()[100]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      WeatherCubit.get(context).cityName!,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'updated at : ${weatherModel!.date.hour.toString()}:${weatherModel!.date.minute.toString()}',
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(weatherModel!.getImage()),
                        Text(
                          weatherModel!.temp.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text('maxTemp :${weatherModel!.maxTemp.toInt()}'),
                            Text('minTemp : ${weatherModel!.minTemp.toInt()}'),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      weatherModel!.weatherStateName,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              );
  }
}
