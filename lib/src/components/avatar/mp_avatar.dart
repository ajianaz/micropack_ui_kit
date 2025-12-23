import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_avatar_enums.dart';

/// MPAvatar - Theme-aware avatar component
///
/// This component provides a versatile avatar with multiple content types,
/// sizes, and shape variants. Supports images, initials, icons, and
/// placeholder states.
///
/// Example:
/// ```dart
/// MPAvatar(
///   name: 'John Doe',
///   type: MPAvatarType.initials,
///   size: MPAvatarSize.medium,
/// )
/// ```
class MPAvatar extends StatelessWidget {
  const MPAvatar({
    super.key,
    this.name,
    this.imageUrl,
    this.imageProvider,
    this.type = MPAvatarType.initials,
    this.size = MPAvatarSize.medium,
    this.shape = MPAvatarShape.circle,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.badge,
    this.semanticLabel,
    this.borderRadius,
  });

  /// The name used for initials (when type is initials).
  final String? name;

  /// The URL of the image to load.
  final String? imageUrl;

  /// Custom image provider.
  final ImageProvider? imageProvider;

  /// The content type of the avatar.
  final MPAvatarType type;

  /// The size of the avatar.
  final MPAvatarSize size;

  /// The shape of the avatar.
  final MPAvatarShape shape;

  /// Custom icon (when type is icon).
  final IconData? icon;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom text color.
  final Color? textColor;

  /// Optional badge to display on avatar.
  final Widget? badge;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Custom border radius (for rounded square shape).
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final config = _MPAvatarConfig();
    final avatarSize = config.getSize(size);

    return Semantics(
      label: semanticLabel ?? name ?? 'Avatar',
      child: SizedBox(
        width: avatarSize,
        height: avatarSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildAvatar(context, config, avatarSize),
            if (badge != null) _buildBadge(context, config, avatarSize),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    _MPAvatarConfig config,
    double avatarSize,
  ) {
    final bgColor = backgroundColor ??
        config.getBackgroundColor(type, name, context);
    final txtColor = textColor ?? config.getTextColor(bgColor, context);

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: shape == MPAvatarShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: shape == MPAvatarShape.roundedSquare
            ? BorderRadius.circular(
                borderRadius ?? config.getDefaultBorderRadius(size),
              )
            : null,
        border: Border.all(
          color: context.mp.borderColor,
          width: config.getBorderWidth(size),
        ),
      ),
      child: _buildContent(context, config, avatarSize, txtColor),
    );
  }

  Widget _buildContent(
    BuildContext context,
    _MPAvatarConfig config,
    double avatarSize,
    Color txtColor,
  ) {
    switch (type) {
      case MPAvatarType.image:
        if (imageUrl != null) {
          return ClipRRect(
            borderRadius: shape == MPAvatarShape.roundedSquare
                ? BorderRadius.circular(
                    borderRadius ?? config.getDefaultBorderRadius(size),
                  )
                : BorderRadius.circular(avatarSize / 2),
            child: Image.network(
              imageUrl!,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildFallback(context, config, avatarSize, txtColor);
              },
            ),
          );
        } else if (imageProvider != null) {
          return ClipRRect(
            borderRadius: shape == MPAvatarShape.roundedSquare
                ? BorderRadius.circular(
                    borderRadius ?? config.getDefaultBorderRadius(size),
                  )
                : BorderRadius.circular(avatarSize / 2),
            child: Image(
              image: imageProvider!,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildFallback(context, config, avatarSize, txtColor);
              },
            ),
          );
        }
        return _buildFallback(context, config, avatarSize, txtColor);

      case MPAvatarType.initials:
        final initials = config.getInitials(name);
        return Center(
          child: MPText(
            initials,
            style: TextStyle(
              color: txtColor,
              fontSize: config.getFontSize(size),
              fontWeight: FontWeight.w600,
            ),
          ),
        );

      case MPAvatarType.icon:
        final defaultIcon = icon ?? Icons.person;
        return Icon(
          defaultIcon,
          color: txtColor,
          size: config.getIconSize(size),
        );

      case MPAvatarType.placeholder:
        return Icon(
          Icons.person_outline,
          color: txtColor,
          size: config.getIconSize(size),
        );
    }
  }

  Widget _buildFallback(
    BuildContext context,
    _MPAvatarConfig config,
    double avatarSize,
    Color txtColor,
  ) {
    final initials = config.getInitials(name);
    return Center(
      child: MPText(
        initials,
        style: TextStyle(
          color: txtColor,
          fontSize: config.getFontSize(size),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBadge(
    BuildContext context,
    _MPAvatarConfig config,
    double avatarSize,
  ) {
    return Positioned(
      right: -4,
      bottom: -4,
      child: Transform.scale(
        scale: config.getBadgeScale(size),
        child: badge,
      ),
    );
  }
}

/// Configuration class for MPAvatar
class _MPAvatarConfig {
  // Predefined colors for fallback
  static const List<Color> _avatarColors = [
    Color(0xFFEF4444), // Red
    Color(0xFFF97316), // Orange
    Color(0xFFF59E0B), // Amber
    Color(0xFF10B981), // Emerald
    Color(0xFF3B82F6), // Blue
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEC4899), // Pink
  ];

  double getSize(MPAvatarSize size) {
    switch (size) {
      case MPAvatarSize.xs:
        return 24.0;
      case MPAvatarSize.small:
        return 32.0;
      case MPAvatarSize.medium:
        return 40.0;
      case MPAvatarSize.large:
        return 56.0;
      case MPAvatarSize.xl:
        return 72.0;
      case MPAvatarSize.xxl:
        return 96.0;
    }
  }

  double getFontSize(MPAvatarSize size) {
    switch (size) {
      case MPAvatarSize.xs:
        return 10.0;
      case MPAvatarSize.small:
        return 12.0;
      case MPAvatarSize.medium:
        return 14.0;
      case MPAvatarSize.large:
        return 18.0;
      case MPAvatarSize.xl:
        return 22.0;
      case MPAvatarSize.xxl:
        return 28.0;
    }
  }

  double getIconSize(MPAvatarSize size) {
    switch (size) {
      case MPAvatarSize.xs:
        return 14.0;
      case MPAvatarSize.small:
        return 18.0;
      case MPAvatarSize.medium:
        return 22.0;
      case MPAvatarSize.large:
        return 28.0;
      case MPAvatarSize.xl:
        return 36.0;
      case MPAvatarSize.xxl:
        return 48.0;
    }
  }

  double getBorderWidth(MPAvatarSize size) {
    switch (size) {
      case MPAvatarSize.xs:
      case MPAvatarSize.small:
      case MPAvatarSize.medium:
        return 1.0;
      case MPAvatarSize.large:
      case MPAvatarSize.xl:
      case MPAvatarSize.xxl:
        return 2.0;
    }
  }

  double getDefaultBorderRadius(MPAvatarSize size) {
    switch (size) {
      case MPAvatarSize.xs:
        return 6.0;
      case MPAvatarSize.small:
        return 8.0;
      case MPAvatarSize.medium:
        return 10.0;
      case MPAvatarSize.large:
        return 14.0;
      case MPAvatarSize.xl:
        return 18.0;
      case MPAvatarSize.xxl:
        return 24.0;
    }
  }

  double getBadgeScale(MPAvatarSize size) {
    switch (size) {
      case MPAvatarSize.xs:
        return 0.7;
      case MPAvatarSize.small:
        return 0.8;
      case MPAvatarSize.medium:
        return 0.9;
      case MPAvatarSize.large:
        return 1.0;
      case MPAvatarSize.xl:
        return 1.0;
      case MPAvatarSize.xxl:
        return 1.0;
    }
  }

  Color getBackgroundColor(
    MPAvatarType type,
    String? name,
    BuildContext context,
  ) {
    if (type == MPAvatarType.placeholder) {
      return context.mp.dividerColor;
    }
    return _getColorForName(name ?? '');
  }

  Color getTextColor(Color backgroundColor, BuildContext context) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  String getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';

    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  Color _getColorForName(String name) {
    if (name.isEmpty) return _avatarColors[4]; // Default blue

    // Calculate hash from name
    var hash = 0;
    for (var i = 0; i < name.length; i++) {
      hash = name.codeUnitAt(i) + ((hash << 5) - hash);
    }

    // Use hash to select color
    return _avatarColors[hash.abs() % _avatarColors.length];
  }
}
