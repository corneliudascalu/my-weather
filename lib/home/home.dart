import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/home/weather_bloc.dart';
import 'package:weather/sign_in/auth_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(), child: _HomeScreen(key: key));
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                IconButton(onPressed: null, icon: Icon(Icons.portrait)),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.home_filled,
                      size: 32,
                      color: Colors.blue,
                    )),
                IconButton(onPressed: null, icon: Icon(Icons.chat_bubble))
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("My Locations"),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutPressed());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: buildBody(context, state),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, WeatherState state) {
    if (state is LoadedLocations) {
      return ListView.builder(
        itemCount: state.locations.length,
        itemBuilder: (context, index) {
          var location = state.locations[index];
          return LimitedBox(
            maxHeight: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: ShapeDecoration(
                    color: location.weather == "sunny"
                        ? Colors.amber
                        : Colors.lightBlue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                constraints: const BoxConstraints.expand(),
                child: Center(
                  child: Text(location.weather,
                      style: const TextStyle(
                        fontSize: 24,
                      )),
                ),
              ),
            ),
          );
        },
      );
    } else {
      context.read<WeatherBloc>().add(OnGetLocationsList());
      return const Text(
        "Home sweet home",
        style: TextStyle(fontSize: 24),
      );
    }
  }
}
