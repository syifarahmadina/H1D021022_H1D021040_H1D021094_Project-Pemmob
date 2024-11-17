import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Name
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlD7qaf4LID9rWg7jwxs5Ex6SaVkLreN33gQ&s'), // Dummy profile picture
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Joshua Hong', // Dummy Name
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Center(
              child: Text(
                'joshuji@gmail.com', // Dummy Email
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),

            // Profile Info Section
            Text(
              'Profile Information:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _ProfileInfoRow(
              label: 'Full Name',
              value: 'Joshua Hong', // Dummy name value
            ),
            _ProfileInfoRow(
              label: 'Email',
              value: 'joshuji@gmail.com', // Dummy email value
            ),
            _ProfileInfoRow(
              label: 'Phone Number',
              value: '+12345678910', // Dummy phone number
            ),

            const SizedBox(height: 32),

            // Settings Section
            Text(
              'Settings:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Change Password Screen
              },
            ),
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () {
                // Implement Logout functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for profile info row
class _ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileInfoRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
