// marker_icons.dart
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerIcons {
  static late BitmapDescriptor parking;
  static late BitmapDescriptor classroom;
  static late BitmapDescriptor blue;
  static late BitmapDescriptor hospital;
  static late BitmapDescriptor mosque;
  static late BitmapDescriptor vector;
  static late BitmapDescriptor tree;
  static late BitmapDescriptor sea;
  static late BitmapDescriptor bank;
  static late BitmapDescriptor bank1;
  static late BitmapDescriptor ATM;
  static late BitmapDescriptor poto;
  static late BitmapDescriptor bus;
  static late BitmapDescriptor cycal;
  static late BitmapDescriptor Active;
  static late BitmapDescriptor Room;
  static late BitmapDescriptor Restaurant;
  static late BitmapDescriptor coffee;
  static late BitmapDescriptor record;
  static late BitmapDescriptor management;
  static late BitmapDescriptor helicopter;

  static Future<void> loadAll() async {
    const config = ImageConfiguration(size: Size(48, 48));
    parking = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-parking-48.png',
    );
    classroom = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-university-48.png',
    );
    hospital = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-hospital-50.png',
    );
    mosque = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-mosque-48.png',
    );
    vector = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-classroom-48.png',
    );
    tree = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-tree-48.png',
    );
    sea = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-sea-waves-48.png',
    );
    bank = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-bank-building-48.png',
    );
    bank1 = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-bank-building-48.png',
    );
    ATM = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-insert-credit-card-40.png',
    );
    poto = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-photo-48.png',
    );
    bus = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-bus-67.png',
    );
    cycal = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-graduation-64.png',
    );
    Active = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-stadium-40.png',
    );
    Room = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-sleeping-in-bed-50.png',
    );
    Restaurant = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-meal-48.png',
    );
    coffee = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-coffee-48.png',
    );
    record = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-library-50.png',
    );
    management = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-university-60.png',
    );
    helicopter = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/img/icons8-helicopter-48.png',
    );
    blue = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  }

  static String detectTypeFromId(String id) {
    final key = id.toLowerCase();

    if (key.contains('موقف') || key.contains('parking')) return 'parking';
    if (key.contains('كلية') ||
        key.contains('department') ||
        key.contains('faculty') ||
        key.contains('university') ||
        key.contains('stadium') ||
        key.contains('قسم') ||
        key.contains('مباني') ||
        key.contains('عمادةالبحث العلمي') ||
        key.contains('عيادات الاسنان التعليمية') ||
        key.contains('ph 1') ||
        key.contains('nb66 قاعة') ||
        key.contains('sb 13') ||
        key.contains('nb 19') ||
        key.contains('عمادة') ||
        key.contains('c5') ||
        key.contains('m7') ||
        key.contains('cpe06') ||
        key.contains('just-g2l2') ||
        key.contains('kafd just') ||
        key.contains('legal affairs department') ||
        key.contains('deanship of the faculty of graduate studies') ||
        key.contains('department of civil engineering') ||
        key.contains('مباني الكليات الهندسية') ||
        key.contains('engineering operator 1') ||
        key.contains('deanship of the faculty of medicine') ||
        key.contains('department of preventive dentistry') ||
        key.contains('department of clinical pharmacy') ||
        key.contains('faculty of pharmacy') ||
        key.contains('department of maternal and child health nursing') ||
        key.contains('department of pathology and microbiology') ||
        key.contains('department of biochemistry and molecular biology') ||
        key.contains('deanship of the faculty of nursing') ||
        key.contains('deanship of faculty of dentistry') ||
        key.contains('department of english for applied studies') ||
        key.contains('قسم علوم الفيزياء') ||
        key.contains('department of environmental science') ||
        key.contains('المبنى الشمالي') ||
        key.contains('قسم الهندسة الميكانيكية') ||
        key.contains('deanship of the faculty of engineering') ||
        key.contains('engineering complex') ||
        key.contains('قسم هندسة الحاسوب') ||
        key.contains('قسم طب وجراحة الفم') ||
        key.contains('قسم هندسة امن وشبكات الحاسوب') ||
        key.contains('قسم الهندسة الصناعية') ||
        key.contains('قسم الصيدلية') ||
        key.contains('قاعة ng-76'))
      return 'classroom';
    if (key.contains('hospital') ||
        key.contains('مستشفى') ||
        key.contains('الصحة البيطرية') ||
        key.contains('بيت الحيوان') ||
        key.contains('radiotherapy center'))
      return 'hospital';
    if (key.contains('مسجد')) return 'mosque';
    if (key.contains('مدرج') ||
        key.contains('hall') ||
        key.contains('قاعة عرار') ||
        key.contains('قاعة الزهراوي') ||
        key.contains('قاعة الفسيو') ||
        key.contains('مركز صلاح الدين') ||
        key.contains('مدرج الكرامة'))
      return 'vector';
    if (key.contains('مناظر طبيعية') ||
        key.contains('حديقة') ||
        key.contains('tree'))
      return 'tree';
    if (key.contains('بحيرة')) return 'sea';
    if (key.contains('وحدة الشؤون المالية') || key.contains('بنك'))
      return 'bank';
    if (key.contains('linc')) return 'bank1';
    if (key.contains('atm')) return 'atm';
    if (key.contains('دوار') ||
        key.contains('البوابة الرئيسية') ||
        key.contains('photo'))
      return 'poto';
    if (key.contains('bus') ||
        key.contains('الحافلات') ||
        key.contains('campus bus'))
      return 'bus';
    if (key.contains('sa1') || key.contains('nb66')) return 'cycal';
    if (key.contains('gym') || key.contains('ملعب')) return 'active';
    if (key.contains('سكن طالبات')) return 'room';
    if (key.contains('كافتيريا') || key.contains('مطعم')) return 'restaurant';
    if (key.contains('قهوة')) return 'coffee';
    if (key.contains('مكتبة') || key.contains('جمعية التصوير')) return 'record';
    if (key.contains('القبول والتسجيل') ||
        key.contains('الرئاسة') ||
        key.contains('العلاقات الدولية') ||
        key.contains('شؤون الطلبة'))
      return 'management';
    if (key.contains('مهبط')) return 'helicopter';

    return 'blue';
  }

  static BitmapDescriptor fromType(String type) {
    switch (type.toLowerCase()) {
      case 'parking':
        return parking;
      case 'classroom':
        return classroom;
      case 'hospital':
        return hospital;
      case 'mosque':
        return mosque;
      case 'vector':
        return vector;
      case 'tree':
        return tree;
      case 'sea':
        return sea;
      case 'bank':
        return bank;
      case 'bank1':
        return bank1;
      case 'atm':
        return ATM;
      case 'poto':
        return poto;
      case 'bus':
        return bus;
      case 'cycal':
        return cycal;
      case 'active':
        return Active;
      case 'room':
        return Room;
      case 'restaurant':
        return Restaurant;
      case 'coffee':
        return coffee;
      case 'record':
        return record;
      case 'management':
        return management;
      case 'helicopter':
        return helicopter;
      default:
        return blue;
    }
  }
}
