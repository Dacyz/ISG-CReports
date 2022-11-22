import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../../model/proyecto_Model.dart';

mixin Search_helper {
  static Future<Map<String, dynamic>> getData(url) async {
    final http.Response response = await http.get(Uri.parse(
        'https://interpretation-system-inserge.herokuapp.com/ApiQuestIA?Query=${url}'));
    final decoded = await json.decode(response.body) as Map<String, dynamic>;
    return decoded;
  }

  static Future<Map<String, dynamic>> getFutureData(query) async {
    return await getData(query);
  }

  static Future<Stream<List<ProyectoModel>>> read(String query) async {
    Map<String, dynamic> decoded = await getData(query);
    int count = 0;
    late Query<Map<String, dynamic>> fireWhere;
    var fireCollection =
        FirebaseFirestore.instance.collection(decoded['Answer']['collection']);
    decoded['Answer']['campos'].forEach((key, value) {
      if (count == 0) {
        if (value['Operator'] == '=') {
          fireWhere = fireCollection.where(key, isEqualTo: value['Value']);
        } else if (value['Operator'] == '>') {
          fireWhere = fireCollection.where(key, isGreaterThan: value['Value']);
        } else if (value['Operator'] == '<') {
          fireWhere = fireCollection.where(key, isLessThan: value['Value']);
        }
        count++;
      } else {
        if (value['Operator'] == '=') {
          fireWhere = fireWhere.where(key, isEqualTo: value['Value']);
        } else if (value['Operator'] == '>') {
          fireWhere = fireWhere.where(key, isGreaterThan: value['Value']);
        } else if (value['Operator'] == '<') {
          fireWhere = fireWhere.where(key, isLessThan: value['Value']);
        }
      }
    });
    return fireWhere.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ProyectoModel.fromSnapshot(e)).toList());
    ;
  }
}
