import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../statics/appcolors.dart';
import '../screens/loginview.dart';
import '../screens/pages/mainhome.dart';

class LoginController extends GetxController {
  final client = http.Client();
  final storage = GetStorage();
  late List adminDetails = [];
  late List managersDetails = [];
  late List driversEmails = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchManagersDetails();
  }

  Future<void> fetchManagersDetails() async {
    try {
      isLoading = true;
      const profileLink = "https://f-bazaar.com/users/drivers/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        managersDetails = jsonData;
        for (var i in managersDetails) {
          if (!driversEmails.contains(i['email'])) {
            driversEmails.add(i['email']);
          }
        }

        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loginUser(String email, String password) async {
    const loginUrl = "https://f-bazaar.com/auth/token/login/";
    final myLink = Uri.parse(loginUrl);
    http.Response response = await client.post(myLink,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      final resBody = response.body;
      var jsonData = jsonDecode(resBody);
      var userToken = jsonData['auth_token'];
      if (driversEmails.contains(email)) {
        storage.write("token", userToken);
        Get.offAll(() => const MainHome());
      } else {
        Get.snackbar("Sorry 😢", "you are not a driver",
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: warning,
            colorText: defaultTextColor1);
        storage.remove("token");
      }
    } else {
      Get.snackbar("Sorry 😢", "invalid details",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: warning,
          colorText: defaultTextColor1);
      storage.remove("token");
    }
  }

  Future<void> logoutUser(String token) async {
    storage.remove("token");
    Get.offAll(() => const LoginView());
    const logoutUrl = "https://f-bazaar.com/auth/token/logout";
    final myLink = Uri.parse(logoutUrl);
    http.Response response = await http.post(myLink, headers: {
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      Get.snackbar("Success", "You were logged out",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryYellow);
      storage.remove("token");
      Get.offAll(() => const LoginView());
    }
  }
}
