import 'package:flutter/material.dart';
import 'package:huawei_map/map.dart';

import 'locationCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HuaweiMapController mapController;

  static const LatLng _center = const LatLng(41.027470, 28.999339);

  static const LatLng _location1 = const LatLng(41.0329109, 28.9840904);
  static const LatLng _location2 = const LatLng(41.0155957, 28.9827176);
  static const LatLng _location3 = const LatLng(41.0217315, 29.0111898);

  static const double _zoom = 12;
  static const double _zoomMarker = 18;

  Set<Marker> _markers = {
    Marker(markerId: MarkerId("Location1"), position: _location1),
    Marker(markerId: MarkerId("Location2"), position: _location2),
    Marker(markerId: MarkerId("Location3"), position: _location3),
  };

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2)),
                  child: HuaweiMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: _zoom,
                    ),
                    mapType: MapType.normal,
                    tiltGesturesEnabled: true,
                    buildingsEnabled: true,
                    compassEnabled: true,
                    zoomControlsEnabled: false,
                    rotateGesturesEnabled: true,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: false,
                    trafficEnabled: true,
                    markers: _markers,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: RaisedButton(
                              onPressed: () {
                                CameraUpdate cameraUpdate =
                                    CameraUpdate.newLatLngZoom(_center, _zoom);
                                mapController.animateCamera(cameraUpdate);
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text("Center Map"),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              CameraUpdate cameraUpdate =
                                  CameraUpdate.newLatLngZoom(
                                      _location1, _zoomMarker);
                              mapController.animateCamera(cameraUpdate);
                            },
                            child: LocationCard(
                              title: "Location 1",
                              motto: "A Fine Dining Restaurant",
                              address:
                                  "Avrupa Yakası, Cihangir, 34433 Beyoğlu/İstanbul Türkiye",
                            )),
                        InkWell(
                            onTap: () {
                              CameraUpdate cameraUpdate =
                                  CameraUpdate.newLatLngZoom(
                                      _location2, _zoomMarker);
                              mapController.animateCamera(cameraUpdate);
                            },
                            child: LocationCard(
                              title: "Location 2",
                              motto: "A Restaurant with an Extraordinary View",
                              address:
                                  "Avrupa Yakası, Hoca Paşa, 34110 Fatih/İstanbul Türkiye",
                            )),
                        InkWell(
                            onTap: () {
                              CameraUpdate cameraUpdate =
                                  CameraUpdate.newLatLngZoom(
                                      _location3, _zoomMarker);
                              mapController.animateCamera(cameraUpdate);
                            },
                            child: LocationCard(
                              title: "Location 3",
                              motto: "A Casual Dining Restaurant",
                              address:
                                  "Anadolu Yakası, Aziz Mahmut Hüdayi, 34672 Üsküdar/İstanbul",
                            )),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
