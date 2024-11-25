import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utilities/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  /// Show a dialog for the "About" section
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("About FlexTimer"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("App Version: 1.0.0"),
              SizedBox(height: 8),
              Text("Last Updated: November 2024"),
              SizedBox(height: 8),
              Text("Developed by: The FlexTimer Team"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SETTINGS",
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? Colors.white : Colors.teal,
        ),
        elevation: 1,
      ),
      body: Container(
        color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dark Mode Toggle
              ListTile(
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(color: Colors.teal),
                ),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  activeColor: Colors.teal,
                  onChanged: (_) {
                    themeProvider.toggleTheme();
                  },
                ),
              ),
              const Divider(color: Colors.teal),

              // TODO: Notifications Toggle Need to integrate Notifications
              ListTile(
                title: const Text(
                  "Enable Notifications",
                  style: TextStyle(color: Colors.teal),
                ),
                trailing: Switch(
                  value: true, // Replace with actual notification state
                  activeColor: Colors.teal,
                  onChanged: (_) {
                    // Handle notifications toggle
                  },
                ),
              ),
              const Divider(color: Colors.teal),

              // Help Number
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.teal),
                title: const Text("Help Number"),
                subtitle: const Text("713-111-1111"),
                onTap: () {
                  // Show a snackbar with the help number
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Dial 703-111-1111 for help")),
                  );
                },
              ),
              const Divider(color: Colors.teal),

              // Report a Problem
              ListTile(
                leading: const Icon(Icons.email, color: Colors.teal),
                title: const Text("Report a Problem"),
                subtitle: const Text("support@flextimer.com"),
                onTap: () {
                  // Show a snackbar with the email
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email: support@flextimer.com")),
                  );
                },
              ),
              const Divider(color: Colors.teal),

              // About Section
              ListTile(
                leading: const Icon(Icons.info, color: Colors.teal),
                title: const Text("About"),
                onTap: _showAboutDialog,
              ),
              const Divider(color: Colors.teal),
            ],
          ),
        ),
      ),
    );
  }
}
