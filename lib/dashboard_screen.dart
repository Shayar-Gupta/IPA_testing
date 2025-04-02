import 'package:flutter/material.dart';
import 'package:etms_flutter/bus_services_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1663ED),
              Color(0xFF6139B3)
            ], // Gradient from Blue to Purple
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.only(top: 44),
        child: Column(
          children: [
            Text(
              "Welcome To",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(height: 16),
            Text(
              "TCS eTMS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 32,
                decoration: TextDecoration.none,              
              ),
            ),
            SizedBox(height: 16),
            Text(
              "PLEASE SELECT YOUR SERVICE",
        
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 16),

            // Bus Services Card
            ServiceOptionCard(
              imagePath: 'assets/bust_icon.jpg',
              text: "Bus Services",
              width: 56,
              height: 56,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusServicesScreen()));
              },
            ),

            SizedBox(height: 16),

            // Cab Services Card
            ServiceOptionCard(
              imagePath: 'assets/cab_icon.jpg',
              text: "Cab Services",
              width: 56,
              height: 56,
            ),

            SizedBox(height: 16),

            // Geocode Yourself Card
            ServiceOptionCard(
              imagePath: 'assets/geocoded_icon.jpg',
              text: "Geo Services",
              width: 56,
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
class ServiceOptionCard extends StatelessWidget {
  final String imagePath; // Path to the image asset
  final String text;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const ServiceOptionCard({
    super.key,
    required this.imagePath,
    required this.text,
    required this.width,
    required this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 40),
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF2C256B), // Deep Purple background
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(50)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Row(
          children: [
            const SizedBox(width: 40),
            Image.asset(
              imagePath,
              width: width, // Adjust width based on the provided size
              height: height, // Adjust height based on the provided size
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
