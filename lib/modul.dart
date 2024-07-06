import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Uny>> getPostById() async {
  http.Response futurepost = await http
      .get(Uri.parse("http://universities.hipolabs.com/search?country=Egypt"));
  if (futurepost.statusCode == 200) {
    List data = jsonDecode(futurepost.body);

    List<Uny> allusr = [];
    for (var u in data) {
      Uny usarsroll = Uny.fromJson(u);
      allusr.add(usarsroll);
    }

    return allusr;
  } else {
    return throw Exception('انقطع الاتصال');
  }
}

class Uny {
  var webpages;
  var name;

  Uny({
    this.webpages,
    this.name,
  });

  factory Uny.fromJson(Map<String, dynamic> json) {
    return Uny(
      webpages: json["web_pages"],
      name: json["name"],
    );
  }
}
