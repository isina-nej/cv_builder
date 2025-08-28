# Custom Fonts

This directory is for custom font files.

## Adding Custom Fonts

1. Place your font files (.ttf, .otf) in this directory
2. Update the `pubspec.yaml` file to include the fonts:

```yaml
flutter:
  fonts:
    - family: CustomFont
      fonts:
        - asset: assets/fonts/custom/CustomFont-Regular.ttf
        - asset: assets/fonts/custom/CustomFont-Bold.ttf
          weight: 700
```

3. Use the font in your theme:

```dart
TextStyle(
  fontFamily: 'CustomFont',
  fontWeight: FontWeight.bold,
)
```

## Recommended Fonts for CV Builder

- **Inter**: Modern, clean, highly readable
- **Roboto**: Professional, widely used
- **Open Sans**: Friendly, approachable
- **Lato**: Contemporary, versatile
- **Poppins**: Modern, geometric

## Font Licensing

Ensure you have proper licensing for any commercial fonts used in your application.
