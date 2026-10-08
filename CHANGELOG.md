## 0.1.0

### 🎉 Major Customization Overhaul & New Features
* **Expanded `GlassContainer` Customization**:
  * **Directional Blur**: Added `blurX` and `blurY` for independent horizontal and vertical blur control.
  * **TileMode & Custom Filters**: Added `tileMode` support (`TileMode.clamp`, `TileMode.mirror`, etc.) and `customFilter` for custom `ImageFilter`s.
  * **Performance Toggle**: Added `isBlurEnabled` to conditionally bypass blur for low-spec devices or battery-saving modes.
  * **Shapes & Asymmetric Radii**: Added `shape: BoxShape.circle` (circular glass avatars, badges) and `customBorderRadius` (`BorderRadiusGeometry`) for asymmetric corner radii.
  * **Refraction Gradient Borders**: True gradient border rendering using `GlassBorderPainter` via `borderGradient`, customizable `borderWidth`, and `borderColor`.
  * **Fill & Background Control**: Added dedicated `gradient` fill support, `useDefaultGradient` toggle, and customizable tint opacity.
  * **Shadows & Glow**: Added `boxShadow` support (outer shadows that aren't clipped by BackdropFilter) and built-in `elevation` + `shadowColor` soft glow.
  * **Interactive Touch Feedback**: Added built-in `onTap`, `onLongPress`, `onDoubleTap`, `splashColor`, `highlightColor`, `hoverColor`, and custom cursors.
  * **Layout Flexibility**: Added `constraints`, `margin`, `alignment`, `clipBehavior`, and `transform` / `transformAlignment`.

* **New Ready-to-Use Glass Components**:
  * **`GlassTheme` & `GlassThemeData`**: App-wide inherited theming system to configure consistent glass styling across an entire app.
  * **`GlassCard`**: Ready-to-use frosted card widget with support for structured headers (`leading`, `title`, `subtitle`, `trailing`) or custom children.
  * **`GlassButton`**: Frosted action button with animated press micro-interactions, icons, labels, and built-in loading indicator state.
  * **`GlassIconButton`**: Circular or rounded glass icon button with tooltip and tap ripple.
  * **`GlassTextField`**: Frosted text field with dynamic focus animations, glow borders, and input decorations.
  * **`GlassAppBar`**: Frosted glass `PreferredSizeWidget` navigation bar for apps extending behind the app bar.
  * **`GlassListTile` & `GlassDivider`**: Frosted list tile and subtle glowing glass divider for settings and dashboards.

* **Developer Experience & Tooling**:
  * Added comprehensive unit and widget test suite.
  * Overhauled example app with a full Showcase Gallery and a real-time **Interactive Customizer Playground**.

## 0.0.5

added extensic documantation

## 0.0.4

updated the documentation

## 0.0.3

Updated code

## 0.0.2

Added screenshots for better understanding of package.

## 0.0.1

Initial Release
