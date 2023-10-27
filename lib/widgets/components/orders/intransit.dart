import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../controllers/mapcontroller.dart';
import '../../../controllers/ordercontroller.dart';
import '../../../statics/appcolors.dart';
import '../mapcomponent.dart';

class InTransitOrders extends StatefulWidget {
  const InTransitOrders({super.key});

  @override
  State<InTransitOrders> createState() => _InTransitOrdersState();
}

class _InTransitOrdersState extends State<InTransitOrders> {
  final OrderController orderController = Get.find();
  final MapController mapController = Get.find();
  var items;

  final storage = GetStorage();
  late String uToken = "";

  @override
  void initState() {
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("In Transit Orders"),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  color: defaultTextColor2),
            )),
        body: GetBuilder<OrderController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.inTransitOrders != null
                  ? controller.inTransitOrders.length
                  : 0,
              itemBuilder: (context, index) {
                items = controller.inTransitOrders[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: items['get_item_pic'] == ""
                                  ? Image.asset("assets/images/fbazaar.png",
                                      width: 100, height: 100)
                                  : Image.network(items['get_item_pic'],
                                      width: 100, height: 100),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(items['get_username'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text(items['get_item_name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text(
                                      items['date_order_created']
                                          .toString()
                                          .split("T")
                                          .first,
                                      style: const TextStyle(
                                          color: muted,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text("₵ ${items['get_item_price']}",
                                      style: const TextStyle(
                                          color: primaryYellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text(items['delivery_method'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text(items['payment_method'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const SizedBox(height: 10),
                                  RawMaterialButton(
                                    fillColor: newButton,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    onPressed: () {
                                      Get.to(
                                        () => MapComponent(
                                          cLat:
                                              controller.inTransitOrders[index]
                                                  ['drop_off_location_lat'],
                                          cLng:
                                              controller.inTransitOrders[index]
                                                  ['drop_off_location_lng'],
                                          orderItem: controller
                                              .inTransitOrders[index]['id']
                                              .toString(),
                                          orderingUser: controller
                                              .inTransitOrders[index]['user']
                                              .toString(),
                                        ),
                                      );
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Show route to customer on map",
                                        style: TextStyle(
                                            color: defaultTextColor1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}
