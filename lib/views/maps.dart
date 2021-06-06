import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(-6.303562, 107.024723);
  Set<Polyline> _polylines = HashSet<Polyline>();

  void _setPolylines() {
    // ignore: deprecated_member_use
    List<LatLng> polylineLatLongs = <LatLng>[];
    polylineLatLongs.add(LatLng(-6.303562, 107.024723));
    polylineLatLongs.add(LatLng(-6.302461, 107.022283));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        color: Colors.blue,
        width: 3,
        points: polylineLatLongs,
      ),
    );
  }

  @override
  void initState() {
    _markers.add(Marker(
        markerId: MarkerId("0"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: "Titik A",
        )));
    super.initState();
    _setPolylines();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var area = ["Jawa timur", "Jawa barat"];
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.all(10.0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: area.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        area[index],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      width: size.width,
                      height: size.height * 0.5,
                      child: Stack(
                        children: <Widget>[
                          GoogleMap(
                            mapType: MapType.satellite,
                            initialCameraPosition: CameraPosition(
                              target: _currentPosition,
                              zoom: 16,
                            ),
                            markers: _markers,
                            onTap: (position) {
                              setState(() {
                                _markers.add(Marker(
                                    markerId: MarkerId("1"),
                                    icon: BitmapDescriptor.defaultMarker,
                                    position: position,
                                    infoWindow: InfoWindow(title: "Titik B")));
                              });
                            },
                            onLongPress: (position) {
                              setState(() {
                                _markers.add(Marker(
                                    markerId: MarkerId("0"),
                                    icon: BitmapDescriptor.defaultMarker,
                                    position: position));
                              });
                            },
                            polylines: _polylines,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
