# 🌿 Fluent — Language Learning App

A beginner-friendly Flutter language learning app built with Deep Forest Green theming.

## Prerequisites

| Tool | Version |
|---|---|
| Flutter SDK | ≥ 3.0.0 |
| Android Studio | Hedgehog or newer |
| Android SDK | API 21+ |
| Java | 17 (bundled with Android Studio) |

---

## How to Open in Android Studio

1. Open **Android Studio**
2. Click **File → Open**
3. Navigate to this folder: `fluento/`
4. Click **OK** — Android Studio detects it as a Flutter project
5. Wait for Gradle sync to complete (bottom status bar)

---

## How to Run

### Via Android Studio
1. Select a device from the device dropdown (emulator or physical)
2. Press the **▶ Run** button (or `Shift+F10`)

### Via Terminal
```bash
flutter pub get
flutter run
```

---

## Project Structure

```
fluento/
├── assets/images/logo.png       ← App logo (Fluent F-leaf icon)
├── lib/
│   ├── main.dart                ← Entry point & global theme
│   ├── screens/
│   │   ├── splash_screen.dart   ← 3-second animated splash
│   │   ├── login_screen.dart    ← Email/password login
│   │   ├── register_screen.dart ← New account registration
│   │   └── home_screen.dart     ← Main dashboard
│   └── widgets/
│       └── custom_button.dart   ← Reusable green button
├── android/                     ← Android platform files
├── ios/                         ← iOS platform files
├── test/widget_test.dart        ← Basic smoke test
└── pubspec.yaml                 ← Dependencies & assets
```

---

## Color Palette

| Name | Hex |
|---|---|
| Deep Forest Green (background) | `#0F3822` |
| Leaf Green (buttons/accents) | `#3E8E55` |
| Soft Warm Cream (cards/text) | `#FDFBF7` |
| Sage (muted text) | `#6B8C7A` |

---

## Troubleshooting

**Gradle sync fails** → Make sure Android SDK is installed via Android Studio SDK Manager.

**`flutter pub get` fails** → Run `flutter doctor` and resolve any issues shown.

**Logo not showing** → Ensure `assets/images/logo.png` exists and `pubspec.yaml` declares it.
