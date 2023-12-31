import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/ordercontroller.dart';
import '../../statics/appcolors.dart';
import 'orders/delivered.dart';
import 'orders/intransit.dart';
import 'orders/pending.dart';
import 'orders/assignedOrders.dart';
import 'orders/processing.dart';

class OrderComponent extends StatefulWidget {
  const OrderComponent({super.key});

  @override
  State<OrderComponent> createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Orders"),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(FontAwesomeIcons.arrowLeft,
                color: defaultTextColor2),
          )),
      body: GetBuilder<OrderController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const PendingOrder());
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag, size: 50),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Pending",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("(${controller.pendingOrders.length})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProcessingOrders());
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag, size: 50),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Processing",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("(${controller.processingOrders.length})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AssignedOrders());
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag, size: 50),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Assigned",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("(${controller.assignedOrders.length})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const DeliveredOrders());
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag, size: 50),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Delivered",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("(${controller.deliveredOrders.length})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const InTransitOrders());
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/box-truck.png",
                                  width: 50, height: 50),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("In Transit",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("(${controller.inTransitOrders.length})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Get.to(() => const DeliveredOrders());
                  //   },
                  //   child: Card(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: SizedBox(
                  //         height: 150,
                  //         width: 150,
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             // const Icon(Icons.shopping_bag, size: 50),
                  //             // const SizedBox(
                  //             //   height: 10,
                  //             // ),
                  //             // const Text("Delivered",
                  //             //     style:
                  //             //         TextStyle(fontWeight: FontWeight.bold)),
                  //             // const SizedBox(
                  //             //   height: 10,
                  //             // ),
                  //             // Text("(${controller.deliveredOrders.length})",
                  //             //     style: const TextStyle(
                  //             //         fontWeight: FontWeight.bold))
                  //           ],
                  //         ),
                  //       )),
                  // ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
