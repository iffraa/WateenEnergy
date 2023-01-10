class Energy {
  String? todayRevenue;
  String? cuf;
  String? systemSize;
  String? todaysYield;
  String? activeFaults;
  String? inverterQuantity;
  String? performanceRatio;
  String? tcPerformanceRatio;
  String? totalYield;
  String? remainingPayback;
  String? irr;
  List<int>? prHourly;
  List<int>? solarHourly;
  List<List>? inverterHourly;
  String? co2Reduction;
  String? oilReduction;
  String? treesPlanted;

  Energy(
      {required this.todayRevenue,
        required this.cuf,
        required this.systemSize,
        required this.todaysYield,
        required this.activeFaults,
        required this.inverterQuantity,
        required this.performanceRatio,
        required  this.tcPerformanceRatio,
        required this.totalYield,
        required  this.remainingPayback,
        required this.irr,
        required this.prHourly,
        required  this.solarHourly,
        required  this.inverterHourly,
        required this.co2Reduction,
        required this.oilReduction,
        required this.treesPlanted});

  factory Energy.fromMap(Map<String, dynamic> json) => Energy(
    todayRevenue : json['today_revenue'],
    cuf : json['cuf'],
    systemSize : json['system_size'],
    todaysYield : json['todays_yield'],
    activeFaults : json['active_faults'],
    inverterQuantity : json['inverter_quantity'],
    performanceRatio : json['performance_ratio'],
    tcPerformanceRatio : json['tc_performance_ratio'],
    totalYield : json['total_yield'],
    remainingPayback : json['remaining_payback'],
    irr : json['irr'],
    prHourly : json['pr_hourly'].cast<int>(),
    solarHourly : json['solar_hourly'].cast<int>(),
   /* if (json['inverter_hourly'] != null) {
      inverterHourly = <List>[];
      json['inverter_hourly'].forEach((v) {
        inverterHourly!.add( InverterHourly.fromJson(v));
      });
    }
    inverterHourly = json['inverter_hourly'].cast<List>();*/
    inverterHourly:  json[json['inverter_hourly']].cast<InverterHourly>(),
    co2Reduction : json['co2_reduction'],
    oilReduction : json['oil_reduction'],
    treesPlanted : json['trees_planted']);
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today_revenue'] = this.todayRevenue;
    data['cuf'] = this.cuf;
    data['system_size'] = this.systemSize;
    data['todays_yield'] = this.todaysYield;
    data['active_faults'] = this.activeFaults;
    data['inverter_quantity'] = this.inverterQuantity;
    data['performance_ratio'] = this.performanceRatio;
    data['tc_performance_ratio'] = this.tcPerformanceRatio;
    data['total_yield'] = this.totalYield;
    data['remaining_payback'] = this.remainingPayback;
    data['irr'] = this.irr;
    data['pr_hourly'] = this.prHourly;
    data['solar_hourly'] = this.solarHourly;
    if (this.inverterHourly != null) {
      //  data['inverter_hourly'] = this.inverterHourly!.map((v) => v.toJson()).toList();
    }
    data['co2_reduction'] = this.co2Reduction;
    data['oil_reduction'] = this.oilReduction;
    data['trees_planted'] = this.treesPlanted;
    return data;
  }*/

class InverterHourly {
  List? yPoints;
  List? xPoints;

  InverterHourly({this.yPoints, this.xPoints});

  InverterHourly.fromMap(Map<String, dynamic> json) {
    yPoints = json['yPoints'];
    xPoints = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
