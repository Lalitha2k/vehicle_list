import 'package:flutter/material.dart';
import 'package:vehical_pollution/vehical_model.dart';

import 'vehical_controller.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  final VehicleController _controller = VehicleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle List')),
      
      body: FutureBuilder<List<Vehicle>>(
        future: _controller.fetchVehicles(),
        
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No vehicles found"));
          }

          List<Vehicle> vehicles = snapshot.data!;

          return ListView.builder(
            
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              Vehicle vehicle = vehicles[index];
              Color cardColor = _getColor(vehicle);

              return Card(
                color: cardColor,
                child: ListTile(
                  title: Text(vehicle.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Mileage: ${vehicle.mileage} km/l • Year: ${vehicle.year}'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Determine the color based on mileage and year
 Color _getColor(Vehicle vehicle) {
  num currentYear = DateTime.now().year;
  num age = currentYear - vehicle.year;

  if (vehicle.mileage >= 15 && age <= 5) {
    return Colors.green;  // Fuel efficient and low pollutant
  } else if (vehicle.mileage >= 15 && age > 5) {
    return Colors.amber;  // Fuel efficient but moderately pollutant
  } else {
    return Colors.red;  // Not fuel efficient
  }
}

      // Not fuel efficient
  }

