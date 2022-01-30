import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:warranty_track/app/modules/home/controller/home_controller.dart';

class MapPopupDialog extends StatefulWidget {
  final double lat;
  final double long;
  const MapPopupDialog({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  _MapPopupDialogState createState() => _MapPopupDialogState();
}

class _MapPopupDialogState extends State<MapPopupDialog> {
  HomeViewController homeController = Get.find();
  Set<Marker> markers = <Marker>{};
  late GoogleMapController mapController;

  // final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    markers.add(Marker(
        markerId: const MarkerId('id'),
        position: LatLng(widget.lat, widget.long)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: GoogleMap(
        // mapType: MapType.terrain,
        myLocationEnabled: true,
        markers: markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 15.0,
        ),
        onTap: (LatLng latLng) {
          homeController.lat.value = latLng.latitude;
          homeController.long.value = latLng.longitude;
          setState(() {
            markers.add(
              Marker(
                markerId: const MarkerId('id'),
                position: LatLng(latLng.latitude, latLng.longitude),
              ),
            );
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Set'),
        ),
        ElevatedButton(
          onPressed: () {
            homeController.lat.value = widget.lat;
            homeController.long.value = widget.long;
            Get.back();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
