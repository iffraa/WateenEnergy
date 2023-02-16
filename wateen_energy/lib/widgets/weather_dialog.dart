import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/services/service_url.dart';
import 'package:wateen_energy/widgets/form_button.dart';
import 'package:wateen_energy/widgets/format_radio_button.dart';
import 'package:wateen_energy/widgets/week_date_picker.dart';

import '../models/forecast.dart';
import '../services/network_api.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import 'alert_button.dart';
import 'daily_date_picker.dart';
import 'dropdown.dart';
import 'item_forecast.dart';
import 'month_year_picker.dart';
import 'nav_button.dart';

class WeatherDialog extends StatefulWidget {
  final String lng;
  final String lat;

  const WeatherDialog(this.lng, this.lat);

  @override
  State<WeatherDialog> createState() => _WeatherDialogState();
}

class _WeatherDialogState extends State<WeatherDialog> {
  String selectedDate = DateTime.now().toString().split(" ")[0];
  String selectedSite = "";
  Future<Map<String, dynamic>>? futureWeather;
  Future<Map<String, dynamic>>? futureForecast;

  @override
  void initState() {
    super.initState();
    getWeather(ServiceUrl.weatherUrl);
    getWeather(ServiceUrl.forecastUrl);
  }

  @override
  Widget build(BuildContext context) {
    FormatRadioGroup.formatType = "PDF";
    AppScale _scale = AppScale(context);

    return FutureBuilder<Map<String, dynamic>>(
        future: futureForecast,
        builder: (context, forecastSnapshot) {
          if (forecastSnapshot.hasData) {
            EasyLoading.dismiss();
            return FutureBuilder<Map<String, dynamic>>(
                future: futureWeather,
                builder: (context, weatherSnapshot) {
                  if (weatherSnapshot.hasData) {
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 9.h, bottom: 9.h, left: 5.h, right: 5.h),
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                            color: AppColors.greyDropDownColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.h))),
                        //   padding: EdgeInsets.all(0.5.h),
                        child: Column(
                          children: [
                            Stack(children: [

                              Container(
                                padding: EdgeInsets.only(
                                    top: 3.5.h,
                                    left: 2.h,
                                    right: 1.h,
                                    bottom: 2.h),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/weather_bg.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 23.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      weatherSnapshot.data!['main']['temp']
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: '.SF Pro Display',
                                          color: Colors.white,
                                          fontSize: _scale.appBarHeading,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Tuesday',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: '.SF Pro Display',
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: _scale.chartHeading,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      weatherSnapshot.data!['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: '.SF Pro Display',
                                        color: Colors.white,
                                        fontSize: _scale.chartHeading,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Pakistan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: '.SF Pro Display',
                                        color: Colors.white,
                                        fontSize: _scale.chartHeading,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.fill(child:
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                      AssetImage("assets/images/cloud.png"),
                                    ),
                                  ),
                                  width: 20.h,
                                  height: 20.h,
                                ),
                              ), ),
                            ]),
                            SizedBox(
                              height: 3.h,
                            ),
                            getDaysForecast(
                                (forecastSnapshot.data!['list'] as List)
                                    .map((i) => Forecast.fromMap(i))
                                    .toList()),
                            SizedBox(
                              height: 3.h,
                            ),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(spacing: 1.h, children: [
                                  getInfoWidget(
                                      "WIND DIRECTION",
                                      weatherSnapshot.data!['wind']['deg']
                                              .toString() +
                                          " \u00B0",
                                      'assets/images/wind.png'),
                                  getInfoWidget("Solar Module Temperature",
                                      'N/A', 'assets/images/solar.png'),
                                  getInfoWidget("Global Horizontal Irradiance",
                                      'N/A', ''),
                                  getInfoWidget(
                                      "WIND VELOCITY",
                                      weatherSnapshot.data!['wind']['speed']
                                              .toString() +
                                          'KM/H',
                                      '')
                                ])),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(spacing: 1.h, children: [
                                  getTimeWidget(
                                      weatherSnapshot.data!['sys']['sunrise'],
                                      weatherSnapshot.data!['sys']['sunset']),
                                  getInfoWidget(
                                      "Ambient Temperature",
                                      weatherSnapshot.data!['main']['temp']
                                              .toString() +
                                          " \u00B0",
                                      'assets/images/solar.png'),
                                  getInfoWidget("Air Polution", 'N/A', ''),
                                ])),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  } //sc
                });
          } else {
            EasyLoading.show();
            return Container();
          }
        });
  }

  List<Forecast> getForecastData(List<Forecast>? forecastList, String hour) {
    List<Forecast> filteredList = [];
    for (int i = 0; i < forecastList!.length; i++) {
      String? dateTxt = forecastList[i].date;
      DateTime forecastDate = DateTime.parse(dateTxt!);
      print("server hour " + forecastDate.hour.toString());
      print("current hour range " + hour);
      if (forecastDate.hour.toString().contains(hour)) {
        filteredList.add(forecastList[i]);
      }
    }

    return filteredList;
  }

  List<Forecast>? getFilterList(List<Forecast>? forecastList) {
    List<Forecast> filterList = [];
    DateTime currentDate = DateTime.now();
    if (currentDate.hour >= 0 && currentDate.hour <= 2) {
      filterList = getForecastData(forecastList, 0.toString());
    } else if (currentDate.hour >= 3 && currentDate.hour <= 5) {
      filterList = getForecastData(forecastList, 3.toString());
    } else if (currentDate.hour >= 6 && currentDate.hour <= 8) {
      filterList = getForecastData(forecastList, 6.toString());
    } else if (currentDate.hour >= 9 && currentDate.hour <= 11) {
      filterList = getForecastData(forecastList, 9.toString());
    } else if (currentDate.hour >= 12 && currentDate.hour <= 14) {
      filterList = getForecastData(forecastList, 12.toString());
    } else if (currentDate.hour >= 15 && currentDate.hour <= 17) {
      filterList = getForecastData(forecastList, 15.toString());
    } else if (currentDate.hour >= 18 && currentDate.hour <= 20) {
      filterList = getForecastData(forecastList, 18.toString());
    } else if (currentDate.hour >= 21 && currentDate.hour <= 23) {
      filterList = getForecastData(forecastList, 21.toString());
    }
    print("filterList" + filterList.length.toString());
    return filterList;
  }

  Widget getDaysForecast(List<Forecast>? forecastList) {
    List<Forecast> filterList = getFilterList(forecastList)!;
    return Container(
      height: 15.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: filterList!.length,
        itemBuilder: (context, index) {
          return ForecastItem(filterList[index]);
        },
      ),
    );
  }

  Widget getInfoWidget(String lbl, String val, String asset) {
    AppScale _scale = AppScale(context);

    return Container(
      padding: EdgeInsets.all(1.h),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.darkBlue, width: 0.2.h),
          borderRadius: BorderRadius.all(Radius.circular(1.h))),
      width: 17.h,
      height: 16.h,
      child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.start,
            lbl,
            style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: _scale.chartHeading,
                fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Row(
            children: [
              Text(
                textAlign: TextAlign.center,
                val, //\u2103==C
                style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: _scale.appBarHeading,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              asset.isNotEmpty
                  ? Image.asset(
                      asset,
                      width: 3.h,
                      height: 3.h,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  String getTime(int dateTime) {
    String time = "";
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
    time = dt.hour.toString() + ":" + dt.minute.toString();
    return time;
  }

  Widget getTimeWidget(int sunriseT, int sunsetT) {
    AppScale _scale = AppScale(context);

    String sunrise = getTime(sunriseT);
    String sunset = getTime(sunsetT);

    return Container(
      padding: EdgeInsets.all(1.h),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.darkBlue, width: 0.2.h),
          borderRadius: BorderRadius.all(Radius.circular(1.h))),
      width: 17.h,
      height: 16.h,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                textAlign: TextAlign.start,
                'SUNRISE\nTIME',
                style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: _scale.chartHeading,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                textAlign: TextAlign.center,
                sunrise.toString(), //\u2103==C
                style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: _scale.appBarHeading,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Text(
                textAlign: TextAlign.start,
                'SUNSET\nTIME', //\u2103==C
                style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: _scale.chartHeading,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                textAlign: TextAlign.center,
                sunset.toString(), //\u2103==C
                style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: _scale.appBarHeading,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getWeather(String wUrl) async {
    Map<String, String> headers = {
      //   'Authorization': "Bearer " + box.read("token"),
    };

    Map<String, String> params = {
      'longitude': "24.904225493030978",
      'latitude': "66.97614030315455",
      'appid': Strings.weatherAppID,
    };

    print("lat " + widget.lat);
    print("lng " + widget.lng);

    String url = wUrl +
        'lat=' +
        widget.lng +
        '&lon=' +
        widget.lat +
        "&units=metric&appid=" +
        Strings.weatherAppID;

    try {
      if (wUrl == ServiceUrl.weatherUrl) {
        futureWeather = NetworkAPI().httpFetchWeatherData(url, null);
      } else {
        futureForecast = NetworkAPI().httpFetchWeatherData(url, null);
      }
    } catch (e) {
      Utility.showSubmitAlert(context, Strings.noRecordTxt, "", null);
    }
  }
}
