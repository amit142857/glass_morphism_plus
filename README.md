# 💎 Glassmorphism Plus

[![pub package](https://img.shields.io/pub/v/glass_morphism_plus.svg)](https://pub.dev/packages/glass_morphism_plus)
[![likes](https://img.shields.io/pub/likes/glass_morphism_plus.svg)](https://pub.dev/packages/glass_morphism_plus/score)

A high-performance, customizable Glassmorphism library for Flutter. Create stunning modern UIs with realistic "Frosted Glass" effects and optimized backdrop filtering.

---

## 📸 Showcase

| Profile UI | Dashboard | Security Panel |
| :---: | :---: | :---: |
| <img src="https://github.com/amit142857/glass_morphism_plus/blob/main/assets/screenshots/ss1.png?raw=true" width="250" /> | <img src="https://github.com/amit142857/glass_morphism_plus/blob/main/assets/screenshots/ss2.png?raw=true" width="250" /> | <img src="https://github.com/amit142857/glass_morphism_plus/blob/main/assets/screenshots/ss3.png?raw=true" width="250" /> |

---

## ✨ Why "Plus"?

Most glassmorphism implementations in Flutter suffer from high CPU usage and "flat" visuals. **Glassmorphism Plus** solves this:

* 🚀 **Optimized Rendering:** Built to handle `BackdropFilter` efficiently to maintain 60 FPS.
* 🎨 **Depth Simulation:** Uses unique dual-layer gradients to simulate light refraction on the edges.
* ⚙️ **Fully Adaptive:** Easily tweak blur intensity, opacity, and color to match any theme.

## 🛠 Features

* **Realistic Blur:** Smooth frosted effect using `ImageFilter.blur`.
* **Gradient Borders:** High-control styling for that "glass edge" look.
* **Clip-Safe:** Handles `ClipRRect` logic automatically—no jagged edges.
* **Versatile:** Perfect for cards, nav bars, and glass panels.

---

## 🚀 Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  glass_morphism_plus: ^1.0.0