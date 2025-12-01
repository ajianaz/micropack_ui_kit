## [0.0.1] - 2025-12-01

### Initial Release

Micropack UI Kit is a comprehensive, customizable, and theme-aware UI kit for Flutter applications. This initial release provides a collection of beautifully designed components that automatically adapt to light and dark themes, ensuring a consistent user experience across your app.

### 🎨 Components Added

#### 🔘 MPButton
- **Variants**: primary, outlined, ghost, text, danger, success, warning, info
- **Sizes**: small, regular, medium, large
- **Features**:
  - Theme-aware colors that adapt to light/dark modes
  - Loading states with animated spinner
  - Icon support with customizable positioning (left, right, top, bottom)
  - Customizable text styles, colors, and font weights
  - Hover, pressed, and focus state colors
  - Accessibility support with semantic labels
  - Full width option and custom padding

#### 📰 MPArticleCard
- **Variants**: standard, elevated, outlined
- **Sizes**: small, medium, large
- **Features**:
  - Image support with network images and error handling
  - Category badges and tag system
  - Metadata display (author, date, read time)
  - Interactive action buttons (like, bookmark, share)
  - Theme-aware colors and shadows
  - Hover and pressed state animations
  - Responsive design with flexible layouts

#### 📝 MPText
- **Types**: head, subhead, body, label, small
- **Features**:
  - Responsive font sizing with ResponsiveFontHelper
  - Theme-aware text colors
  - Customizable font weights, sizes, and styles
  - Text overflow handling and max lines
  - Text alignment and decoration options

#### 📝 MPTextField
- **Types**: DEFAULT, PASSWORD, BORDER, BORDER_PASSWORD
- **Features**:
  - Theme-aware colors and borders
  - Built-in validation with common validators
  - Input formatters (phone, credit card, currency)
  - Password visibility toggle
  - Clear button functionality
  - Character counter and maxLength support
  - Custom icons and labels
  - Error and helper text display
  - Floating label behavior

#### 💬 MPDialog
- **Features**:
  - Responsive design with adaptive sizing
  - Theme-aware background colors
  - Customizable padding and corner radius
  - Scrollable content support
  - Modal barrier behavior

#### 📑 MPTabRounded
- **Variants**: standard, outlined, filled
- **Sizes**: small, medium, large
- **Features**:
  - Theme-aware colors and states
  - Icon and badge support
  - Active/inactive state animations
  - Hover and disabled states
  - Customizable indicators
  - Flexible layout options

#### 🔔 MPSnackbar
- **Types**: success, error, warning, info
- **Features**:
  - Theme-aware colors and icons
  - Auto-dismiss with customizable duration
  - Action button support
  - Floating design with rounded corners
  - Responsive text sizing

### 🎨 Theme System Features

#### Light/Dark Mode Support
- **Automatic theme adaptation** based on system preferences
- **Consistent color schemes** across all components
- **Theme-aware utilities** accessible via context.mp extension

#### MPThemeManager
- **Singleton pattern** for global theme management
- **Theme persistence** with optional SharedPreferences
- **Custom theme support** with import/export functionality
- **Listener system** for theme change notifications
- **Thread-safe async operations**
- **Reset functionality** to restore defaults

#### Theme Utilities (context.mp extension)
- **Primary colors**: primary, primarySurface, primaryFocus, primaryBorder, primaryHover, primaryPressed
- **Neutral scale**: neutral10 through neutral100 for consistent gray tones
- **Semantic colors**: errorColor, successColor, warningColor, infoColor
- **Adaptive colors**: adaptiveBackgroundColor, adaptiveBorderColor, adaptiveShadowColor
- **Text colors**: textColor, subtitleColor, captionColor, disabledColor

#### Responsive Design Support
- **ResponsiveFontHelper** for automatic font scaling
- **Breakpoint system**: Small (<600px), Medium (600-1024px), Large (>1024px)
- **ScreenUtil integration** for consistent sizing across devices
- **Responsive padding and margins** in components

### 📚 Documentation and Examples

#### Comprehensive Documentation
- **Getting Started Guide** with installation and setup instructions
- **Component API Reference** with detailed parameter documentation
- **Theme Configuration Guide** for custom theming
- **Examples** demonstrating all components and features

#### Example Application
- **Interactive demos** of all components
- **Theme showcase** with light/dark mode switching
- **Responsive design examples**
- **Code samples** for common use cases

### 🔧 Developer Experience

#### Initialization
- **Simple setup** with MpUiKit.init() method
- **Custom brand colors** and font configuration
- **Responsive design toggles** and breakpoint customization
- **Custom dialog icons** for different message types

#### Utilities and Extensions
- **ComponentX extension** for skeleton loading animations
- **Input formatters** for common data patterns
- **Validators** for form validation
- **Theme utilities** for consistent styling

### 🌐 Cross-Platform Support
- **Android, iOS, Web, and Desktop** compatibility
- **Platform-specific adaptations** where necessary
- **Consistent behavior** across all platforms

### ♿ Accessibility
- **Semantic labels** for screen readers
- **High contrast support** in themes
- **Focus management** in interactive components
- **Keyboard navigation** support

### 🔒 Dependencies
- **flutter_screenutil** for responsive design
- **flutter_animate** for smooth animations
- **flutter_spinkit** for loading indicators
- **font_awesome_flutter** for icon support
- **google_fonts** for typography
- **gap** for spacing utilities
- **extended_image** for advanced image handling
- **skeletonizer** for loading states

### 🐛 Known Issues
- No known issues at this time

### 🔮 Breaking Changes
- None in this initial release

### 🙏 Acknowledgments
- Built with ❤️ for Flutter community
- Thanks to all contributors and beta testers
