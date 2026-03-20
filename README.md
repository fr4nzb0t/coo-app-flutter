# Coownable — Flutter Prototype

Asset browsing prototype for [Coownable](https://coownable.com), a fractional ownership platform for art, wine & collectibles.

Built with Flutter + Material 3. Designed using the [A List Apart Priority Guide](https://alistapart.com/article/priority-guides-a-content-first-alternative-to-wireframes/) methodology.

## Screenshots

Two screens: Browse (asset grid) → Detail (hero image + investment info).

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x+)
- Xcode (for iOS) or Android Studio (for Android)
- CocoaPods (`sudo gem install cocoapods`) for iOS

Verify your setup:

```bash
flutter doctor
```

## Getting Started

```bash
# Clone
git clone git@github.com:fr4nzb0t/coo-app-flutter.git
cd coo-app-flutter

# Install dependencies
flutter pub get

# Run on iOS Simulator
open -a Simulator
flutter run

# Run on Android emulator
flutter emulators --launch <emulator_id>
flutter run

# Run on a connected device
flutter run -d <device_id>

# List available devices
flutter devices
```

## Running on Specific Platforms

### iOS Simulator

```bash
# List available simulators
xcrun simctl list devices available

# Boot a specific simulator
xcrun simctl boot "iPhone 16 Pro"

# Run
flutter run -d "iPhone 16 Pro"
```

### iPad Simulator

```bash
xcrun simctl boot "iPad Pro 13-inch (M4)"
flutter run -d "iPad Pro 13-inch (M4)"
```

The app uses adaptive layouts — 2-column grid on iPad, 1-column on iPhone.

### Android Emulator

```bash
# List emulators
flutter emulators

# Launch and run
flutter emulators --launch Pixel_8_API_35
flutter run
```

### Chrome (Web)

```bash
flutter run -d chrome
```

## Project Structure

```
lib/
  main.dart                  # App entry point + Material 3 theme
  models/
    asset.dart               # Asset data model
  data/
    mock_assets.dart         # 8 mock art assets with picsum images
  screens/
    browse_screen.dart       # Scrollable asset grid (home)
    detail_screen.dart       # Asset detail with hero image
  widgets/
    asset_card.dart          # Card component for browse grid
    availability_bar.dart    # Color-coded progress bar
    shimmer_card.dart        # Loading placeholder
  theme/
    app_theme.dart           # Colors, typography, spacing constants
```

## Key Features

- **Hero animation** — image transitions smoothly from card to detail
- **SliverAppBar** — parallax hero image that collapses on scroll
- **Adaptive layout** — 2 columns on tablet (≥600dp), 1 on phone
- **Shimmer loading** — placeholder cards during initial load
- **Pull-to-refresh** — RefreshIndicator on browse screen
- **Material 3** — custom color scheme, typography scale

## Code Quality

```bash
# Analyze for issues
flutter analyze

# Format code
dart format .

# Run tests (when added)
flutter test
```

## Design References

- [Priority Guide](../../.openclaw/workspace/projects/coownable/MOBILE-PRIORITY-GUIDE.md)
- [UI Specification](../../.openclaw/workspace/projects/coownable/MOBILE-UI-SPEC.md)

## Mock Data

Uses placeholder images from `picsum.photos`. The 8 assets represent a curated art gallery with varying availability (4%–91% of shares available) to showcase the availability bar in different states.
