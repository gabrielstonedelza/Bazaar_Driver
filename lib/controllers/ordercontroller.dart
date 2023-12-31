import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../screens/pages/mainhome.dart';
import '../statics/appcolors.dart';

class OrderController extends GetxController {
  bool isLoading = true;
  late List allMyDeliveredOrders = [];
  late List pendingOrders = [];
  late List deliveredOrders = [];
  late List processingOrders = [];
  late List assignedOrders = [];
  late List inTransitOrders = [];

  Future<void> getAllMyDeliveredOrders(String token) async {
    const profileLink = "https://f-bazaar.com/order/get_my_delivered_order/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      allMyDeliveredOrders.assignAll(jsonData);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllPendingOrders(String token) async {
    const profileLink = "https://f-bazaar.com/order/pending_orders/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      pendingOrders.assignAll(jsonData);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllInTransitOrders(String token) async {
    const profileLink = "https://f-bazaar.com/order/get_all_in_transit_orders/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      inTransitOrders.assignAll(jsonData);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllProcessingOrders(String token) async {
    const profileLink = "https://f-bazaar.com/order/processing_orders/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      processingOrders.assignAll(jsonData);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllMyAssignedOrders(String token) async {
    const profileLink =
        "https://f-bazaar.com/order/get_all_drivers_assigned_orders/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      assignedOrders.assignAll(jsonData);

      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllDeliveredOrders(String token) async {
    const profileLink = "https://f-bazaar.com/order/delivered_orders/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      deliveredOrders.assignAll(jsonData);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> updateOrderToProcessing(
      String id,
      String token,
      String cartId,
      String quantity,
      String price,
      String category,
      String size,
      String paymentMethod,
      String dropOffLat,
      String dropOffLng,
      String deliveryMethod,
      String unCode) async {
    final requestUrl = "https://f-bazaar.com/order/order/$id/update/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "cart": cartId,
      "quantity": quantity,
      "category": category,
      "size": size,
      "payment_method": paymentMethod,
      "delivery_method": deliveryMethod,
      "drop_off_location_lat": dropOffLat,
      "drop_off_location_lng": dropOffLng,
      "price": price,
      "ordered": "True",
      "order_status": "Processing",
      "unique_order_code": unCode,
    });
    if (response.statusCode == 200) {
      clearOrder(token, id);
      Get.snackbar("Hurray 😀", "order moved to processing",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.TOP,
          backgroundColor: newDefault,
          duration: const Duration(seconds: 5));

      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

  Future<void> updateOrderToPickedUp(
      String id,
      String token,
      String cartId,
      String quantity,
      String price,
      String category,
      String size,
      String paymentMethod,
      String dropOffLat,
      String dropOffLng,
      String deliveryMethod,
      String unCode) async {
    final requestUrl = "https://f-bazaar.com/order/order/$id/update/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "cart": cartId,
      "quantity": quantity,
      "category": category,
      "size": size,
      "payment_method": paymentMethod,
      "delivery_method": deliveryMethod,
      "drop_off_location_lat": dropOffLat,
      "drop_off_location_lng": dropOffLng,
      "price": price,
      "ordered": "True",
      "order_status": "Picked Up",
      "unique_order_code": unCode,
    });
    if (response.statusCode == 200) {
      Get.snackbar("Hurray 😀", "order moved to picked up",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.TOP,
          backgroundColor: newDefault,
          duration: const Duration(seconds: 5));

      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

  Future<void> updateOrderToDelivered(
      String id,
      String token,
      String cartId,
      String quantity,
      String price,
      String category,
      String size,
      String paymentMethod,
      String dropOffLat,
      String dropOffLng,
      String deliveryMethod,
      String unCode) async {
    final requestUrl = "https://f-bazaar.com/order/order/$id/update/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "cart": cartId,
      "quantity": quantity,
      "category": category,
      "size": size,
      "payment_method": paymentMethod,
      "delivery_method": deliveryMethod,
      "drop_off_location_lat": dropOffLat,
      "drop_off_location_lng": dropOffLng,
      "price": price,
      "ordered": "True",
      "order_status": "Delivered",
      "unique_order_code": unCode,
    });
    if (response.statusCode == 200) {
      Get.snackbar("Hurray 😀", "order moved to delivered",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.TOP,
          backgroundColor: newDefault,
          duration: const Duration(seconds: 5));

      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

  Future<void> updateOrderToInTransit(
      String id,
      String token,
      String cartId,
      String quantity,
      String price,
      String category,
      String size,
      String paymentMethod,
      String dropOffLat,
      String dropOffLng,
      String deliveryMethod,
      String unCode,
      String orderingUser,
      String driversLat,
      String driversLng) async {
    final requestUrl = "https://f-bazaar.com/order/order/$id/update/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "cart": cartId,
      "quantity": quantity,
      "category": category,
      "size": size,
      "payment_method": paymentMethod,
      "delivery_method": deliveryMethod,
      "drop_off_location_lat": dropOffLat,
      "drop_off_location_lng": dropOffLng,
      "price": price,
      "ordered": "True",
      "order_status": "In Transit",
      "unique_order_code": unCode,
    });
    if (response.statusCode == 200) {
      addDriversCurrentLocation(
          token, id, orderingUser, driversLat, driversLng);
      Get.snackbar("Hurray 😀", "order moved to In-Transit",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.TOP,
          backgroundColor: newDefault,
          duration: const Duration(seconds: 5));

      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

//   add to items cleared
  Future<void> clearOrder(
    String token,
    String orderItem,
  ) async {
    const requestUrl = "https://f-bazaar.com/order/clear_order/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
    }, body: {
      "order_item": orderItem,
    });
    if (response.statusCode == 201) {
      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

  Future<void> addToPickedUpOrders(
    String token,
    String orderItem,
  ) async {
    const requestUrl = "https://f-bazaar.com/order/add_to_picked_up_orders/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "order_item": orderItem,
    });
    if (response.statusCode == 201) {
      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

  Future<void> addToDeliveredOrders(
    String token,
    String orderItem,
  ) async {
    const requestUrl = "https://f-bazaar.com/order/add_to_dropped_off_orders/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "order_item": orderItem,
    });
    if (response.statusCode == 201) {
      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

  Future<void> addToInTransit(String token, String orderItem) async {
    const requestUrl = "https://f-bazaar.com/order/add_order_to_in_transit/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "order_item": orderItem,
    });
    if (response.statusCode == 201) {
      update();
    } else {
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }

  Future<void> addDriversCurrentLocation(String token, String orderItem,
      String orderingUser, String driversLat, String driversLng) async {
    final requestUrl =
        "https://f-bazaar.com/order/add_drivers_current_location/$orderItem/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $token"
    }, body: {
      "order_item": orderItem,
      "user": orderingUser,
      "drivers_lat": driversLat,
      "drivers_lng": driversLng,
    });
    if (response.statusCode == 201) {
      update();
    } else {
      print(response.body);
      Get.snackbar(
        "Order Error",
        "Something went wrong",
        duration: const Duration(seconds: 5),
        colorText: defaultTextColor1,
        backgroundColor: warning,
      );
    }
  }
}
