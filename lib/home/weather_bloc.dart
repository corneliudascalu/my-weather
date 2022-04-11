import 'package:flutter_bloc/flutter_bloc.dart';

class Location {
  String weather = "cloudy";

  Location({this.weather = "cloudy"});

  @override
  String toString() {
    return weather;
  }
}

abstract class WeatherState {}

class SampleState extends WeatherState {
  List<Location> locations = List.empty();

  SampleState({required this.locations});
}

class LoadedLocations extends WeatherState {
  List<Location> locations = List.empty();

  LoadedLocations({required this.locations});
}

abstract class WeatherEvent {}

class OnGetLocationsList extends WeatherEvent {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(SampleState(locations: List.of({Location()}))) {
    on<OnGetLocationsList>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      emit(LoadedLocations(
          locations: List.of({
        Location(weather: "sunny"),
        Location(weather: "cloudy"),
        Location(weather: "cloudy"),
        Location(weather: "cloudy"),
      })));
    });
  }
}
