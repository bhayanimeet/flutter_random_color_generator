import 'dart:convert';
import 'package:color_palette_generator_app/models/json_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class JsonController extends GetxController {
  JsonModel jsonModel = JsonModel(
    res: [].obs,
    i1: 14.obs,
  );

  void fetchData() async {
    String response = await rootBundle.loadString('assets/json/color.json');
    List data = jsonDecode(response);

    jsonModel.res.value = data;
  }
}