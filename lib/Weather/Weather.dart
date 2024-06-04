import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

// API key and URL function
const apiKey = "55259135f9589fbf8644defce5df9ef0";

String apiURL(var lat, var lon) {
  String url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}

void main() {
  runApp(MaterialApp(home: WeatherWidget()));
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late final WeatherFactory _wf;
  Weather? _weather;
  List<Weather>? _forecast;
  String _city = "Dhaka";
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _wf = WeatherFactory(apiKey);
    _fetchCurrentWeather();
  }

  Future<void> _fetchCurrentWeather() async {
    try {
      Weather weather = await _wf.currentWeatherByCityName(_city);
      setState(() {
        _weather = weather;
        _forecast = null; // Clear the forecast when fetching new weather
      });
    } catch (e) {
      setState(() {
        _weather = null;
        _forecast = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch weather data for $_city"),
      ));
    }
  }

  Future<void> _fetchForecast() async {
    try {
      List<Weather> forecast = await _wf.fiveDayForecastByCityName(_city);
      setState(() {
        _forecast = forecast;
      });
      for (var weather in forecast) {
        print(weather.date); // Debug print statement to check dates
      }
    } catch (e) {
      setState(() {
        _forecast = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch forecast data for $_city"),
      ));
    }
  }

  void _searchWeather() {
    setState(() {
      _city = _controller.text;
      _fetchCurrentWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Search City"),
                    content: TextField(
                      controller: _controller,
                      decoration:
                          const InputDecoration(hintText: "Enter city name"),
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Search"),
                        onPressed: () {
                          _searchWeather();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightBlue,
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchForecast,
        child: const Icon(Icons.cloud),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          _locationHeader(),
          _currentTemp(),
          _weatherIcon(),
          _extraInfo(),
          if (_forecast != null && _forecast!.isNotEmpty) ...[
            _forecastHeader(),
            _forecastList(),
          ],
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        _weather?.areaName ?? "",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.tealAccent,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 70,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forecastHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        "7-Day Forecast",
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _forecastList() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _forecast?.length ?? 0,
        itemBuilder: (context, index) {
          Weather weather = _forecast![index];
          return _forecastItem(weather);
        },
      ),
    );
  }

  Widget _forecastItem(Weather weather) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${weather.date?.day}/${weather.date?.month}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.network(
            "http://openweathermap.org/img/wn/${weather.weatherIcon}.png",
            scale: 1.5,
          ),
          Text(
            "${weather.temperature?.celsius?.toStringAsFixed(0)}° C",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
