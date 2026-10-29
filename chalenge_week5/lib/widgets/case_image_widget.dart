import 'package:flutter/material.dart';

class CaseImageWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const CaseImageWidget({
    Key? key,
    required this.imageUrl,
    this.title = 'Phone Case',
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  }) : super(key: key);

  List<Color> _getCaseGradient(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('magsafe') || lower.contains('clear')) {
      return [const Color(0xFFE2E8F0), const Color(0xFF94A3B8)];
    } else if (lower.contains('black') || lower.contains('armor') || lower.contains('rugged')) {
      return [const Color(0xFF1E293B), const Color(0xFF0F172A)];
    } else if (lower.contains('hologram') || lower.contains('wave') || lower.contains('aesthetic')) {
      return [const Color(0xFFEC4899), const Color(0xFF8B5CF6), const Color(0xFF06B6D4)];
    } else if (lower.contains('leather') || lower.contains('retro')) {
      return [const Color(0xFFB45309), const Color(0xFF78350F)];
    } else if (lower.contains('cyberpunk') || lower.contains('mecha')) {
      return [const Color(0xFF06B6D4), const Color(0xFF3B82F6), const Color(0xFF1E1B4B)];
    } else if (lower.contains('silicone') || lower.contains('blue')) {
      return [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)];
    }
    return [const Color(0xFF6366F1), const Color(0xFF4338CA)];
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(16);

    // If it's a valid network image
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return ClipRRect(
        borderRadius: radius,
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              width: width,
              height: height,
              color: const Color(0xFFF1F5F9),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => _buildFallbackCase(context),
        ),
      );
    }

    // Fallback or stylized case illustration
    return ClipRRect(
      borderRadius: radius,
      child: _buildFallbackCase(context),
    );
  }

  Widget _buildFallbackCase(BuildContext context) {
    final gradientColors = _getCaseGradient(title);
    final isMagSafe = title.toLowerCase().contains('magsafe') || title.toLowerCase().contains('clear');

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF8FAFC),
            const Color(0xFFEEF2F6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          width: (width != null ? width! * 0.7 : 110.0).clamp(60.0, 160.0).toDouble(),
          height: (height != null ? height! * 0.85 : 170.0).clamp(90.0, 240.0).toDouble(),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColors.first.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Glossy reflection overlay
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Camera Bump Island
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  width: 32,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLens(),
                          _buildLens(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLens(),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // MagSafe Ring (if applicable)
              if (isMagSafe)
                Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white70, width: 2),
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              // Brand mark at bottom
              Positioned(
                bottom: 6,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'CH CASE',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.85),
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLens() {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF64748B), width: 1.2),
      ),
      child: Center(
        child: Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: Color(0xFF38BDF8),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

