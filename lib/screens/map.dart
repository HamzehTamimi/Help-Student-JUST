import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // Custom icons using Material Icons
  late BitmapDescriptor _parkingIcon;
  late BitmapDescriptor _classroomIcon;
  late BitmapDescriptor _stadiumIcon;
  late BitmapDescriptor _studentIcon;
  late BitmapDescriptor _hospitalIcon;
  late BitmapDescriptor _libraryIcon;
  late BitmapDescriptor _restaurantIcon;
  late BitmapDescriptor _buildingIcon;
  late BitmapDescriptor _bankIcon;
  late BitmapDescriptor _mosqueIcon;
  late BitmapDescriptor _departmentIcon;
  late BitmapDescriptor _dormIcon;
  late BitmapDescriptor _gymIcon;
  late BitmapDescriptor _defaultIcon;

  // Selected marker icons
  late BitmapDescriptor _selectedParkingIcon;
  late BitmapDescriptor _selectedClassroomIcon;
  late BitmapDescriptor _selectedStadiumIcon;
  late BitmapDescriptor _selectedStudentIcon;
  late BitmapDescriptor _selectedHospitalIcon;
  late BitmapDescriptor _selectedLibraryIcon;
  late BitmapDescriptor _selectedRestaurantIcon;
  late BitmapDescriptor _selectedBuildingIcon;
  late BitmapDescriptor _selectedBankIcon;
  late BitmapDescriptor _selectedMosqueIcon;
  late BitmapDescriptor _selectedDepartmentIcon;
  late BitmapDescriptor _selectedDormIcon;
  late BitmapDescriptor _selectedGymIcon;
  late BitmapDescriptor _selectedDefaultIcon;

  LatLng? _currentLocation;
  double _currentZoom = 14.0;
  String? _selectedMarkerId;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    try {
      await _loadCustomIcons();
      await _loadMarkers();
      await _getUserLocation();
    } catch (e) {
      print('Error initializing map: $e');
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ في تحميل الخريطة: $e')));
      }
    }
  }

  Future<void> _loadCustomIcons() async {
    try {
      // Load normal size icons using Material Icons
      _parkingIcon = await _createIconFromMaterialIcon(
        Icons.local_parking,
        Colors.blue,
        64,
      );
      _classroomIcon = await _createIconFromMaterialIcon(
        Icons.school,
        Colors.green,
        64,
      );
      _stadiumIcon = await _createIconFromMaterialIcon(
        Icons.sports_soccer,
        Colors.orange,
        64,
      );
      _studentIcon = await _createIconFromMaterialIcon(
        Icons.people,
        Colors.purple,
        64,
      );
      _hospitalIcon = await _createIconFromMaterialIcon(
        Icons.local_hospital,
        Colors.red,
        64,
      );
      _libraryIcon = await _createIconFromMaterialIcon(
        Icons.library_books,
        Colors.brown,
        64,
      );
      _restaurantIcon = await _createIconFromMaterialIcon(
        Icons.restaurant,
        Colors.deepOrange,
        64,
      );
      _buildingIcon = await _createIconFromMaterialIcon(
        Icons.business,
        Colors.indigo,
        64,
      );
      _bankIcon = await _createIconFromMaterialIcon(
        Icons.account_balance,
        Colors.teal,
        64,
      );
      _mosqueIcon = await _createIconFromMaterialIcon(
        Icons.temple_hindu,
        Colors.deepPurple,
        64,
      );
      _departmentIcon = await _createIconFromMaterialIcon(
        Icons.domain,
        Colors.cyan,
        64,
      );
      _dormIcon = await _createIconFromMaterialIcon(
        Icons.hotel,
        Colors.amber,
        64,
      );
      _gymIcon = await _createIconFromMaterialIcon(
        Icons.fitness_center,
        Colors.pink,
        64,
      );
      _defaultIcon = await _createIconFromMaterialIcon(
        Icons.place,
        Colors.blue,
        64,
      );

      // Load selected (larger) icons
      _selectedParkingIcon = await _createIconFromMaterialIcon(
        Icons.local_parking,
        Colors.red,
        80,
      );
      _selectedClassroomIcon = await _createIconFromMaterialIcon(
        Icons.school,
        Colors.red,
        80,
      );
      _selectedStadiumIcon = await _createIconFromMaterialIcon(
        Icons.sports_soccer,
        Colors.red,
        80,
      );
      _selectedStudentIcon = await _createIconFromMaterialIcon(
        Icons.people,
        Colors.red,
        80,
      );
      _selectedHospitalIcon = await _createIconFromMaterialIcon(
        Icons.local_hospital,
        Colors.red,
        80,
      );
      _selectedLibraryIcon = await _createIconFromMaterialIcon(
        Icons.library_books,
        Colors.red,
        80,
      );
      _selectedRestaurantIcon = await _createIconFromMaterialIcon(
        Icons.restaurant,
        Colors.red,
        80,
      );
      _selectedBuildingIcon = await _createIconFromMaterialIcon(
        Icons.business,
        Colors.red,
        80,
      );
      _selectedBankIcon = await _createIconFromMaterialIcon(
        Icons.account_balance,
        Colors.red,
        80,
      );
      _selectedMosqueIcon = await _createIconFromMaterialIcon(
        Icons.temple_hindu,
        Colors.red,
        80,
      );
      _selectedDepartmentIcon = await _createIconFromMaterialIcon(
        Icons.domain,
        Colors.red,
        80,
      );
      _selectedDormIcon = await _createIconFromMaterialIcon(
        Icons.hotel,
        Colors.red,
        80,
      );
      _selectedGymIcon = await _createIconFromMaterialIcon(
        Icons.fitness_center,
        Colors.red,
        80,
      );
      _selectedDefaultIcon = await _createIconFromMaterialIcon(
        Icons.place,
        Colors.red,
        80,
      );
    } catch (e) {
      print('Icon load error: $e');
      // Initialize with default icons if loading fails
      _initializeDefaultIcons();
    }
  }

  Future<BitmapDescriptor> _createIconFromMaterialIcon(
    IconData iconData,
    Color color,
    double size,
  ) async {
    try {
      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);

      // Create a white circle background
      final paint =
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);

      // Add border
      final borderPaint =
          Paint()
            ..color = Colors.grey.shade300
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;

      canvas.drawCircle(Offset(size / 2, size / 2), size / 2, borderPaint);

      // Draw the icon
      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(iconData.codePoint),
          style: TextStyle(
            fontSize: size * 0.6,
            fontFamily: iconData.fontFamily,
            color: color,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
      );

      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(size.toInt(), size.toInt());
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

      return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
    } catch (e) {
      print('Failed to create icon: $e');
      // Return default marker if creation fails
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  void _initializeDefaultIcons() {
    _parkingIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    );
    _classroomIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    );
    _stadiumIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueOrange,
    );
    _studentIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueYellow,
    );
    _hospitalIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _libraryIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    );
    _restaurantIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    );
    _buildingIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueCyan,
    );
    _bankIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    _mosqueIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueMagenta,
    );
    _departmentIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    );
    _dormIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    );
    _gymIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueOrange,
    );
    _defaultIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    );

    // Selected icons
    _selectedParkingIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedClassroomIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedStadiumIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedStudentIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedHospitalIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedLibraryIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedRestaurantIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedBuildingIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedBankIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedMosqueIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedDepartmentIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedDormIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedGymIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    _selectedDefaultIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
  }

  BitmapDescriptor _getIconForLocation(
    String title,
    String id,
    bool isSelected,
  ) {
    String titleLower = title.toLowerCase();

    // Parking locations
    if (titleLower.contains('موقف') || titleLower.contains('parking')) {
      return isSelected ? _selectedParkingIcon : _parkingIcon;
    }

    // Hospital and medical facilities
    if (titleLower.contains('مستشفى') ||
        titleLower.contains('hospital') ||
        titleLower.contains('طب') ||
        titleLower.contains('medical') ||
        titleLower.contains('عيادات') ||
        titleLower.contains('clinic')) {
      return isSelected ? _selectedHospitalIcon : _hospitalIcon;
    }

    // Library
    if (titleLower.contains('مكتبة') || titleLower.contains('library')) {
      return isSelected ? _selectedLibraryIcon : _libraryIcon;
    }

    // Restaurants and cafeterias
    if (titleLower.contains('كافتيريا') ||
        titleLower.contains('مطعم') ||
        titleLower.contains('طعميه') ||
        titleLower.contains('قهوة') ||
        titleLower.contains('cafeteria') ||
        titleLower.contains('restaurant')) {
      return isSelected ? _selectedRestaurantIcon : _restaurantIcon;
    }

    // Banks and ATMs
    if (titleLower.contains('بنك') ||
        titleLower.contains('bank') ||
        titleLower.contains('atm') ||
        titleLower.contains('صراف')) {
      return isSelected ? _selectedBankIcon : _bankIcon;
    }

    // Mosques
    if (titleLower.contains('مسجد') || titleLower.contains('mosque')) {
      return isSelected ? _selectedMosqueIcon : _mosqueIcon;
    }

    // Sports facilities
    if (titleLower.contains('ملعب') ||
        titleLower.contains('stadium') ||
        titleLower.contains('gym') ||
        titleLower.contains('swimming') ||
        titleLower.contains('مسبح') ||
        titleLower.contains('رياضة')) {
      return isSelected ? _selectedStadiumIcon : _stadiumIcon;
    }

    // Dormitories and student housing
    if (titleLower.contains('سكن') ||
        titleLower.contains('dormitory') ||
        titleLower.contains('student housing')) {
      return isSelected ? _selectedDormIcon : _dormIcon;
    }

    // Classrooms and conference centers
    if (titleLower.contains('مدرج') ||
        titleLower.contains('قاعة') ||
        titleLower.contains('صلاح الدين') ||
        titleLower.contains('مؤتمرات') ||
        titleLower.contains('amphitheater') ||
        titleLower.contains('hall')) {
      return isSelected ? _selectedClassroomIcon : _classroomIcon;
    }

    // Colleges and faculties (buildings)
    if (titleLower.contains('كلية') ||
        titleLower.contains('عمادة') ||
        titleLower.contains('قسم') ||
        titleLower.contains('faculty') ||
        titleLower.contains('college') ||
        titleLower.contains('department')) {
      return isSelected ? _selectedBuildingIcon : _buildingIcon;
    }

    // Student services and centers
    if (titleLower.contains('طلبة') ||
        titleLower.contains('student') ||
        titleLower.contains('تسجيل') ||
        titleLower.contains('registration') ||
        titleLower.contains('خدمة') ||
        titleLower.contains('service')) {
      return isSelected ? _selectedStudentIcon : _studentIcon;
    }

    // Default icon for unrecognized locations
    return isSelected ? _selectedDefaultIcon : _defaultIcon;
  }

  Future<void> _getUserLocation() async {
    try {
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
      if (mounted) {
        setState(() {
          _currentLocation = LatLng(locData.latitude!, locData.longitude!);
        });
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _loadMarkers() async {
    try {
      setState(() => _isLoading = true);
      _markers = await _loadHardcodedMarkers();
      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error loading markers: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<Set<Marker>> _loadHardcodedMarkers() async {
    final markers = <Marker>{};

    try {
      for (final data in markerData) {
        String id = data['id'] as String;
        String title = data['title'] as String;
        bool isSelected = id == _selectedMarkerId;

        BitmapDescriptor icon = _getIconForLocation(title, id, isSelected);

        markers.add(
          Marker(
            markerId: MarkerId(id),
            position: LatLng(
              (data['lat'] as num).toDouble(),
              (data['lng'] as num).toDouble(),
            ),
            infoWindow: InfoWindow(
              title: title,
              snippet: _getLocationCategory(title),
            ),
            icon: icon,
            onTap: () => _onMarkerTapped(id),
          ),
        );
      }
    } catch (e) {
      print('Error creating markers: $e');
    }

    return markers;
  }

  String _getLocationCategory(String title) {
    String titleLower = title.toLowerCase();

    if (titleLower.contains('موقف') || titleLower.contains('parking'))
      return 'موقف سيارات';
    if (titleLower.contains('مستشفى') || titleLower.contains('hospital'))
      return 'مرافق طبية';
    if (titleLower.contains('مكتبة') || titleLower.contains('library'))
      return 'مكتبة';
    if (titleLower.contains('كافتيريا') || titleLower.contains('مطعم'))
      return 'مطاعم وكافتيريات';
    if (titleLower.contains('بنك') || titleLower.contains('bank'))
      return 'خدمات مصرفية';
    if (titleLower.contains('مسجد') || titleLower.contains('mosque'))
      return 'مسجد';
    if (titleLower.contains('ملعب') || titleLower.contains('stadium'))
      return 'مرافق رياضية';
    if (titleLower.contains('سكن') || titleLower.contains('dormitory'))
      return 'سكن طلابي';
    if (titleLower.contains('كلية') || titleLower.contains('college'))
      return 'كليات';
    if (titleLower.contains('قسم') || titleLower.contains('department'))
      return 'أقسام أكاديمية';

    return 'مرافق جامعية';
  }

  void _onMarkerTapped(String markerId) async {
    if (mounted) {
      setState(() {
        _selectedMarkerId = markerId;
      });
      await _loadMarkers();
    }
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لم يتم العثور على موقعك الحالي')),
        );
      }
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
        title: const Text('JUST Map'),
        backgroundColor: Color.fromRGBO(187, 222, 251, 1),
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
