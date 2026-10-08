import 'package:flutter/material.dart';
import 'package:glass_morphism_plus/glass_morphism_plus.dart';

void main() => runApp(const GlassDemoApp());

/// A showcase app highlighting the extensive customization options of [glass_morphism_plus].
class GlassDemoApp extends StatelessWidget {
  const GlassDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glassmorphism Plus Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const GlassShowcaseHome(),
    );
  }
}

class GlassShowcaseHome extends StatefulWidget {
  const GlassShowcaseHome({super.key});

  @override
  State<GlassShowcaseHome> createState() => _GlassShowcaseHomeState();
}

class _GlassShowcaseHomeState extends State<GlassShowcaseHome> {
  int _currentIndex = 0;

  static const String bgImageUrl =
      'https://images.unsplash.com/photo-1550684848-fac1c5b4e853';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: GlassAppBar(
        title: Text(
          _currentIndex == 0 ? 'Showcase Gallery' : 'Live Customizer',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          GlassIconButton(
            size: 38,
            icon: const Icon(Icons.info_outline, size: 20, color: Colors.white),
            tooltip: 'About',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Glassmorphism Plus: 100% customizable frosted glass!',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(bgImageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: IndexedStack(
          index: _currentIndex,
          children: const [ShowcaseGalleryView(), InteractiveCustomizerView()],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: GlassContainer(
            height: 64,
            borderRadius: 32,
            blur: 25,
            opacity: 0.15,
            borderWidth: 1.5,
            borderGradient: const LinearGradient(
              colors: [Colors.white54, Colors.white12],
            ),
            elevation: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.grid_view_rounded, 'Gallery'),
                _buildNavItem(1, Icons.tune_rounded, 'Customizer'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white60,
              size: 22,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Gallery view containing Profile, Dashboard, and Login screens.
class ShowcaseGalleryView extends StatelessWidget {
  const ShowcaseGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        _buildProfileScreen(context),
        _buildDashboardScreen(context),
        _buildLoginScreen(context),
      ],
    );
  }

  // --- SCREEN 1: PROFILE ---
  Widget _buildProfileScreen(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: GlassContainer(
          width: 330,
          margin: const EdgeInsets.all(20),
          blur: 20,
          opacity: 0.15,
          borderRadius: 32,
          padding: const EdgeInsets.all(25),
          borderGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white70, Colors.white12],
          ),
          elevation: 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 54,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                    backgroundColor: Colors.blueGrey,
                  ),
                  GlassIconButton(
                    size: 34,
                    icon: const Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.tealAccent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Amit K.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Flutter Engineer',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn('Packages', '3'),
                  _buildStatColumn('Stars', '1.2k'),
                  _buildStatColumn('Commits', '9k'),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GlassButton(
                      label: const Text('Follow'),
                      icon: const Icon(Icons.person_add_rounded, size: 18),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  GlassIconButton(
                    icon: const Icon(Icons.message_rounded, size: 18),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Back, Amit',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Swipe left/right to view other screens',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(16),
                  elevation: 6,
                  borderGradient: const LinearGradient(
                    colors: [Colors.tealAccent, Colors.transparent],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.assignment,
                        color: Colors.tealAccent,
                        size: 28,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Active Tasks',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Text(
                        '17',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GlassCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(16),
                  elevation: 6,
                  borderGradient: const LinearGradient(
                    colors: [Colors.orangeAccent, Colors.transparent],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.bar_chart,
                        color: Colors.orangeAccent,
                        size: 28,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Revenue (NPR)',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Text(
                        '112.5k',
                        style: TextStyle(
                          fontSize: 28,
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
          const SizedBox(height: 24),
          const Text(
            'Recent Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          GlassListTile(
            leading: const Icon(Icons.rocket_launch, color: Colors.pinkAccent),
            title: const Text('New Release Published'),
            subtitle: const Text('Version 0.1.0 is now live on Pub.dev'),
            trailing: const Icon(Icons.chevron_right, color: Colors.white54),
            onTap: () {},
          ),
          const GlassDivider(indent: 16, endIndent: 16),
          GlassListTile(
            leading: const Icon(Icons.star, color: Colors.amberAccent),
            title: const Text('New Star Received'),
            subtitle: const Text('amit142857/glass_morphism_plus'),
            trailing: const Icon(Icons.chevron_right, color: Colors.white54),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // --- SCREEN 3: LOGIN PANEL ---
  Widget _buildLoginScreen(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: GlassContainer(
          width: 330,
          margin: const EdgeInsets.all(20),
          blur: 25,
          opacity: 0.2,
          borderRadius: 28,
          padding: const EdgeInsets.all(28),
          borderGradient: const LinearGradient(
            colors: [Colors.white70, Colors.white12],
          ),
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.security, color: Colors.white, size: 50),
              const SizedBox(height: 15),
              const Text(
                'Verify Access',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              const GlassTextField(
                labelText: 'Employee ID',
                prefixIcon: Icon(Icons.badge_outlined, color: Colors.white70),
                initialValue: 'Drop-1234',
              ),
              const SizedBox(height: 16),
              const GlassTextField(
                labelText: 'Security Key',
                prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
                obscureText: true,
                initialValue: 'password123',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: GlassButton(
                  label: const Text('Authenticate'),
                  icon: const Icon(Icons.login_rounded),
                  borderGradient: const LinearGradient(
                    colors: [Colors.tealAccent, Colors.blueAccent],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Interactive Customizer Playground allowing real-time adjustment of all parameters.
class InteractiveCustomizerView extends StatefulWidget {
  const InteractiveCustomizerView({super.key});

  @override
  State<InteractiveCustomizerView> createState() =>
      _InteractiveCustomizerViewState();
}

class _InteractiveCustomizerViewState extends State<InteractiveCustomizerView> {
  double _blur = 20.0;
  double _opacity = 0.15;
  double _borderRadius = 24.0;
  double _borderWidth = 1.5;
  double _elevation = 8.0;
  bool _useGradientBorder = true;
  bool _isCircle = false;
  Color _selectedColor = Colors.white;

  final List<Color> _palette = [
    Colors.white,
    Colors.cyan,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 80, 16, 90),
      child: Column(
        children: [
          // Live Preview Area
          Center(
            child: GlassContainer(
              width: _isCircle ? 180 : 260,
              height: 180,
              blur: _blur,
              opacity: _opacity,
              borderRadius: _borderRadius,
              borderWidth: _borderWidth,
              shape: _isCircle ? BoxShape.circle : BoxShape.rectangle,
              color: _selectedColor,
              elevation: _elevation,
              borderGradient: _useGradientBorder
                  ? LinearGradient(
                      colors: [
                        _selectedColor.withValues(alpha: 0.8),
                        _selectedColor.withValues(alpha: 0.1),
                      ],
                    )
                  : null,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isCircle ? Icons.lens_blur : Icons.auto_awesome,
                      color: _selectedColor,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Live Glass',
                      style: TextStyle(
                        color: _selectedColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Control Panel
          GlassCard(
            elevation: 4,
            padding: const EdgeInsets.all(20),
            borderRadius: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customization Controls',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Blur Slider
                _buildSlider(
                  label: 'Blur Intensity',
                  value: _blur,
                  min: 0,
                  max: 50,
                  onChanged: (v) => setState(() => _blur = v),
                ),

                // Opacity Slider
                _buildSlider(
                  label: 'Opacity',
                  value: _opacity,
                  min: 0.0,
                  max: 0.8,
                  onChanged: (v) => setState(() => _opacity = v),
                ),

                // Border Radius Slider (only if not circle)
                if (!_isCircle)
                  _buildSlider(
                    label: 'Border Radius',
                    value: _borderRadius,
                    min: 0,
                    max: 50,
                    onChanged: (v) => setState(() => _borderRadius = v),
                  ),

                // Border Width Slider
                _buildSlider(
                  label: 'Border Width',
                  value: _borderWidth,
                  min: 0,
                  max: 6,
                  onChanged: (v) => setState(() => _borderWidth = v),
                ),

                // Elevation Slider
                _buildSlider(
                  label: 'Elevation',
                  value: _elevation,
                  min: 0,
                  max: 20,
                  onChanged: (v) => setState(() => _elevation = v),
                ),

                const SizedBox(height: 12),
                // Color Selection
                const Text(
                  'Glass Tint Color',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: _palette.map((color) {
                    final isSel = _selectedColor == color;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSel
                              ? Border.all(color: Colors.white, width: 2.5)
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),
                // Toggles
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Gradient Border',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: _useGradientBorder,
                  onChanged: (v) => setState(() => _useGradientBorder = v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Circular Shape',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: _isCircle,
                  onChanged: (v) => setState(() => _isCircle = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: _selectedColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
