import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
  LatLng initialLocation = const LatLng(50.4499824, 30.4599418);
// ToDo: add custom marker
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 16,
        ),
        // ToDO: add markers
      ),
    );
  }
}
