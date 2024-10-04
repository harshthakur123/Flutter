import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_forecast_app/additional_info_item.dart';
import 'package:weather_forecast_app/key.dart';
import 'package:weather_forecast_app/weather_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String city = 'London';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openWeatherApiKey'),
      );
      // print(res.body);
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occured!!!';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  // Build function should always be less expensive
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 1. Title
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        // 2. Actions
        actions: [
          IconButton(
            onPressed: () {
              print("Refresh");
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          // final weatherIcon = data['list'][i]['weather'][0]['main'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: const Color.fromARGB(255, 46, 40, 57),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                getWeatherIcon(currentSky),
                                size: 60,
                              ),
                              Text(
                                currentSky,
                                style: const TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // weather forecast height
                const Text(
                  "Hourly Forecast",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 1; i <= 9; i++)
                //         HourlyForecastItem(
                //           time: data['list'][i]['dt_txt']
                //               .toString()
                //               .substring(11),
                //           icon: getWeatherIcon(
                //               data['list'][i]['weather'][0]['main']),
                //           temprature:
                //               data['list'][i]['main']['temp'].toString(),
                //         ),
                //     ],
                //   ),
                // ),
                ListView.builder(
                  itemCount
                  itemBuilder: (context, index) {},
                ),
                const SizedBox(height: 20),
                // additional info
                const Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '$currentHumidity \n %',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '$currentWindSpeed \n m/s',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.speed,
                      label: 'Pressure',
                      value: '$currentPressure \n Pa',
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Getting icondata according to weather
  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny; // Sun icon for clear weather
      case 'clouds':
        return Icons.cloud; // Cloud icon for cloudy weather
      case 'rain':
        return Icons.umbrella; // Umbrella icon for rain
      case 'snow':
        return Icons.ac_unit; // Snowflake icon for snow
      case 'thunderstorm':
        return Icons.flash_on; // Lightning icon for thunderstorm
      case 'drizzle':
        return Icons.grain; // Drizzle icon
      default:
        return Icons.help; // Fallback icon
    }
  }
}
