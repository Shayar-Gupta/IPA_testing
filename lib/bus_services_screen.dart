import 'package:etms_flutter/digital_buspass.dart';
import 'package:etms_flutter/edit_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:etms_flutter/datastore_manager.dart';

class BusServicesScreen extends StatefulWidget {
  const BusServicesScreen({super.key});

  @override
  State<BusServicesScreen> createState() => _BusServicesScreenState();
}

class _BusServicesScreenState extends State<BusServicesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userName = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();

     // Show Announcement Popup on Screen Load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAnnouncementDialog();
    });
  }

  Future<void> _loadUserData() async {
    String username = await DataStoreManager.getUsername(); // Use DataStoreManager
    if (mounted) {
      setState(() {
        userName = username;
      });
    }
  }

   // Function to Show the Announcement Popup
  void _showAnnouncementDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing when tapped outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // Covers 90% of screen width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with Icon and Title
                Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 31, 112, 34),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Image.asset(
                    'assets/speaker.jpg', // Replace with your actual image path
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Announcement",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                // Announcement Image
                Image.asset(
                    'assets/bus_announcement.jpg', // Replace with your actual image path
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.cover,
            ),

                // OK Button
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(182, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerContent(userName: userName),
        appBar: AppBar(
          title: const Text("Digital Bus Pass", style: TextStyle(color: Colors.white, fontSize: 18.0)),
          backgroundColor: Color(0xFF431B76),
          
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            padding: EdgeInsets.only(right: 12.0),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white,),
              onPressed: () {
                // Handle notifications
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DigitalBusPass(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
      
            // Bottom-Centered Image with 16dp Padding
            Padding(
              padding: const EdgeInsets.only(bottom: 16), // 16.dp padding from bottom
              child: Center(
                child: Image.asset('assets/tcs_logo.jpg', width: 180, height: 120),
              ),
            ),
          ],
        ),
      );
  }
}

class DrawerContent extends StatelessWidget {
  final String userName;

  const DrawerContent({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: const Color(0xFF431B76),
            padding: const EdgeInsets.only(top: 48.0, bottom: 8.0, left: 16.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Hi, ${userName.toUpperCase()}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          DrawerItem(
            icon: Icons.home,
            text: "Home",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusServicesScreen()),
              );
            },
          ),
          DrawerItem(
            icon: Icons.directions_bus,
            text: "Apply Bus Pass",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditUserDetailsScreen()),
              );
            },
          ),
          DrawerItem(
              icon: Icons.list,
              text: "Bus Pass Request Status",
              onTap: () {}),
          DrawerItem(
              icon: Icons.home_filled,
              text: "Back To Home Page",
              onTap: () {}),
          DrawerItem(icon: Icons.settings, text: "Settings", onTap: () {}),
          DrawerItem(icon: Icons.logout, text: "Logout", onTap: () {}),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700], size: 30),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
