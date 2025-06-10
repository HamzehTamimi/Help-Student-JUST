import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpstudent/screens/marker_data_MAP.dart';
import 'package:helpstudent/screens/marker_icons.dart';
import 'package:helpstudent/utils/marker_data_MAP.dart';
import 'package:helpstudent/utils/marker_icons.dart';
import 'package:location/location.dart';

class MyMapPage extends StatefulWidget {
  const MyMapPage({super.key});

  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(32.4938466, 35.9901261);
  Set<Marker> _markers = {};
  bool _isLoading = true;
  MapType _mapType = MapType.normal;
  LatLng? _currentLocation;
  double _currentZoom = 14.0;
  // ignore: unused_field
  String? _selectedMarkerId;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await MarkerIcons.loadAll();
    await _loadMarkers();
    await _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    Location location = Location();
    if (!(await location.serviceEnabled()) &&
        !(await location.requestService()))
      return;
    if (await location.hasPermission() == PermissionStatus.denied &&
        await location.requestPermission() != PermissionStatus.granted)
      return;
    final loc = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(loc.latitude!, loc.longitude!);
    });
  }

  Future<void> _loadMarkers() async {
    setState(() => _isLoading = true);
    _markers = await _buildMarkers();
    setState(() => _isLoading = false);
  }

  Future<Set<Marker>> _buildMarkers() async {
    final Set<Marker> markers = {};
    for (final data in markerData) {
      final id = data['id'] as String;
      final lat = (data['lat'] as num).toDouble();
      final lng = (data['lng'] as num).toDouble();
      final title = data['title'] as String;

      final type = MarkerIcons.detectTypeFromId(id);
      final icon = MarkerIcons.fromType(type);

      markers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: title),
          icon: icon,
          onTap: () => _onMarkerTapped(id),
        ),
      );
    }
    return markers;
  }

  void _onMarkerTapped(String markerId) {
    setState(() => _selectedMarkerId = markerId);
  }

  void _goToJUST() {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _center, zoom: _currentZoom),
      ),
    );
  }

  void _goToCurrentLocation() {
    if (_currentLocation != null) {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLocation!, zoom: _currentZoom),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم العثور على موقعك الحالي')),
      );
    }
  }

  void _zoomIn() {
    setState(() {
      _currentZoom++;
      mapController?.animateCamera(CameraUpdate.zoomTo(_currentZoom));
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom--;
      mapController?.animateCamera(CameraUpdate.zoomTo(_currentZoom));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خريطة جامعة العلوم'),
        backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: () {
              setState(() {
                _mapType =
                    _mapType == MapType.normal
                        ? MapType.satellite
                        : MapType.normal;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              GoogleMap(
                onMapCreated: (c) => mapController = c,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: _currentZoom,
                ),
                markers: _markers,
                mapType: _mapType,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
            Positioned(
              bottom: 100,
              right: 16,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'zoomIn',
                    tooltip: 'تقريب',
                    onPressed: _zoomIn,
                    child: const Icon(Icons.zoom_in),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton(
                    heroTag: 'zoomOut',
                    tooltip: 'تبعيد',
                    onPressed: _zoomOut,
                    child: const Icon(Icons.zoom_out),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'locate',
                    tooltip: 'اذهب لموقعي',
                    onPressed: _goToCurrentLocation,
                    child: const Icon(Icons.my_location),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton(
                    heroTag: 'just',
                    tooltip: 'اذهب إلى الجامعة',
                    onPressed: _goToJUST,
                    child: const Icon(Icons.school),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
