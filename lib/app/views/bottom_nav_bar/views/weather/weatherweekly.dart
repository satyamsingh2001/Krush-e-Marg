import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../colors/colors_const.dart';
import '../../../../constwidgets/const_container.dart';
import '../../../../textstyles/textstyle_const.dart';
import 'controller/location_controller.dart';
import 'controller/weather_controller.dart';
import 'viewmodel/temp_conversion.dart';

class WeatherWeek extends StatefulWidget {
  const WeatherWeek({Key? key}) : super(key: key);

  @override
  State<WeatherWeek> createState() => _WeatherWeekState();
}

class _WeatherWeekState extends State<WeatherWeek> {
  final WeatherController weatherController = Get.find();
  final LocationController locationController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherController.fetchHourlyWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "Weather Forecast",
          style: AppTextStyles.kBody17SemiboldTextStyle
              .copyWith(color: AppColors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: GetBuilder<WeatherController>(builder: (weatherController) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:  NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: ListView(
              children: [
                Center(
                  child: Obx(() =>  Text(
                    locationController.currentAddress.value.split(' ').take(3).join(' '),                    // "Noida",
                    style: AppTextStyles.kHeading3TextStyle
                        .copyWith(color: AppColors.white100),
                  )),
                ),
                Center(
                  child: Text(
                    "  ${(weatherController.weatherData[0]['description'])}",
                    style: AppTextStyles.kBody15RegularTextStyle
                        .copyWith(color: AppColors.white80),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "${convertKelvinToCelsius(weatherController.mainData['temp'])}${"°C"}",
                    style: AppTextStyles.kLargeTitleTextStyle
                        .copyWith(color: AppColors.primary),
                  ),
                ),
                Image.network(
                  weatherController.iconUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(
                        // Default text style for the entire widget
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Wind : ',
                              style: AppTextStyles.kBody15RegularTextStyle
                                  .copyWith(color: AppColors.white100)),
                          TextSpan(
                            text: "${(weatherController.windData['speed'])}" "km/h",
                            style: AppTextStyles.kBody15SemiboldTextStyle
                                .copyWith(color: AppColors.white80),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        // Default text style for the entire widget
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Humidity : ',
                              style: AppTextStyles.kBody15RegularTextStyle
                                  .copyWith(color: AppColors.white100)),
                          TextSpan(
                            text: "${(weatherController.mainData['humidity'])}" "%",
                            style: AppTextStyles.kBody15SemiboldTextStyle
                                .copyWith(color: AppColors.white80),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.white40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Next 21 hr",
                    style: AppTextStyles.kBody15RegularTextStyle
                        .copyWith(color: AppColors.primary),
                  ),
                ),
                ConstantContainer(
                    height: Get.height*0.16,
                    child:Obx(() =>weatherController.hourlyWeatherList.isEmpty?const Center(child: CircularProgressIndicator(color: AppColors.primary,)): NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: weatherController.hourlyWeatherList.length,
                          itemBuilder: (context, index) {
                            final hourlyWeather = weatherController.hourlyWeatherList[index];
                            return ConstantContainer(
                              color: AppColors.white40,
                              radiusBorder: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '${hourlyWeather['time'].hour}:${hourlyWeather['time'].minute}',
                                      style: AppTextStyles.kBody15SemiboldTextStyle
                                          .copyWith(color: AppColors.white80),
                                    ),
                                    Image.network(
                                      hourlyWeather['iconUrl'],
                                      width: 50.0,
                                      height: 50.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      '${convertKelvinToCelsius(hourlyWeather['temperature'])}°C',
                                      style: AppTextStyles.kBody15RegularTextStyle
                                          .copyWith(color: AppColors.primary),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),)
                ),
                const Divider(
                  color: AppColors.white40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Next 7 days",
                      style: AppTextStyles.kBody15RegularTextStyle
                          .copyWith(color: AppColors.primary),
                    ),
                    Text(
                      "Wind (km/h)",
                      style: AppTextStyles.kBody15RegularTextStyle
                          .copyWith(color: AppColors.primary),
                    ),
                    Text(
                      "Humidity",
                      style: AppTextStyles.kBody15RegularTextStyle
                          .copyWith(color: AppColors.primary),
                    ),
                    Text(
                      "Min/Max",
                      style: AppTextStyles.kBody15RegularTextStyle
                          .copyWith(color: AppColors.primary),
                    ),

                  ],
                ),
        weatherController.hourlyWeatherList.isEmpty?Expanded(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: weatherController.dailyWeatherList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final dayOfWeek = weatherController.dailyWeatherList.keys.toList()[index];
                        final dailyWeather = weatherController.dailyWeatherList[dayOfWeek];
                        final List<String> dailyIcons = dailyWeather['icons'];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  dayOfWeek.toString().substring(0,3),
                                  style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.white80),
                                ), // Display the daily icons
                                Image.network(
                                  dailyIcons.isNotEmpty ? dailyIcons[0] : '', // Display the first icon if available
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),

                              ],
                            ),
                            Text(
                              "${'${dailyWeather['meanWind']}'.substring(0,2)}%",
                              style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.white80),
                            ),
                            Text(
                              "${'${dailyWeather['meanHumidity']}'.substring(0,2)}%",
                              style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.white80),
                            ),
                            Text(
                              '${convertKelvinToCelsius(dailyWeather['meanTemperature'])}°C',
                              style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.white80),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(color: AppColors.white50),
                        );
                      },
                    )
                ):const CircularProgressIndicator(color: AppColors.primary,)
              ],
            ),
          ),
        );
      }),
    );
  }
}