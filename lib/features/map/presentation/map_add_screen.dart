import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/core/widgets/buttons/base_button.dart';
import 'package:int20h/core/widgets/loading/loading_screen.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:int20h/features/map/presentation/cubit/map_add/map_add_cubit.dart';
import 'package:int20h/features/map/presentation/cubit/map_cubit.dart';
import 'package:int20h/injection_container.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:ui' as ui;

import 'components/add_location_textfield.dart';


class MapAddScreen extends StatefulWidget {
  const MapAddScreen({super.key});

  @override
  State<MapAddScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapAddScreen> {
  LatLng initialLocation = const LatLng(50.4499824, 30.4599418);
  Uint8List? markerIcon;
  GoogleMapController? mapController;
  MapType mapType = MapType.normal;
  MapAddCubit cubit = sl();

  double lat = 50.4499824;
  double lon = 30.4599418;
  String name = '';
  String description = '';
  String type = 'UNI_BUILDING';

  @override
  void initState() {
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
    return BlocConsumer<MapAddCubit, MapAddState>(
      listener: (context, state) {
        if (state is MapAddFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Unexpected error occurred',
                style: gilroy.s14.white.w500,
              ),
            ),
          );
        }
        if (state is MapAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: CColors.green,
              content: Text(
                'Location was added successfully',
                style: gilroy.s14.white.w500,
              ),
            ),
          );
          Navigator.pop(context);
          sl<MapCubit>().getLocations();
        }
      },
      bloc: cubit,
      builder: (context, state) {
        return KeyboardDismissOnTap(
          child: Scaffold(
            appBar: const BaseAppBar(
              title: 'Add new location',
              isBackButton: true,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: FloatingActionButton(
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
            ),
            body: SlidingUpPanel(
              body: GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
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
                markers: {
                  Marker(
                      icon:  markerIcon != null ? BitmapDescriptor.fromBytes(markerIcon!) : BitmapDescriptor.defaultMarker,
                      draggable: true,
                      markerId: const MarkerId('MarkerAdd'),
                      position: LatLng(lat, lon),
                      onDragEnd: ((newPosition) {
                        setState(() {
                          lat = newPosition.latitude;
                          lon = newPosition.longitude;
                        });
                      }))
                },
              ),
              borderRadius: BorderRadius.circular(20),
              panel: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.drag_handle, color: CColors.grey.withOpacity(0.5), size: 30,),
                    ),
                    const SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.center,
                        child: Text('Enter location info', style: gilroy.w500.s24.black, textAlign: TextAlign.center,)),
                    const SizedBox(height: 30,),
                    RichText(
                      text: TextSpan(
                          text: 'Latitude: ',
                          style: gilroy.w700.black.s14,
                          children: <TextSpan>[
                            TextSpan(text: lat.toString(),
                              style: gilroy.w700.green.s14,
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 10,),
                    RichText(
                      text: TextSpan(
                          text: 'Longitude: ',
                          style: gilroy.w700.black.s14,
                          children: <TextSpan>[
                            TextSpan(text: lon.toString(),
                              style: gilroy.w700.green.s14,
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 10,),
                    AddLocationTextField(
                      hintText: 'Enter location name',
                      onChanged: (s) {
                        setState(() {
                          name = s;
                        });
                      },
                    ),
                    const SizedBox(height: 10,),
                    AddLocationTextField(
                      minLines: 4,
                      maxLines: 4,
                      hintText: 'Enter location description',
                      onChanged: (s) {
                        setState(() {
                          description = s;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Select type: ', style: gilroy.w700.black.s14,),
                        const SizedBox(width: 8,),
                        DropdownButton<String>(
                          value: type,
                          onChanged: (String? newValue){
                            setState(() {
                              type = newValue!;
                            });
                          },
                          items: [
                            DropdownMenuItem(child: Text('University building', style: gilroy.black.s14.w500,), value: "UNI_BUILDING",),
                            DropdownMenuItem(child: Text('Canteen',  style: gilroy.black.s14.w500,), value: "CANTEEN",),
                            DropdownMenuItem(child: Text('Gym',  style: gilroy.black.s14.w500,), value: "GYM",),
                            DropdownMenuItem(child: Text('Other',  style: gilroy.black.s14.w500,), value: "OTHER",),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BaseButton(
                      isLoading: state is MapLoading,
                      isActive: name.length > 3 && type.isNotEmpty,
                      onTap: () {
                        Location location = Location(latitude: lat, longitude: lon, name: name, description: description, type: type);
                        cubit.addLocation(location);
                      }, label: 'Add location', isGradient: true,),
                  ],
                ),
              ),
            ) 
          ),
        );
      },
    );
  }

  void addCustomIcon() async{
    final marker = await getBytesFromAsset(PngIcons.locationPin, 120);
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
}
