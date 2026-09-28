import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';

class ModuleFeatureCard extends StatelessWidget {
  const ModuleFeatureCard({
    required this.feature,
    required this.onTap,
    super.key,
  });

  final LearningFeature feature;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F3E9),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF3E8E55).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(feature.icon, color: const Color(0xFF3E8E55), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.title,
                      style: const TextStyle(
                        color: Color(0xFF1C2A23),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      feature.description,
                      style: TextStyle(
                        color: const Color(0xFF1C2A23).withValues(alpha: 0.72),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFF3E8E55),
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
