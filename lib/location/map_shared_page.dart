import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapShared extends StatelessWidget {
  final LatLng initialLocation;

  const MapShared({Key? key, required this.initialLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('selectedLocation'),
            position: initialLocation,
          ),
        },
      ),
    );
  }
}