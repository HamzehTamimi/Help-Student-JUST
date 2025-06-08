import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpstudent/screens/marker_data_MAP.dart';
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

  late BitmapDescriptor _parkingIcon;
  late BitmapDescriptor _salahIcon;
  late BitmapDescriptor _stadiumIcon;
  late BitmapDescriptor _studentIcon;

  LatLng? _currentLocation;
  double _currentZoom = 14.0;

  String? _selectedMarkerId;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await _loadCustomIcons();
    await _loadMarkers();
    await _getUserLocation();
  }

  Future<void> _loadCustomIcons() async {
    try {
      _parkingIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'img/icons8-parking-48.png',
      );

      _salahIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'img/icons8-classroom-50.png',
      );

      _stadiumIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'img/icons8-stadium-40.png',
      );
      _studentIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'img/icons8-student-center-48.png',
      );
    } catch (e) {
      print('Icon load error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('فشل تحميل الأيقونات: $e')));
    }
  }

  Future<void> _getUserLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final locData = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(locData.latitude!, locData.longitude!);
    });
  }

  Future<void> _loadMarkers() async {
    setState(() => _isLoading = true);
    _markers = await _loadHardcodedMarkers();
    setState(() => _isLoading = false);
  }

  Future<Set<Marker>> _loadHardcodedMarkers() async {
    final markers = <Marker>{};

    for (final data in markerData) {
      String? id = data['ty'] as String?;
      bool isSelected = id == _selectedMarkerId;

      BitmapDescriptor icon;
      if (id == 'موقف') {
        icon =
            isSelected
                ? await BitmapDescriptor.fromAssetImage(
                  const ImageConfiguration(size: Size(64, 64)),
                  'img/icons8-parking-48.png',
                )
                : _parkingIcon;
      } else if (id == 'صلاح الدين') {
        icon =
            isSelected
                ? await BitmapDescriptor.fromAssetImage(
                  const ImageConfiguration(size: Size(64, 64)),
                  'img/icons8-classroom-50.png',
                )
                : _salahIcon;
      } else {
        icon =
            isSelected
                ? BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue,
                )
                : BitmapDescriptor.defaultMarker;
      }

      markers.add(
        Marker(
          markerId: MarkerId(data['id'] as String),
          position: LatLng(
            (data['lat'] as num).toDouble(),
            (data['lng'] as num).toDouble(),
          ),
          infoWindow: InfoWindow(title: data['title'] as String),
          icon: icon,
          onTap: () => _onMarkerTapped(data['id'] as String),
        ),
      );
    }

    return markers;
  }

  void _onMarkerTapped(String markerId) async {
    setState(() {
      _selectedMarkerId = markerId;
    });
    await _loadMarkers();
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
      _currentZoom += 1;
      mapController?.animateCamera(CameraUpdate.zoomTo(_currentZoom));
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
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
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
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
                mainAxisSize: MainAxisSize.min,
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
                mainAxisSize: MainAxisSize.min,
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
