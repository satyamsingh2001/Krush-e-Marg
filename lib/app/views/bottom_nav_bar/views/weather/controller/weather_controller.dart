import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/views/weather/controller/location_controller.dart';

const String apiKey = '8f3fea103035e0d8ec6058593eb444f4';
const String currentWeatherBaseUrl =
    "https://api.openweathermap.org/data/2.5/weather";
const String hourlyWeatherBaseUrl =
    "https://api.openweathermap.org/data/2.5/forecast";

class WeatherController extends GetxController {
  late RxMap mainData = {}.obs;
  RxList weatherData = [].obs;
  RxMap windData = {}.obs;
  String iconUrl = '';
  var hourlyWeatherList = [].obs;
  var dailyWeatherList = {}.obs;

  final LocationController locationController = Get.put(LocationController());

  String get currentCity => locationController.currentAddress.value;

  String get currentWeatherUrl =>
      "$currentWeatherBaseUrl?q=noida&appid=$apiKey";

  String get hourlyWeatherUrl =>
      "$hourlyWeatherBaseUrl?q=$currentCity&appid=$apiKey";

  Future<void> fetchCurrentWeatherData() async {
    try {
      final response = await http.get(Uri.parse(currentWeatherUrl));


      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        mainData.value = data['main'];
        weatherData.value = data['weather'];
        windData.value = data['wind'];
        final iconCode = data['weather'][0]['icon'];
        iconUrl = getWeatherIconUrl(iconCode);
        print(currentCity.split(',')[0].trim(),);
        print("Shrinet");
        update();
      } else {

        print("currentCity");
        print("Singh");
        Get.rawSnackbar(
          messageText: Text('Failed to load data: ${response.statusCode}'),
          borderRadius: 8.0,
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(bottom: 20.0),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle network or other exceptions here
    }
  }

  String getWeatherIconUrl(String iconCode) {
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode.png';
    return iconUrl;
  }

  Future<void> fetchHourlyWeather() async {
    try {
      final response = await http.get(Uri.parse(hourlyWeatherUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        hourlyWeatherList.assignAll((data['list'] as List).map((hourlyData) {
          final DateTime time =
          DateTime.fromMillisecondsSinceEpoch(hourlyData['dt'] * 1000);
          final double temperature = hourlyData['main']['temp'].toDouble();
          final double humidity = hourlyData['main']['humidity'].toDouble();
          final String windSpeed = hourlyData['wind'][0].toDouble();
          final String iconCode = hourlyData['weather'][0]['icon'];
          final String iconUrl = getWeatherIconUrl(iconCode);

          return {
            'time': time,
            'temperature': temperature,
            'humidity': humidity,
            'wind': windSpeed,
            'iconUrl': iconUrl,
          };
        }).toList());
        calculateDailyWeather();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  void calculateDailyWeather() {
    dailyWeatherList.clear();

    for (var hourlyWeather in hourlyWeatherList) {
      final DateTime time = hourlyWeather['time'];
      final String dayOfWeek = DateFormat('EEEE').format(time);

      if (!dailyWeatherList.containsKey(dayOfWeek)) {
        dailyWeatherList[dayOfWeek] = {
          'meanTemperature': 0.0,
          'meanHumidity': 0.0,
          'meanWind': 0.0,
          'icons': <String>[],
          'count': 0,
        };
      }

      dailyWeatherList[dayOfWeek]['count']++;
      dailyWeatherList[dayOfWeek]['meanTemperature'] +=
      hourlyWeather['temperature'];
      dailyWeatherList[dayOfWeek]['meanHumidity'] += hourlyWeather['humidity'];
      dailyWeatherList[dayOfWeek]['meanWind'] += hourlyWeather['wind'];
      dailyWeatherList[dayOfWeek]['icons'].add(hourlyWeather['iconUrl']);
    }

    dailyWeatherList.forEach((dayOfWeek, data) {
      final double meanTemp = data['meanTemperature'] / data['count'];
      final double meanHumidity = data['meanHumidity'] / data['count'];
      dailyWeatherList[dayOfWeek]['meanTemperature'] = meanTemp;
      dailyWeatherList[dayOfWeek]['meanHumidity'] = meanHumidity;
    });

    update();
  }
}
