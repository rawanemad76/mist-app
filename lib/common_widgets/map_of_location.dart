import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapOfLocation extends StatefulWidget {
  const MapOfLocation({super.key});

  @override
  State<MapOfLocation> createState() => _MapOfLocationState();
}

class _MapOfLocationState extends State<MapOfLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition cameraPosition = CameraPosition(
    target: LatLng(29.95375640, 31.53700030),
    zoom: 10, //14.4746
  );
  List<Marker> markers = [
    // const Marker(markerId: MarkerId("1"),position: LatLng(29.95375640, 31.53700030)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: SafeArea(
          child: SizedBox(
            child: GoogleMap(
              markers: markers.toSet(),
              onTap: (LatLng latLng) {
                markers.add(
                  Marker(
                      markerId: const MarkerId("1"),
                      position: LatLng(latLng.latitude, latLng.longitude)),
                );
                setState(() {});
                print("=========================");
                print("${latLng.longitude}");
                print("${latLng.latitude}");
                print("======================");
              },
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ),
      ),
    );
  }
}
