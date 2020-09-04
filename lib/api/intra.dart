import 'package:http/http.dart' as http;
import 'dart:convert';

class EndPoint {
  static String all = '/?format=json';
  static String alert = '/notification/alert?format=json';
  static String message = '/notification/message?format=json';
  static String notes = '/notes?format=json';
  static String missed = '/notification/missed?format=json';
  static String nextRdv = '/notification/coming?format=json';
}

enum endPoint {
  all,
  alert,
  message,
  notes,
  missed,
  nextRdv,
}

extension endPointExt on endPoint {
  static const names = {
    endPoint.all: '/?format=json',
    endPoint.alert: '/notification/alert?format=json',
    endPoint.message: '/notification/message?format=json',
    endPoint.notes: '/notes?format=json',
    endPoint.missed: '/notification/missed?format=json',
    endPoint.nextRdv: '/notification/coming?format=json',
  };

  String get value => names[this];
}

class EpitechUser {
  final String credits;
  final String gpa;
  final String year;
  final String name;
  final String cycle;
  final String studentyear;
  final bool isAdmin;
  EpitechUser(
      {this.name,
      this.credits,
      this.gpa,
      this.year,
      this.cycle,
      this.studentyear,
      this.isAdmin});

  factory EpitechUser.fromJson(Map<String, dynamic> json) {
    return (EpitechUser(
      name: json['title'].toString(),
      credits: json['credits'].toString(),
      gpa: json['gpa'][0]['gpa'].toString(),
      year: json['scolaryear'].toString(),
      cycle: json['gpa'][0]['cycle'].toString(),
      studentyear: json['studentyear'].toString(),
      isAdmin: json['admin'],
    ));
  }
}

Future<EpitechUser> getInfos(String login, String mail) async {
  if (login != null && mail != null) {
    final response = await http.get('$login/user/$mail${EndPoint.all}');
    if (response.statusCode == 200) {
      return EpitechUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load personal data');
    }
  } else {
    EpitechUser(gpa: '0', credits: '0', year: '0', cycle: 'bachelor');
  }
}
