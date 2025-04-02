import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:etms_flutter/datastore_manager.dart';

class DigitalBusPass extends StatefulWidget {
  const DigitalBusPass({super.key});

  @override
  _DigitalBusPassState createState() => _DigitalBusPassState();
}

class _DigitalBusPassState extends State<DigitalBusPass> {
  String userName = "Loading...";
  String employeeId = "0000000";

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    String username = await DataStoreManager.getUsername();
    String empId = await DataStoreManager.getEmployeeID();// Use DataStoreManager
    if (mounted) {
      setState(() {
        userName = username;
        employeeId = empId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dates = getMonthStartAndEndDates();

    return Column(
      children: [
        _gradientBox(),
        _whiteCard(dates),
      ],
    );
  }

  Widget _gradientBox() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF1663ED), Color.fromARGB(255, 118, 73, 209)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text("Kopri", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SvgPicture.asset(
            'assets/arrow_buspass.svg',
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          SizedBox(height: 8),
          Text("Yantra Park", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Office In - 08:30", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Office Out - 18:45", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _whiteCard(Map<String, String> dates) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name", style: TextStyle(color: Color(0xFF888888), fontSize: 16)),
                    Text(userName.toUpperCase(),
                        style: const TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Employee ID",
                        style: TextStyle(color: Color(0xFF888888), fontSize: 16)),
                    Text(employeeId,
                        style: const TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bus Stop Name:", style: TextStyle(color: Color(0xFF888888), fontSize: 16)),
                    Text("Kopri",
                        style: const TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Route Type:",
                        style: TextStyle(color: Color(0xFF888888), fontSize: 16)),
                    Text("Both",
                        style: const TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Start Date:", style: TextStyle(color: Color(0xFF888888), fontSize: 16)),
                    Text(dates["startDate"]!,
                        style: const TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("End Date:",
                        style: TextStyle(color: Color(0xFF888888), fontSize: 16)),
                    Text(dates["endDate"]!,
                        style: const TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Center(
              child: const Text(
                "Route: Kopri To Yantra Park And Return Via-Teen Hath Naka",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> getMonthStartAndEndDates() {
    DateTime now = DateTime.now();
    String startDate = DateFormat("d MMM, yyyy").format(DateTime(now.year, now.month, 1));
    String endDate = DateFormat("d MMM, yyyy").format(DateTime(now.year, now.month + 1, 0));

    return {"startDate": startDate, "endDate": endDate};
  }
}
