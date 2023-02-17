import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GooglemapScreen extends StatefulWidget {
  final latitude;
  final langitude;
  const GooglemapScreen({Key? key, this.latitude, this.langitude}) : super(key: key);

  @override
  State<GooglemapScreen> createState() => _GooglemapScreenState();
}

class _GooglemapScreenState extends State<GooglemapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.langitude),
          zoom: 14,
        ),
        mapType: MapType.normal,
        markers: {
          Marker(
            markerId: MarkerId('User Location'),
            position: LatLng(widget.latitude, widget.langitude),
          ),
        },
      ),
    );
  }
}
