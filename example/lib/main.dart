import 'package:flutter/material.dart';
import 'package:glass_morphism_plus/glass_morphism_plus.dart';

void main() => runApp(const GlassDemoApp());

/// A high-performance Glassmorphism container for Flutter.
class GlassDemoApp extends StatelessWidget {
  const GlassDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Glass looks best in Dark Mode
      home: const GlassShowcaseHome(),
    );
  }
}

class GlassShowcaseHome extends StatelessWidget {
  const GlassShowcaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    // A vibrant background makes the blur feel necessary
    const String bgImageUrl =
        'https://images.unsplash.com/photo-1550684848-fac1c5b4e853';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(bgImageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          children: [
            _buildProfileScreen(context),
            _buildDashboardScreen(context),
            _buildLoginScreen(context),
          ],
        ),
      ),
    );
  }

  // --- SCREEN 1: PROFILE ---
  Widget _buildProfileScreen(BuildContext context) {
    return Center(
      child: GlassContainer(
        width: 320,
        height: 400,
        blur: 20,
        opacity: 0.15,
        borderRadius: 30,
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              backgroundColor: Colors.blueGrey,
            ),
            const SizedBox(height: 20),
            const Text(
              "Amit K.",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Flutter Engineer",
              style: TextStyle(color: Colors.white70),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn("Packages", "3"),
                _buildStatColumn("Stars", "1.2k"),
                _buildStatColumn("Commits", "9k"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  // --- SCREEN 2: DASHBOARD ---
  Widget _buildDashboardScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Welcome Back, Amit",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // A row of two glass cards
          Row(
            children: [
              Expanded(
                child: GlassContainer(
                  height: 150,
                  blur: 15,
                  opacity: 0.1,
                  borderRadius: 20,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.assignment, color: Colors.tealAccent),
                      Spacer(),
                      Text(
                        "Active Tasks",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "17",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GlassContainer(
                  height: 150,
                  blur: 15,
                  opacity: 0.1,
                  borderRadius: 20,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.bar_chart, color: Colors.orangeAccent),
                      Spacer(),
                      Text(
                        "Revenue (NPR)",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "112.5k",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- SCREEN 3: LOGIN PANEL ---
  Widget _buildLoginScreen(BuildContext context) {
    return Center(
      child: GlassContainer(
        width: 320,
        height: 450,
        blur: 25,
        opacity: 0.2,
        borderRadius: 25,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Icon(Icons.security, color: Colors.white, size: 50),
            const SizedBox(height: 15),
            const Text(
              "Verify Access",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            // Mock Text Fields using Glass
            _buildMockTextField("Employee ID", "Drop-1234"),
            const SizedBox(height: 15),
            _buildMockTextField("Security Key", "********"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {},
                child: const Text(
                  "Authenticate",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMockTextField(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
