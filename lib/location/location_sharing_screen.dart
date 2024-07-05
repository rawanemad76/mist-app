import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationSharingScreen extends StatefulWidget {
  final LatLng initialLocation;
  const LocationSharingScreen({super.key, required this.initialLocation});

  @override
  _LocationSharingScreenState createState() => _LocationSharingScreenState();
}

class _LocationSharingScreenState extends State<LocationSharingScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  LatLng? _selectedPosition;
  String? _address;


  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialLocation;
    _selectedPosition = _currentPosition;
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      _getCurrentLocation();
    } else if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isGranted) {
        _getCurrentLocation();
      } else {
        _showPermissionDeniedDialog();
      }
    } else if (status.isPermanentlyDenied) {
      // navigate to app settings
      _showPermissionPermanentlyDeniedDialog();
    } else {

      _showPermissionDeniedDialog();
    }
  }
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content: const Text('Please grant location permission to use this feature.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  void _showPermissionPermanentlyDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Permanently Denied'),
        content: const Text('Please go to the app settings and grant location permission.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text('Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _selectedPosition = _currentPosition;
    });
    _moveCameraToPosition(_currentPosition!);
    _getAddressFromLatLng(_currentPosition!);
  }
  Future<void> _moveCameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _address = "${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (_currentPosition != null) {
      Future.delayed(const Duration(milliseconds: 0), () {
        controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
      });
    }
  }
  void _onMarkerDragEnd(LatLng newPosition) {
    setState(() {
      _selectedPosition = newPosition;
    });
    _getAddressFromLatLng(newPosition);
  }
  void _onMapTap(LatLng newPosition) {
    setState(() {
      _selectedPosition = newPosition;
    });
    _getAddressFromLatLng(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, _selectedPosition);
              setState(() {
                onPressedCheck =true;
              });},),],),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator(
        color: ColorManager.primaryColor,
      ))
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('selectedLocation'),
            position: _selectedPosition!,
            draggable: true,
            onDragEnd: _onMarkerDragEnd,
          ),},
        onTap: _onMapTap,),
    );
  }
}
bool onPressedCheck =false;