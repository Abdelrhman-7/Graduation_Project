import 'package:flutter/material.dart';

class NotificationsDrawer extends StatelessWidget {
  const NotificationsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      'Appointment Reminder',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'You have an appointment with John Doe in 1 hour.',
                    ),
                    trailing: Text(
                      '10m',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check, color: Colors.white, size: 20),
                    ),
                    title: Text(
                      'Lab Result Available',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Complete blood count results are ready.'),
                    trailing: Text(
                      '2h',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.message, color: Colors.white, size: 20),
                    ),
                    title: Text(
                      'New Message',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Emma Watson sent you a new message.'),
                    trailing: Text(
                      '5h',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
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
