import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/utils/utils.dart';
import '../../../../colors/colors_const.dart';
import '../../../../constwidgets/const_container.dart';
import '../../../../textstyles/textstyle_const.dart';
import 'controller/location_controller.dart';
import 'controller/weather_controller.dart';
import 'viewmodel/temp_conversion.dart';
import 'weatherweekly.dart';

class WeatherCondition extends StatefulWidget {
  const WeatherCondition({Key? key}) : super(key: key);

  @override
  State<WeatherCondition> createState() => _WeatherConditionState();
}

class _WeatherConditionState extends State<WeatherCondition> {
  final WeatherController weatherController = Get.find();
  final LocationController locationController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherController.fetchCurrentWeatherData();
    weatherController.fetchHourlyWeather();
    locationController.requestLocationPermissions();
    locationController.getCurrentLocation();

    // print(weatherController.fetchCurrentWeatherData());
    // print(locationController.getCurrentLocation);
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<WeatherController>(
      builder: (weatherController) {
        return ConstantContainer(
          color: AppColors.white20,
          borderColor: AppColors.primary,
          radiusBorder: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(() =>  Text(
                          locationController.currentAddress.value.split(',')[0].trim(),
                          // "Noida",
                          style: AppTextStyles.kBody17SemiboldTextStyle
                              .copyWith(color: AppColors.white100),
                        )),

                        // IconButton(
                        //     onPressed: () {
                        //       weatherController.fetchCurrentWeatherData();
                        //     },
                        //     icon: const Icon(
                        //       CupertinoIcons.refresh,
                        //       semanticLabel: "Refresh",
                        //       color: AppColors.primary,
                        //     )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl:weatherController.iconUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "${convertKelvinToCelsius(weatherController.mainData['temp']??0)}${"°C"}",
                          style: AppTextStyles.kBody20SemiboldTextStyle
                              .copyWith(color: AppColors.primary),
                        ),
                        Text(
                          "  ${(weatherController.weatherData.isNotEmpty ? weatherController.weatherData[0]['description'] : '')}",
                          style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.white80),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        // Default text style for the entire widget
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Wind : ',
                              style: AppTextStyles
                                  .kBody15RegularTextStyle
                                  .copyWith(color: AppColors.white100)),
                          TextSpan(
                            text:
                            "${(weatherController.windData['speed'])}"
                                "km/h",
                            style: AppTextStyles
                                .kBody15SemiboldTextStyle
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
                              style: AppTextStyles
                                  .kBody15RegularTextStyle
                                  .copyWith(color: AppColors.white100)),
                          TextSpan(
                            text:
                            "${(weatherController.mainData['humidity'])}"
                                "%",
                            style: AppTextStyles
                                .kBody15SemiboldTextStyle
                                .copyWith(color: AppColors.white80),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const WeatherWeek());
                      },
                      child: Text('Forecast -> ',
                          style: AppTextStyles.kBody15SemiboldTextStyle
                              .copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}