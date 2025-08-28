# Professional CV Builder

A modern, feature-rich Flutter application for creating professional CVs and resumes with multiple templates, real-time preview, and export capabilities.

## Features

- 🎨 **Multiple Professional Templates**: Choose from various modern CV templates
- 📱 **Responsive Design**: Works seamlessly on mobile, tablet, and web
- 🌙 **Dark/Light Theme**: Automatic theme switching with system preference support
- 🌍 **Multi-language Support**: English and Persian (Farsi) localization
- 📄 **Multiple Export Formats**: PDF, DOCX, and HTML export options
- 🖼️ **Photo Integration**: Add professional photos to your CV
- 📊 **Skills Visualization**: Interactive skill level indicators
- 🎯 **Real-time Preview**: See changes instantly as you edit
- 💾 **Auto-save**: Your progress is automatically saved
- 🔒 **Privacy-focused**: All data stored locally on your device

## Screenshots

*Add screenshots of your app here*

## Installation

1. **Prerequisites**
   - Flutter SDK (3.8.1 or higher)
   - Dart SDK
   - Android Studio / VS Code with Flutter extensions

2. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/cv_builder.git
   cd cv_builder
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Building

### Android APK
```bash
flutter build apk --release
```

### iOS (macOS only)
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── app.dart                  # Main app widget with providers
├── config/
│   ├── routes/              # App routing configuration
│   ├── themes/              # Theme and styling
│   └── l10n/                # Localization
├── core/
│   ├── providers/           # State management
│   └── utils/               # Utilities and constants
├── features/
│   └── cv_builder/
│       ├── models/          # Data models
│       ├── screens/         # UI screens
│       └── widgets/         # Reusable widgets
└── services/                # Export and other services
```

## Technologies Used

- **Flutter**: UI framework
- **Dart**: Programming language
- **Provider**: State management
- **PDF Package**: PDF generation
- **Shared Preferences**: Local data storage
- **Google Fonts**: Typography
- **Flutter Animate**: Animations
- **Lottie**: Vector animations

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@cvbuilder.com or create an issue in this repository.

## Roadmap

- [ ] Add more CV templates
- [ ] Cloud backup and sync
- [ ] Advanced PDF customization
- [ ] LinkedIn integration
- [ ] CV scoring and suggestions
- [ ] Multi-page CV support
