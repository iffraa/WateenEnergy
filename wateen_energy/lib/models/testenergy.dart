import 'dart:ui';

import '../utils/user_table.dart';

class ChartDataP {
  ChartDataP(this.x, this.y);
  final String x;
  final num y;
}

class EnergyData {
  EnergyData(this.x, this.y);
  final String x;
  final String y;
}

class TestData {
  TestData(this.x,  this.y,this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}

class SiteAlamrs {
  SiteAlamrs(this.x,  this.y1,this.y2, this.y3);
  final String x;
  final int y1;
  final int y2;
  final int y3;
}

class CityData {
  CityData(this.x, this.y);
  final String x;
  final int y;
}


class KPIData {
  KPIData(this.x,  this.y1, this.y2);
  final String x;
  final double? y1;
  final double? y2;
}

class InverterHourlyData {
  InverterHourlyData(this.x,  this.y1, this.y2);
  final String x;
  final double? y1;
  final double? y2;
}

class SolarData {
  SolarData(this.x,  this.y1, this.y2,this.y3, this.y4);
  final String x;
  final double? y1;
  final int y2;
  final int y3;
  final int y4;
}

class ChartDataE {
  ChartDataE(this.x, this.y, this.y1, this.y2, this.y3);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
  final double? y3;
}

class ChartDataPie {
  ChartDataPie(this.x, this.y,  this.color);
  final String x;
  final double y;
  final Color color;
}

class MountData {
  MountData(this.x, this.y,  this.color);
  final String x;
  final int y;
  final Color color;
}

class TestEnergy {
  int memberEventId;
  int id;
  int noOfAttendee;
  //VenusEvent? memberEvent;
  //List<Attendee> attendees;

  TestEnergy(
      {required this.noOfAttendee,
      required this.memberEventId,
      required this.id,
      //required this.memberEvent,
      //required this.attendees
      });

  factory TestEnergy.fromJson(Map<String, dynamic> json) {
    return TestEnergy(
        id: json[UserTableKeys.id],
        noOfAttendee: json[''],
        memberEventId: json[''],
     /*   attendees: List<Attendee>.from(
            json[UserTableKeys.allAttendees].map((x) => Attendee.fromMap(x))),
        memberEvent: json[UserTableKeys.memberEvent] == null ? [] : json[UserTableKeys.memberEvent].cast<VenusEvent>()*/
        );

  }

  factory TestEnergy.fromMap(Map<String, dynamic> json) => TestEnergy(
        id: (json[UserTableKeys.idNo] != null) ? json[UserTableKeys.idNo] : 0,
        memberEventId: (json[''] != null)
            ? json['']
            : 0,
        noOfAttendee: (json[''] != null)
            ? json['']
            : 0,
  /*  memberEvent: json[UserTableKeys.memberEvent] == null ? null : VenusEvent.fromMap(json[UserTableKeys.memberEvent]),
        attendees: List<Attendee>.from(
            json[UserTableKeys.allAttendees].map((x) => Attendee.fromMap(x))),*/
      );
}

//VenusEvent.fromMap(json[UserTableKeys.memberEvent])