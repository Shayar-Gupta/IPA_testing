import 'package:flutter/material.dart';
import 'package:etms_flutter/datastore_manager.dart';

class EditUserDetailsScreen extends StatefulWidget {
  const EditUserDetailsScreen({super.key});

  @override
  _EditUserDetailsScreenState createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  // Load saved user details from SharedPreferences
  Future<void> _loadUserDetails() async {
    String username = await DataStoreManager.getUsername();
    String employeeId = await DataStoreManager.getEmployeeID();

    setState(() {
      _nameController.text = username;
      _employeeIdController.text = employeeId;
    });
  }

  // Save user details to SharedPreferences
  Future<void> _saveUserDetails() async {
    String name = _nameController.text.trim();
    String employeeId = _employeeIdController.text.trim();

    if (name.isNotEmpty && employeeId.isNotEmpty) {
      await DataStoreManager.saveUserDetails(name, employeeId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Details Saved Successfully")),
      );

      // Close the app (similar to finishAffinity in Android)
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill out all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enter User Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),

            // Name Input Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),

            // Employee ID Input Field
            TextField(
              controller: _employeeIdController,
              decoration: InputDecoration(
                labelText: "Employee ID",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _saveUserDetails,
              child: Text("Save Details"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _employeeIdController.dispose();
    super.dispose();
  }
}

