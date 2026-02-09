# ota_tool

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Ubuntu DEB Build (Fastforge)

Install Fastforge CLI:

```bash
dart pub global activate fastforge
```

Build Ubuntu `.deb` package:

```bash
fastforge package --platform=linux --targets=deb
```

Or run the configured release job:

```bash
fastforge release --name ubuntu
```

Build artifacts are generated in `dist/`.
