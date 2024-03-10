class RealTimeWeatherDetail {
  DateTime time;
  String location;
  double temperature;
  int humidity;
  double windSpeed;
  int weatherCode;

  RealTimeWeatherDetail({
      required this.time,
      required this.windSpeed,
      required this.temperature,
      required this.humidity,
      required this.location,
      required this.weatherCode
      });
}
