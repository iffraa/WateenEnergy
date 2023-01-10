import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class SiteMap extends StatefulWidget {

  const SiteMap()
  ;

  @override
  State<SiteMap> createState() => _SiteMapState();
}

class _SiteMapState extends State<SiteMap> {
  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    Completer<GoogleMapController> _controller = Completer();

     final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(24.9008, 67.1681),
      zoom: 14.4746,
    );

     final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    return Padding(
        padding:  EdgeInsets.symmetric(vertical: 2.h),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 30.h,
          child: GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: Set<Marker>.of(getMarkerList().values),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          /*GoogleMapsWidget(
            apiKey: "AIzaSyA6ZmrF0mXIj2wS9kuK-opv-ByeTn4z6cA",
            sourceLatLng: LatLng(31.5204, 74.3587),
            destinationLatLng: LatLng(24.9008, 67.1681),
            markers: Set<Marker>.of(getMarkerList().values),
          ),*/
        )
    );
  }

  Marker getMarker(MarkerId markerIdVal, LatLng positionCoords,String siteTitle, double hue )
  {
   /* BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/bike.png",
    ); */   // creating a new MARKER
    return Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(hue),
      markerId: markerIdVal,
      position: positionCoords,
      infoWindow: InfoWindow(title: siteTitle, snippet: '*'),
      onTap: () {
        //  _onMarkerTapped(markerId);
      },
    );

  }

  Map<MarkerId, Marker> getMarkerList()
  {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

    final MarkerId markerId2 = MarkerId("2");
    Marker m2 = getMarker(markerId2, LatLng(24.9008, 67.1681), "khi",BitmapDescriptor.hueBlue);
    markers[markerId2] = (m2);

    final MarkerId markerId = MarkerId("10");
    Marker m1 = getMarker(markerId, LatLng(25.0215, 67.3034), "lhr",BitmapDescriptor.hueYellow);
    markers[markerId] = (m1);

    return markers;
  }
}
