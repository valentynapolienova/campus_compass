import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/widgets/loading/loading_screen.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:int20h/features/map/presentation/cubit/map_cubit.dart';
import 'package:int20h/features/map/presentation/map_add_screen.dart';
import 'package:int20h/injection_container.dart';
import 'dart:ui' as ui;


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng initialLocation = const LatLng(50.4499824, 30.4599418);
  late MapCubit cubit;
  Uint8List? markerIcon;
  GoogleMapController? mapController;
  MapType mapType = MapType.normal;

  @override
  void initState() {
    cubit = sl();
    cubit.getLocations();
    WidgetsBinding.instance.addPostFrameCallback((_){
      addCustomIcon();
    });
    super.initState();
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: Column(
            children: [
              FloatingActionButton(
                backgroundColor: CColors.green,
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MapAddScreen(),),);
                },
                child:   const Icon(Icons.edit, color: CColors.white,),
              ),
              const SizedBox(height: 10,),
              FloatingActionButton(
                backgroundColor: CColors.white,
                onPressed: ()=>
                {
                setState(() {
                mapType = (mapType == MapType.normal) ? MapType.hybrid : MapType.normal;
                })
              },
                heroTag: null,
                child:  const Icon(Icons.layers, color: CColors.grey,),
              ),
            ],
          ),
          body: state is MapSuccess ? GoogleMap(
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            mapType: mapType,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 16,
            ),
            markers: List.generate(state.locations.length, (index) {
              Location location = state.locations[index];
              return Marker(
                icon: markerIcon != null ? BitmapDescriptor.fromBytes(markerIcon!) : BitmapDescriptor.defaultMarker,
                markerId: MarkerId("marker$index"),
                position: LatLng(location.latitude ?? 0, location.longitude ?? 0),
                // To do: custom marker icon
              );
            }).toSet(),
          ) : const LoadingScreen(
            withoutBackButton: true,
          ),
        );
      },
    );
  }

  void addCustomIcon() async{
    final marker = await getBytesFromAsset(PngIcons.locationMark, 150);
     setState(() {
       markerIcon = marker ;
     });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

/*  Future<void> startAddingMode() async {
    Position? position = await _determinePosition();
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(position.latitude ?? 50.4499824, position.longitude ?? 30.4599418), 16));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }*/

}
