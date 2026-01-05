# Changelog

All notable changes to the Micropack UI Kit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2026-01-05

### Changed
- **BREAKING**: Migrated from `carousel_slider` to `carousel_slider_x` due to Flutter 3.24.0+ compatibility
- Updated `flutter_spinkit` from ^5.2.0 to ^5.2.2
- Updated `flutter_slidable` from ^4.0.0 to ^4.0.2
- Updated `mockito` from ^5.4.4 to ^5.5.1
- Updated `very_good_analysis` from ^8.0.0 to ^9.0.0

### Fixed
- Resolved `CarouselController` naming conflict with Flutter 3.24.0+

## [0.3.0] - 2025-12-24

### Added
- **5 New Components**:
  - `MPCarousel` - Image/content slider with 4 variants (standard, fullWidth, compact, hero)
  - `MPSlidable` - Swipeable list items with actions (via flutter_slidable)
  - `MPExpansionTile` - Expandable cards with adaptive theming
  - `MPDataTable` - Data tables with alternating row colors and sorting
  - `MPStepper` - Multi-step workflow component for forms
- **New Dependencies**:
  - `carousel_slider: ^5.0.0` - Image carousel functionality
  - `flutter_slidable: ^4.0.0` - Swipe-to-action functionality
- **Demo Page**:
  - `new_components_demo_page.dart` - Showcases all 5 new components
  - Added "New Components (v0.3.0)" section to home page

### Documentation
- Updated `docs/component-quick-reference.md`:
  - Added MPCarousel, MPSlidable, MPExpansionTile, MPDataTable to Display Components
  - Added MPStepper to Form Components
  - Added quick usage examples for all 5 new components
- Updated `README.md`:
  - Component count updated from 26 to 31

### Testing
- Created test files for all new components:
  - `test/components/carousel/mp_carousel_test.dart`
  - `test/components/slidable/mp_slidable_test.dart`
  - `test/components/expansion_tile/mp_expansion_tile_test.dart`
  - `test/components/data_table/mp_data_table_test.dart`
  - `test/components/stepper/mp_stepper_test.dart`

### Theme Compliance
- All new components follow strict theme rules:
  - Use `context.mp.*` API for all colors
  - Semantic color names (textColor, subtitleColor, cardColor, etc.)
  - No hardcoded colors
  - Adaptive shadow colors for dark mode

## [0.3.0] - 2025-12-23

### Added
- **9 New Demo Pages**:
  - `badge_demo_page.dart` - MPBadge component demonstrations
  - `switch_demo_page.dart` - MPSwitch component demonstrations
  - `chip_demo_page.dart` - MPChip component demonstrations
  - `progress_demo_page.dart` - MPProgressBar and MPCircularProgress demonstrations
  - `dropdown_demo_page.dart` - MPDropdown component demonstrations
  - `tooltip_demo_page.dart` - MPTooltip component demonstrations
  - `checkbox_demo_page.dart` - MPCheckbox component demonstrations
  - `snackbar_demo_page.dart` - MPSnackbar component demonstrations
  - `skeleton_demo_page.dart` - MPSkeleton component demonstrations
- **Form Components Section** in home page navigation
- Complete demo coverage for all components (26/26 components)

### Documentation
- **Comprehensive Documentation System** (8 new documentation files):
  - `docs/overview.md` - Documentation navigation and learning paths
  - `docs/getting-started/README.md` - Installation and setup guide
  - `docs/api/README.md` - Complete API reference for all 26 components
  - `docs/component-quick-reference.md` - Fast component lookup card
  - `docs/guides/best-practices.md` - Best practices and patterns guide
  - `docs/examples/common-use-cases.md` - Real-world usage examples
  - `docs/guides/theming.md` - Complete theme system guide
  - `docs/guides/theme-colors-quick-reference.md` - All theme colors reference
  - `docs/guides/troubleshooting.md` - Common issues and solutions
- **Updated Root README.md**:
  - Added complete component table (26 components)
  - Added feature "Well Tested"
  - Updated installation to version 0.3.0
  - Added component categories with descriptions
- **Updated docs/README.md**:
  - Added "New to Micropack UI Kit?" section
  - Added recommended learning path
  - Added quick links tables by category
  - Integrated all new documentation files
- **Updated docs/overview.md**:
  - Added documentation status tracking
  - Added documentation roadmap
  - Added quick links to all files

### Testing
- **Test File for MPBadge**:
  - `test/components/badge/mp_badge_test.dart` - Comprehensive test suite with 15 test groups
  - Tests for variants, sizes, states, accessibility, and edge cases

### Changed
- **Improved `app_bar_demo_page.dart`**:
  - Replaced bottom sheet navigation with full-screen examples
  - Added preview cards with better UX
  - Better visual hierarchy with colored icons
  - Proper scaffold-level app bar usage
- **Enhanced Home Page**:
  - Added navigation section for Form Components
  - Better error handling with SnackBar
  - Improved visual design of navigation buttons

### Fixed
- Fixed incorrect nesting of MPAppBar in demo pages
- Improved error handling for demo page navigation
- Better separation of concerns in demo pages
- Fixed layout issues in preview cards
- Created missing `mp_badge_enums.dart` file for MPBadge enums

## [0.2.0] - 2025-12-23

### Added
- **Navigation Components**:
  - MPBottomSheet component with multiple variants
  - MPNavigationRail component for desktop navigation
  - MPAppBar component with theme integration
  - MPPlatformAdaptive widget for platform-specific variants
- **Feedback & Display Components**:
  - MPListTile component for standard list items
  - MPAvatar component for user profile images
  - MPDivider component with theme support
  - MPEmptyState component for empty states
- **Complete Test Suite**:
  - Tests for all navigation components
  - Tests for all feedback components
  - Test utilities and helpers
- **Demo Pages**:
  - Navigation component demos
  - Feedback component demos
  - Interactive examples with real-world use cases

### Changed
- Improved theme system with better contrast ratios
- Enhanced responsive design utilities
- Optimized animation performance
- Better platform adaptation for mobile, macOS, and web

### Fixed
- Fixed theme switching issues
- Improved accessibility labels
- Better error handling in components

## [0.1.0] - 2025-12-20

### Added
- **Initial Release**
- Core UI components:
  - MPButton with multiple variants (primary, secondary, danger, etc.)
  - MPCard for content containers
  - MPText for typography
  - MPTextField for form inputs
  - MPToast for notifications
  - MPDialog for modals
  - MPTab for tab navigation
  - MPColor for color utilities
  - MPTheme for theme management
- Theme system with light/dark mode support
- Responsive design utilities
- Animation system with MPInteractionAnimator
- Platform detection utilities
- Service locator setup with get_it
- Example app demonstrating all components

### Features
- Material Design 3 compliance
- iOS and Android platform optimization
- macOS desktop support
- Web optimization
- Responsive breakpoints
- Smooth animations
- Theme customization

---

## [Unreleased]

### Planned
- Widgetbook integration for component catalog
- Internationalization (i18n) support
- Integration tests for critical user flows
- Performance optimization and profiling
- Enhanced accessibility with screen reader support
- CI/CD pipeline with automated testing
