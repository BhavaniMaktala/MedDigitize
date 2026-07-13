import 'package:flutter/material.dart';
import 'login.dart';
import 'shared_prefs.dart';
import 'scan.dart';
import 'emr_screen.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _userName = 'Doctor';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await SharedPrefs.getName();
    setState(() {
      _userName = name ?? 'Doctor';
    });
  }

  Future<void> _logout() async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await SharedPrefs.logout();
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          ),
          title: const Text(
            'MedDigitize',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(),
            ),
          ],
        ),
        body: [
          HomeContent(userName: _userName),
          const ProfileContent(),
        ][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final String userName;

  const HomeContent({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            'Welcome, $userName!',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _buildCard(context, 'Scan', Icons.camera_alt),
              _buildCard(context, 'Records', Icons.folder),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == 'Scan') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScannerPage()),
          );
        } else if (title == 'Records') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EMRRecordsPage()),
          );
        }
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white.withOpacity(0.2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            FutureBuilder<Map<String, String>>(
              future: SharedPrefs.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (snapshot.hasError) {
                  return const Text(
                    'Error loading profile data',
                    style: TextStyle(color: Colors.white70),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text(
                    'No profile data available',
                    style: TextStyle(color: Colors.white70),
                  );
                }

                final profileData = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileField(
                      'Full Name',
                      profileData['name'] ?? 'N/A',
                    ),
                    const SizedBox(height: 16),
                    _buildProfileField('Email', profileData['email'] ?? 'N/A'),
                    const SizedBox(height: 16),
                    _buildProfileField('Phone', profileData['phone'] ?? 'N/A'),
                    const SizedBox(height: 16),
                    _buildProfileField('Age', profileData['age'] ?? 'N/A'),
                    const SizedBox(height: 16),
                    _buildProfileField(
                      'Hospital',
                      profileData['hospital'] ?? 'N/A',
                    ),
                    const SizedBox(height: 16),
                    _buildProfileField(
                      'Specialization',
                      profileData['specialization'] ?? 'N/A',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}
