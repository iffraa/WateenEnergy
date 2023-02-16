class Forecast {
  final String? date;
  final double? temp;
  final String? icon;


  Forecast({required this.date, required this.temp, required this.icon});

  factory Forecast.fromMap(Map<String, dynamic> json) => Forecast(
    date: (json['dt_txt'] != null)
        ? json['dt_txt']
        : '',
    temp: (json['main']['temp'] != null)
        ? json['main']['temp'].toDouble()
        : 0.0,
    icon:(json['weather'][0]['icon'] != null)
        ? json['weather'][0]['icon']
        : '',
  );

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['dt_txt'],
      temp: json['main']['temp'],
      icon: json['weather']['icon'] ,
    );
}}