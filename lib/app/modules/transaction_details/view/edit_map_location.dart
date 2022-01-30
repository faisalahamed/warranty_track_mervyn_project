import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/home/controller/home_controller.dart';
import 'package:warranty_track/app/modules/transaction_details/view/transaction_detail_screen.dart';
import 'package:warranty_track/app/service/firebase_config.dart';

class EditMapLocation extends StatefulWidget {
  final TransactionModel item;
  const EditMapLocation({Key? key, required this.item}) : super(key: key);

  @override
  _EditMapLocationState createState() => _EditMapLocationState();
}

class _EditMapLocationState extends State<EditMapLocation> {
  HomeViewController homeController = Get.find();
  Set<Marker> markers = <Marker>{};
  late GoogleMapController mapController;
  // LocationData? locationData;
  double currentlat = 0.0;
  double currentlong = 0.0;
  // final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void setCurrentLocationData() async {
    if (widget.item.lat == '0.0') {
      await homeController.getCurrentLocation().then((value) => setState(() {
            if (value != null) {
              markers.add(Marker(
                markerId: const MarkerId('id'),
                position: LatLng(value.latitude!, value.longitude!),
              ));
            }
          }));
    }
  }

  @override
  void initState() {
    setCurrentLocationData();
    markers.add(
      Marker(
        markerId: const MarkerId('id'),
        position: LatLng(
            widget.item.lat != null
                ? double.parse(widget.item.lat!)
                : currentlat,
            widget.item.long != null
                ? double.parse(widget.item.long!)
                : currentlong),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: GoogleMap(
        mapType: MapType.terrain,
        myLocationEnabled: true,
        markers: markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.item.lat != null ? double.parse(widget.item.lat!) : 0.0,
              widget.item.long != null ? double.parse(widget.item.long!) : 0.0),
          zoom: 15.0,
        ),
        onTap: (LatLng latLng) {
          widget.item.lat = latLng.latitude.toString();
          widget.item.long = latLng.longitude.toString();
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
            FirebaseConf()
                .updateTransaction(widget.item.id, 'lat', widget.item.lat);
            FirebaseConf()
                .updateTransaction(widget.item.id, 'long', widget.item.long);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    TransactionDetailScreen(transectionItem: widget.item)));
          },
          child: const Text('Set'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
