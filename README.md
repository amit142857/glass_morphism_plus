<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

💎 Glassmorphism Plus
A high-performance, customizable Glassmorphism library for Flutter. Create stunning modern UIs with realistic "Frosted Glass" effects, shimmering border gradients, and optimized backdrop filtering.

Why "Plus"?

Most glassmorphism implementations in Flutter suffer from two things: high CPU usage and "flat" visuals. Glassmorphism Plus solves this by:

Optimized Rendering: Built to handle BackdropFilter efficiently to maintain 60 FPS even on mid-range devices.

Depth Simulation: Uses a unique dual-layer border gradient to simulate light refraction on the edges of the glass.

Fully Adaptive: Easily tweak blur intensity, opacity, and color to match any theme (Light, Dark, or Vibrant).

Key Features

Realistic Blur: Utilizes ImageFilter.blur for a smooth frosted effect.

Gradient Borders: High-control border styling to create the "glass edge" look.

Clip-Safe: Automatically handles ClipRRect logic so your glass edges never look jagged.

Versatile: Perfect for modern cards, navigation bars, and floating action buttons.

Visual Anatomy

The "Glass" effect is achieved through a specific layering of three components:

The Background: High-contrast images or colors.

The Filter: A blur sigma applied via BackdropFilter.

The Tint: A semi-transparent color overlay to give the glass its "material" feel.

Use Cases

Profiles: Floating profile cards over vibrant backgrounds.

Dashboards: Clean, modern data widgets.

Login Screens: Elegant glass panels for input fields.


## Example

import 'package:flutter/material.dart';
import 'package:glass_morphism_plus/glass_morphism_plus.dart';

class GlassDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1550684848-fac1c5b4e853'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GlassContainer(
            width: 300,
            height: 200,
            blur: 20,
            opacity: 0.15,
            borderRadius: 30,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.ac_unit, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Glassmorphism Plus",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
# glass_morphism_plus
