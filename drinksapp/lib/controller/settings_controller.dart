import 'package:get/get.dart';
import 'package:drinksapp/models/ingredient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingsController extends GetxController {
  Future<bool> initWithFuture() =>
      Future.delayed(Duration(seconds: 0), () async {
        return true;
      });
}
