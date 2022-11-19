import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../../model/proyecto_Model.dart';

Future<Map<String, dynamic>> getData(url) async {
  final http.Response response = await http.get(Uri.parse(
      'https://interpretation-system-inserge.herokuapp.com/ApiQuestIA?Query=${url}'));
  final decoded = await json.decode(response.body) as Map<String, dynamic>;
  return decoded;
}

Future<Map<String, dynamic>> getFutureData(query) async {
  return await getData(query);
}

mixin Search_helper {
  static Future<Stream<List<ProyectoModel>>> read(String query) async {
    Map<String, dynamic> decoded = await getData(query);
    var Fire = FirebaseFirestore.instance;
    int count = 0;
    late Query<Map<String, dynamic>> FireWhere;
    var FireCollection = Fire.collection(decoded['Answer']['collection']);
    decoded['Answer']['campos'].forEach((key, value) {
      if (count == 0) {
        if (value['Operator'] == '=') {
          FireWhere = FireCollection.where(key, isEqualTo: value['Value']);
        } else if (value['Operator'] == '>') {
          FireWhere = FireCollection.where(key, isGreaterThan: value['Value']);
        } else if (value['Operator'] == '<') {
          FireWhere = FireCollection.where(key, isLessThan: value['Value']);
        }
        count++;
      } else {
        if (value['Operator'] == '=') {
          FireWhere = FireWhere.where(key, isEqualTo: value['Value']);
        } else if (value['Operator'] == '>') {
          FireWhere = FireWhere.where(key, isGreaterThan: value['Value']);
        } else if (value['Operator'] == '<') {
          FireWhere = FireWhere.where(key, isLessThan: value['Value']);
        }
      }
    });
    var miauWhere = await FireWhere.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ProyectoModel.fromSnapshot(e)).toList());
    return miauWhere;
  }
}
