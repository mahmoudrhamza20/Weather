import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_states.dart';
import 'package:weather_app/services/weather_service.dart';
import '../../models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherStates>{
  WeatherCubit(this.weatherService) : super(WeatherInitialState());

  WeatherService weatherService;
  WeatherModel? weatherModel;
  String? cityName ;

 static WeatherCubit get(context)=> BlocProvider.of(context);

 void getWeather({required String cityName})async{
   emit(WeatherLoadingState());
   try {
     weatherModel =  await weatherService.getWeather(cityName: cityName);
     emit(WeatherSuccessState());
   }on Exception catch (e) {
     emit(WeatherErrorState());
   }
 }

}