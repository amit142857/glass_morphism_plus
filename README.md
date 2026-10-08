# 💎 Glassmorphism Plus

[![pub package](https://img.shields.io/pub/v/glass_morphism_plus.svg)](https://pub.dev/packages/glass_morphism_plus)
[![likes](https://img.shields.io/pub/likes/glass_morphism_plus.svg)](https://pub.dev/packages/glass_morphism_plus/score)

A high-performance, **100% customizable** Glassmorphism library for Flutter. Create stunning modern UIs with realistic "Frosted Glass" effects, custom refraction gradient borders, directional blur, smooth shadows, and interactive components.

---

## 📸 Showcase

| Profile UI | Dashboard | Security Panel |
| :---: | :---: | :---: |
| <img src="https://github.com/amit142857/glass_morphism_plus/blob/main/assets/screenshots/ss1.png?raw=true" width="250" /> | <img src="https://github.com/amit142857/glass_morphism_plus/blob/main/assets/screenshots/ss2.png?raw=true" width="250" /> | <img src="https://github.com/amit142857/glass_morphism_plus/blob/main/assets/screenshots/ss3.png?raw=true" width="250" /> |

---

## ✨ Features

* 💎 **100% Customizable `GlassContainer`**: Control every detail: blur (uniform or directional `blurX`/`blurY`), opacity, color tints, custom fill gradients, tile mode, and custom image filters.
* 🌈 **True Gradient Borders**: Render realistic light refraction edges using `borderGradient` and `GlassBorderPainter`.
* ⭕ **Flexible Shapes & Corner Radii**: Seamless support for `BoxShape.circle` (circular avatars/badges) or asymmetric `customBorderRadius` (`BorderRadius.only(...)`).
* ☁️ **Outer Shadows & Glow**: Add `boxShadow` or effortless `elevation` that aren't clipped by the backdrop filter.
* 👆 **Built-in Touch Feedback**: Direct support for `onTap`, `onLongPress`, `onDoubleTap`, `splashColor`, and custom cursors.
* 🎨 **App-wide `GlassTheme`**: Define a single theme for your entire application or subtree to keep glass styling consistent.
* 🧩 **Pre-built Frosted Glass Components**:
  * **`GlassCard`**: Ready-to-use card with elevation, margins, and structured header/body.
  * **`GlassButton`**: Interactive frosted button with press micro-animations and loading state.
  * **`GlassIconButton`**: Circular or rounded icon button with tooltip support.
  * **`GlassTextField`**: Frosted input field with dynamic focus glow animations.
  * **`GlassAppBar`**: Frosted navigation bar for `extendBodyBehindAppBar` layouts.
  * **`GlassListTile` & `GlassDivider`**: Sleek frosted list items and divider lines.
* ⚡ **Performance Conscious**: Toggle blur off (`isBlurEnabled: false`) for low-spec devices or battery-saving modes.

---

## 🚀 Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  glass_morphism_plus: ^0.1.0
```

Import the package:

```dart
import 'package:glass_morphism_plus/glass_morphism_plus.dart';
```

---

## 📖 Usage Examples

### 1. Basic Frosted Glass Container

```dart
GlassContainer(
  width: 300,
  height: 200,
  blur: 20,
  opacity: 0.15,
  borderRadius: 24,
  child: Center(
    child: Text(
      'Frosted Glass',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
)
```

### 2. Refraction Gradient Border & Glow

```dart
GlassContainer(
  width: 320,
  height: 180,
  blur: 25,
  opacity: 0.12,
  borderRadius: 28,
  elevation: 10,
  shadowColor: Colors.cyanAccent.withValues(alpha: 0.3),
  borderGradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.cyanAccent.withValues(alpha: 0.8),
      Colors.transparent,
      Colors.purpleAccent.withValues(alpha: 0.6),
    ],
  ),
  child: const Padding(
    padding: EdgeInsets.all(20),
    child: Text('Gradient Border with Glow', style: TextStyle(color: Colors.white)),
  ),
)
```

### 3. Circular Glass Avatar or Badge

```dart
GlassContainer(
  width: 100,
  height: 100,
  shape: BoxShape.circle,
  blur: 15,
  opacity: 0.2,
  borderWidth: 2,
  borderColor: Colors.tealAccent,
  child: const Icon(Icons.security, color: Colors.tealAccent, size: 40),
)
```

### 4. Clickable Glass Container with Haptic Ripple

```dart
GlassContainer(
  borderRadius: 20,
  blur: 15,
  opacity: 0.1,
  elevation: 4,
  onTap: () {
    print('Glass card tapped!');
  },
  padding: const EdgeInsets.all(16),
  child: const Text('Tap Me!', style: TextStyle(color: Colors.white)),
)
```

### 5. App-Wide Theming (`GlassTheme`)

Wrap your app or screen in a `GlassTheme` so every child inherits consistent styling:

```dart
GlassTheme(
  data: GlassThemeData(
    blur: 20.0,
    opacity: 0.15,
    borderRadius: 24.0,
    color: Colors.white,
    borderWidth: 1.5,
    elevation: 6.0,
  ),
  child: Scaffold(
    body: GlassContainer(
      // Automatically inherits blur, opacity, borderRadius, etc.
      child: Text('Themed Glass'),
    ),
  ),
)
```

### 6. Interactive Glass Buttons & Inputs

```dart
// Action Button with micro-animation & loading support
GlassButton(
  label: const Text('Submit Order'),
  icon: const Icon(Icons.shopping_bag_outlined),
  isLoading: false,
  onPressed: () {},
)

// Frosted Text Input with dynamic focus glow
GlassTextField(
  labelText: 'Email Address',
  prefixIcon: Icon(Icons.email_outlined, color: Colors.white70),
  onChanged: (val) {},
)
```

### 7. Frosted Glass Navigation Bar

```dart
Scaffold(
  extendBodyBehindAppBar: true,
  appBar: GlassAppBar(
    title: const Text('Explore'),
    blur: 25,
    opacity: 0.2,
    actions: [
      GlassIconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
    ],
  ),
  body: ListView(...),
)
```

---

## ⚙️ Customization Options

### `GlassContainer` Properties

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget?` | `null` | The content widget inside the glass container. |
| `width` | `double?` | `null` | Container width. |
| `height` | `double?` | `null` | Container height. |
| `constraints` | `BoxConstraints?` | `null` | Sizing constraints. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Internal content padding. |
| `margin` | `EdgeInsetsGeometry?` | `null` | External container margin. |
| `alignment` | `AlignmentGeometry?` | `null` | Child alignment within the container. |
| `blur` | `double?` | `15.0` | Blur intensity (sigmaX and sigmaY). |
| `blurX` | `double?` | `blur` | Horizontal blur intensity override. |
| `blurY` | `double?` | `blur` | Vertical blur intensity override. |
| `tileMode` | `TileMode?` | `TileMode.clamp` | TileMode for the image blur filter. |
| `customFilter` | `ImageFilter?` | `null` | Provide a custom ImageFilter instead of blur. |
| `isBlurEnabled` | `bool?` | `true` | Skips BackdropFilter when false for max FPS. |
| `opacity` | `double?` | `0.1` | Base background tint opacity (0.0 to 1.0). |
| `color` | `Color?` | `Colors.white` | Base glass tint color. |
| `shape` | `BoxShape?` | `BoxShape.rectangle` | Shape: `rectangle` or `circle`. |
| `borderRadius` | `double?` | `20.0` | Corner radius for rectangle shapes. |
| `customBorderRadius`| `BorderRadiusGeometry?` | `null` | Asymmetric corner radii (`BorderRadius.only`). |
| `gradient` | `Gradient?` | `null` | Custom background fill gradient. |
| `useDefaultGradient`| `bool` | `true` | When true, renders a subtle glass fill gradient. |
| `borderGradient` | `Gradient?` | `null` | Gradient for the border refraction stroke. |
| `borderWidth` | `double?` | `1.5` | Border width. Set to `0` to disable border. |
| `borderColor` | `Color?` | auto | Border color when no `borderGradient` is set. |
| `border` | `BoxBorder?` | `null` | Complete custom `BoxBorder` override. |
| `boxShadow` | `List<BoxShadow>?` | `null` | Custom shadows cast behind the container. |
| `elevation` | `double?` | `null` | Shortcut for soft glass drop shadows. |
| `shadowColor` | `Color?` | `Colors.black` | Color used for elevation drop shadow. |
| `clipBehavior` | `Clip?` | `Clip.antiAlias` | Corner clipping behavior. |
| `transform` | `Matrix4?` | `null` | Transformation matrix (e.g. 3D tilt). |
| `onTap` | `VoidCallback?` | `null` | Tap callback with ripple. |
| `onLongPress` | `VoidCallback?` | `null` | Long press callback. |
| `onDoubleTap` | `VoidCallback?` | `null` | Double tap callback. |
| `splashColor` | `Color?` | `null` | Material splash ripple color. |
| `highlightColor` | `Color?` | `null` | Material highlight color on touch down. |
| `hoverColor` | `Color?` | `null` | Hover overlay color on pointer hover. |
| `cursor` | `MouseCursor?` | `null` | Mouse cursor on hover. |

---

## 💡 Best Practices

1. **Dark Modes & Vibrant Backgrounds**: Glassmorphism looks best over rich gradients, vibrant photographs, or dynamic background meshes.
2. **Refraction Borders**: Use `borderGradient` with an asymmetric linear gradient (e.g., top-left light to bottom-right transparent) to simulate physical light reflection.
3. **Performance Optimization**: For long scrolling lists with hundreds of items, consider using `isBlurEnabled: false` or keeping blur under 25 for 60/120 FPS performance on all devices.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.