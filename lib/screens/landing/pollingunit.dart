import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:myinec/utils/colors.dart';

class PollingUnit extends StatefulWidget {
  @override
  State<PollingUnit> createState() => _PollingUnit();

}

class _PollingUnit extends State<PollingUnit> {
  final Completer<GoogleMapController> _completer = Completer();

  static const LatLng sourceLocation = LatLng((37.33500926), -122.03272188);
  static const LatLng destination = LatLng((37.3894), -122.0895);

List<LatLng> polylineCoordinates = [];
LocationData currentLocation;

BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();



    location.getLocation().then((location) {
      currentLocation = location;
    },);

    GoogleMapController googleMapController = await _completer.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
              target: LatLng(
                  newLoc.latitude,
                  newLoc.longitude
              )
          )
          )
      );
      setState(() {

      });
    });
  }



  void getPolyPoints() async {
    PolylinePoints poly = PolylinePoints();

    PolylineResult result = await poly.getRouteBetweenCoordinates("googleApiKey",
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude), PointLatLng(destination.latitude, destination.longitude));
    if(result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>  polylineCoordinates.add(LatLng(point.latitude, point.longitude)));

      setState(() {

      });
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,
    "").then((icon) {
      sourceIcon = icon;
    },
    );
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,
    "").then((icon) {
      destinationIcon = icon;
    },
    );
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,
    "").then((icon) {
      currentLocationIcon = icon;
    },
    );
  }




  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }



  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Polling Unit:", style: TextStyle(color: Colors.white),),
      ),
      body: currentLocation == null ?
          const Center(child: Text("loading")) :
      GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 14.5),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            width: 6,
            color: kPrimaryColor,
          )
        },
        markers: {
          Marker(
            icon: currentLocationIcon,
            markerId: const MarkerId("currentLocation"),
            position: LatLng(currentLocation.latitude, currentLocation.longitude),
          ),
          Marker(
            icon: sourceIcon,
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          Marker(
            icon: destinationIcon,
            markerId: MarkerId("destination"),
            position: destination,
          )
        },

        onMapCreated: (mapController){
          _completer.complete(mapController);
        },
      ),
    );
  }

}