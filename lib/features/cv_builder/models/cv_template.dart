// lib/features/cv_builder/models/cv_template.dart
import 'package:flutter/material.dart';

class CVTemplate {
  final String id;
  final String name;
  final String description;
  final String previewPath;
  final Color primaryColor;
  final Color secondaryColor;
  final CVTemplateType type;
  final List<CVTemplateFeature> features;
  final bool isPremium;

  const CVTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.previewPath,
    required this.primaryColor,
    required this.secondaryColor,
    required this.type,
    required this.features,
    this.isPremium = false,
  });
}

enum CVTemplateType {
  modern,
  classic,
  creative,
  minimal,
  professional,
  executive,
}

enum CVTemplateFeature {
  photoSupport,
  skillBars,
  timeline,
  charts,
  icons,
  customColors,
  multiPage,
  portfolio,
  qrCode,
  socialLinks,
}

class CVTemplateData {
  static List<CVTemplate> getAllTemplates() => [
    // Modern Templates
    const CVTemplate(
      id: 'modern_glass',
      name: 'Glass Morphism',
      description: 'Modern glassmorphism design with blur effects',
      previewPath: 'assets/images/templates/modern_glass.png',
      primaryColor: Color(0xFF667EEA),
      secondaryColor: Color(0xFF764BA2),
      type: CVTemplateType.modern,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.icons,
        CVTemplateFeature.customColors,
        CVTemplateFeature.socialLinks,
      ],
      isPremium: true,
    ),

    const CVTemplate(
      id: 'modern_gradient',
      name: 'Gradient Pro',
      description: 'Professional with beautiful gradient accents',
      previewPath: 'assets/images/templates/modern_gradient.png',
      primaryColor: Color(0xFF6C63FF),
      secondaryColor: Color(0xFF3F37C9),
      type: CVTemplateType.modern,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.timeline,
        CVTemplateFeature.icons,
        CVTemplateFeature.customColors,
      ],
    ),

    const CVTemplate(
      id: 'modern_dark',
      name: 'Dark Elite',
      description: 'Sleek dark theme for tech professionals',
      previewPath: 'assets/images/templates/modern_dark.png',
      primaryColor: Color(0xFF1A1A2E),
      secondaryColor: Color(0xFF16213E),
      type: CVTemplateType.modern,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.charts,
        CVTemplateFeature.icons,
        CVTemplateFeature.customColors,
        CVTemplateFeature.portfolio,
      ],
      isPremium: true,
    ),

    // Creative Templates
    const CVTemplate(
      id: 'creative_colorful',
      name: 'Creative Burst',
      description: 'Vibrant and creative design for artists',
      previewPath: 'assets/images/templates/creative_colorful.png',
      primaryColor: Color(0xFFFF6B6B),
      secondaryColor: Color(0xFF4ECDC4),
      type: CVTemplateType.creative,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.customColors,
        CVTemplateFeature.portfolio,
        CVTemplateFeature.icons,
      ],
    ),

    const CVTemplate(
      id: 'creative_minimal',
      name: 'Minimal Artist',
      description: 'Clean minimal design with creative touches',
      previewPath: 'assets/images/templates/creative_minimal.png',
      primaryColor: Color(0xFF2C3E50),
      secondaryColor: Color(0xFFE74C3C),
      type: CVTemplateType.creative,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.timeline,
        CVTemplateFeature.customColors,
        CVTemplateFeature.portfolio,
        CVTemplateFeature.socialLinks,
      ],
    ),

    // Professional Templates
    const CVTemplate(
      id: 'professional_executive',
      name: 'Executive Pro',
      description: 'Premium design for executives and managers',
      previewPath: 'assets/images/templates/professional_executive.png',
      primaryColor: Color(0xFF1E3A8A),
      secondaryColor: Color(0xFF3B82F6),
      type: CVTemplateType.professional,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.timeline,
        CVTemplateFeature.charts,
        CVTemplateFeature.multiPage,
        CVTemplateFeature.qrCode,
      ],
      isPremium: true,
    ),

    const CVTemplate(
      id: 'professional_corporate',
      name: 'Corporate Elite',
      description: 'Corporate-friendly professional design',
      previewPath: 'assets/images/templates/professional_corporate.png',
      primaryColor: Color(0xFF0F172A),
      secondaryColor: Color(0xFF475569),
      type: CVTemplateType.professional,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.timeline,
        CVTemplateFeature.multiPage,
        CVTemplateFeature.socialLinks,
      ],
    ),

    // Classic Templates
    const CVTemplate(
      id: 'classic_traditional',
      name: 'Traditional',
      description: 'Classic professional layout',
      previewPath: 'assets/images/templates/classic_traditional.png',
      primaryColor: Color(0xFF374151),
      secondaryColor: Color(0xFF6B7280),
      type: CVTemplateType.classic,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.timeline,
        CVTemplateFeature.multiPage,
      ],
    ),

    const CVTemplate(
      id: 'classic_elegant',
      name: 'Elegant Classic',
      description: 'Refined classic design with elegant typography',
      previewPath: 'assets/images/templates/classic_elegant.png',
      primaryColor: Color(0xFF92400E),
      secondaryColor: Color(0xFFD97706),
      type: CVTemplateType.classic,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.socialLinks,
      ],
    ),

    // Minimal Templates
    const CVTemplate(
      id: 'minimal_clean',
      name: 'Clean Minimal',
      description: 'Ultra-clean minimal design',
      previewPath: 'assets/images/templates/minimal_clean.png',
      primaryColor: Color(0xFF000000),
      secondaryColor: Color(0xFF6B7280),
      type: CVTemplateType.minimal,
      features: [
        CVTemplateFeature.skillBars,
        CVTemplateFeature.timeline,
        CVTemplateFeature.socialLinks,
      ],
    ),

    const CVTemplate(
      id: 'minimal_modern',
      name: 'Modern Minimal',
      description: 'Contemporary minimal with subtle accents',
      previewPath: 'assets/images/templates/minimal_modern.png',
      primaryColor: Color(0xFF1F2937),
      secondaryColor: Color(0xFF10B981),
      type: CVTemplateType.minimal,
      features: [
        CVTemplateFeature.photoSupport,
        CVTemplateFeature.skillBars,
        CVTemplateFeature.icons,
        CVTemplateFeature.socialLinks,
      ],
    ),
  ];

  static List<CVTemplate> getTemplatesByType(CVTemplateType type) {
    return getAllTemplates()
        .where((template) => template.type == type)
        .toList();
  }

  static List<CVTemplate> getPremiumTemplates() {
    return getAllTemplates().where((template) => template.isPremium).toList();
  }

  static List<CVTemplate> getFreeTemplates() {
    return getAllTemplates().where((template) => !template.isPremium).toList();
  }
}
