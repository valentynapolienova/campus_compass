import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/util/bottom_sheet_opener.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:int20h/features/map/presentation/map_screen.dart';

class ScheduleMapScreen extends StatefulWidget {
  const ScheduleMapScreen({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  State<ScheduleMapScreen> createState() => _ScheduleMapScreenState();
}

class _ScheduleMapScreenState extends State<ScheduleMapScreen> {
  Uint8List? markerIcon;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addCustomIcon();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(
          title: "Location",
          isBackButton: true,
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.location.latitude ?? 0, widget.location.longitude ?? 0),
            zoom: 18,
          ),
          markers: {
            Marker(
              onTap: () {
                showCustomBottomSheet(
                    context, InfoBottomSheet(location: widget.location), true);
              },
              icon: markerIcon != null
                  ? BitmapDescriptor.fromBytes(markerIcon!)
                  : BitmapDescriptor.defaultMarker,
              markerId: const MarkerId("marker"),
              position: LatLng(widget.location.latitude ?? 0,
                  widget.location.longitude ?? 0),
              // To do: custom marker icon
            )
          },
        ));
  }

  void addCustomIcon() async {
    final marker = await getBytesFromAsset(PngIcons.locationMark, 150);
    setState(() {
      markerIcon = marker;
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
