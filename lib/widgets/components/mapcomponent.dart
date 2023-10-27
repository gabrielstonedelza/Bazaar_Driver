import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../../controllers/mapcontroller.dart';
import '../../controllers/ordercontroller.dart';
import '../../statics/appcolors.dart';

class MapComponent extends StatefulWidget {
  final cLat;
  final cLng;
  final orderItem;
  final orderingUser;
  const MapComponent(
      {super.key,
      required this.cLat,
      required this.cLng,
      required this.orderItem,
      required this.orderingUser});

  @override
  State<MapComponent> createState() => _MapComponentState(
      cLat: this.cLat,
      cLng: this.cLng,
      orderItem: this.orderItem,
      orderingUser: this.orderingUser);
}

class _MapComponentState extends State<MapComponent> {
  final cLat;
  final cLng;
  final orderItem;
  final orderingUser;
  _MapComponentState(
      {required this.cLat,
      required this.cLng,
      required this.orderItem,
      required this.orderingUser});
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller = Completer();
  final OrderController orderController = Get.find();
  LocationData? currentLocation;
  late Timer _timer;

  final storage = GetStorage();
  late String uToken = "";

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 13.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!))));
      setState(() {});
    });
  }

  List<LatLng> polylineCoordinates = [];

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCyv9qw9JGcXcmiHXULDAIcKHyAtIq8x1M",
        PointLatLng(_mapController.userLatitude, _mapController.userLongitude),
        PointLatLng(double.parse(cLat), double.parse(cLng)));

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  final MapController _mapController = Get.find();

  @override
  void initState() {
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    getCurrentLocation();
    getPolyPoints();
    scheduleTimers();
    super.initState();
  }

  void scheduleTimers() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      orderController.addDriversCurrentLocation(
          uToken,
          orderItem,
          orderingUser,
          _mapController.userLatitude.toString(),
          _mapController.userLongitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Delivering Order"),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  color: defaultTextColor2),
            )),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                _mapController.userLatitude, _mapController.userLongitude),
            zoom: 15.0,
          ),
          polylines: {
            Polyline(
                polylineId: const PolylineId("route"),
                points: polylineCoordinates,
                width: 6,
                color: newButton)
          },
          markers: {
            Marker(
                markerId: const MarkerId("Source"),
                position: LatLng(
                    _mapController.userLatitude, _mapController.userLongitude)),
            Marker(
                markerId: const MarkerId("Destination"),
                position: LatLng(double.parse(cLat), double.parse(cLng))),
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          scrollGesturesEnabled: true,
        ));
  }
}
