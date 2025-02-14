import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehical_pollution/vehical_model.dart';


class VehicleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all vehicles from Firestore
  Future<List<Vehicle>> fetchVehicles() async {
  
    QuerySnapshot snapshot = await _firestore.collection('vehicals').get();
    return snapshot.docs.map((doc) {
      return Vehicle.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
