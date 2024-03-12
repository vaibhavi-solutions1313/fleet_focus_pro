import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app/modules/driver/controllers/driver_controller.dart';

class MapDriversView extends StatefulWidget {
  final bool? isHome;
  const MapDriversView({super.key, this.isHome = false});

  @override
  State<MapDriversView> createState() => _MapDriversViewState();
}

class _MapDriversViewState extends State<MapDriversView> {
  final Set<Marker> _markers = new Set();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  GoogleMapController? mapControl;
  final driverControl = Get.find<DriverController>();
  late Uint8List customMarkerImageBytes;
  Timer? timer;

  // CUSTOM MARKET SETUP
  Future<void> loadCustomMarkerImage() async {
    final ByteData data = await rootBundle.load('assets/box-truck.png');
    customMarkerImageBytes = data.buffer.asUint8List();
  }

  // ADD MARKERS TO GOOGLE MAP.
  void addDriverMarkers() async {
    if (driverControl.driverList.isNotEmpty) {
      await loadCustomMarkerImage();
      driverControl.driverList.value.forEach((element) async {
        if (element['lat'] != null) {
          _markers.add(
            Marker(
              icon: BitmapDescriptor.fromBytes(customMarkerImageBytes),
              markerId: MarkerId(element['user_name'].toString()),
              position: LatLng(
                double.parse(element['lat'].toString()),
                double.parse(
                  element['long'].toString(),
                ),
              ),
              infoWindow: InfoWindow(title: element['user_name'], snippet: 'Mobile : ' + element['mobile_number']),
            ),
          );
        } else {
          _markers.add(
            Marker(
              icon: BitmapDescriptor.fromBytes(customMarkerImageBytes),
              markerId: MarkerId(element['user_name'].toString()),
              position: const LatLng(37.43296265331129, -122.08832357078792),
              infoWindow: InfoWindow(title: element['user_name'], snippet: 'Mobile : ' + element['mobile_number']),
            ),
          );
        }
      });
      setState(() {});
      Future.delayed(const Duration(milliseconds: 1000), () {
        zoomToFitMarkers(_markers, mapControl!);
      });
    }
  }

  // PART OF CAMERA ZOOM LEVEL.
  Future<void> zoomToFitMarkers(Set<Marker> markers, GoogleMapController controller) async {
    try {
      final bounds = calculateMarkersBounds(markers);

      if (bounds != null) {
        final cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50.0); // 50.0 is padding
        await controller.animateCamera(cameraUpdate);
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  // OVERALL CAMERA ZOOM LEVELS AND ANIMATE CAMERA
  LatLngBounds calculateMarkersBounds(Set<Marker> markers) {
    double minLat = 90.0;
    double maxLat = -90.0;
    double minLng = 180.0;
    double maxLng = -180.0;

    for (Marker marker in markers) {
      final lat = marker.position.latitude;
      final lng = marker.position.longitude;

      minLat = math.min(minLat, lat);
      maxLat = math.max(maxLat, lat);
      minLng = math.min(minLng, lng);
      maxLng = math.max(maxLng, lng);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  // GET DRIVERS EVERY 10 SECONDS
  void getDrivers() async {
    if (widget.isHome == false) {
      const oneSec = Duration(seconds: 10);
      timer = Timer.periodic(oneSec, (Timer t) async {
        await driverControl.getDriverLists().then((value) {
          addDriverMarkers();
        });
      });
    } else {
      await driverControl.getDriverLists().then((value) {
        addDriverMarkers();
      });
    }
  }

  @override
  void initState() {
    addDriverMarkers(); // GET MARKER FOR THE FIRST TIME
    getDrivers(); // GET DRIVERS EVERY 10 SECONDS.
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    if (widget.isHome == false) {
      timer!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(widget.isHome == true ? 0 : 8.0.sp),
            child: GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              mapType: MapType.normal,
              compassEnabled: false,
              markers: _markers,
              initialCameraPosition: const CameraPosition(target: LatLng(325.2744, 133.7751), zoom: 16),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapControl = controller;
              },
            ),
          ),
          widget.isHome == false
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    top: true,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },icon: Icon(Icons.arrow_back_ios_new, size: 20,)),
                        Text(
                          "Realtime Driver Location",
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              : Positioned(
                  top: 0,
                  right: 0,
                  child: SafeArea(
                    top: true,
                    child: IconButton(
                        onPressed: () {
                          getDrivers();
                        },
                        icon: const Icon(Icons.refresh)),
                  ),
                ),
        ],
      ),
    );
  }
}
