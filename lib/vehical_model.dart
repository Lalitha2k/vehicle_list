import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String name;
  final double mileage;
  final int year;
  final String code;
  final String brand;

  Vehicle({
    required this.name,
    required this.mileage,
    required this.year,
    required this.code,
    required this.brand,
  });

  // Factory constructor to convert Firestore data into a Vehicle object
  factory Vehicle.fromFirestore(Map<String, dynamic> data) {

    Timestamp timestamp = data['year']; // Firestore timestamp
    DateTime date = timestamp.toDate();   // Convert to DateTime
    int year = date.year;                 // Extract year

    return Vehicle(
      name: data['name'] ?? '',
      mileage: (data['mileage'] ?? 0).toDouble(),
      year: year,
      code: data['code'] ?? '',
      brand: data['brand'] ?? '',
    );
  }

  // Convert Vehicle object to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'mileage': mileage,
      'year': year,
      'code': code,
      'brand': brand,
    };
  }
}
