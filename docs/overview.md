# Documentation Overview

Welcome to Micropack UI Kit documentation! This is your comprehensive guide to learning, implementing, and mastering the UI Kit.

## 📚 Documentation Structure

```
docs/
├── README.md                          # This file - Documentation overview
├── getting-started/
│   └── README.md                      # Installation and quick setup guide
├── api/
│   └── README.md                      # Complete component API reference
├── guides/
│   ├── best-practices.md             # Best practices and patterns
│   ├── theming.md                   # Theme system guide (TODO)
│   └── troubleshooting.md           # Common issues and solutions (TODO)
├── examples/
│   └── common-use-cases.md         # Real-world usage examples
├── component-quick-reference.md      # Quick reference card for fast lookup
└── assets/                         # Images and diagrams
```

---

## 🚀 Where to Start?

### New Users? Start Here!

1. **[Getting Started Guide](./getting-started/README.md)**
   - Installation instructions
   - Basic setup
   - Your first component
   - Theme initialization

2. **[Common Use Cases](./examples/common-use-cases.md)**
   - Authentication forms
   - User profiles
   - Settings pages
   - Lists and grids
   - Real-world examples

3. **[Component Quick Reference](./component-quick-reference.md)**
   - Fast component lookup
   - Quick props reference
   - Common patterns

---

## 📖 Want to Learn More?

### Understand the Components

1. **[Component API Reference](./api/README.md)**
   - Complete API documentation for all 26 components
   - Parameters, types, and examples
   - Variants and sizes

2. **[Best Practices Guide](./guides/best-practices.md)**
   - Component usage patterns
   - Theme best practices
   - Performance tips
   - Accessibility guidelines
   - Code organization

### Master the Theme System

> **⚠️ CRITICAL**: Always use adaptive colors (`context.mp.textColor`, `context.mp.cardColor`, etc.) instead of fixed neutral colors (`context.mp.neutral90`, `context.mp.neutral20`). Fixed colors don't adapt to theme changes and will cause visibility issues.

1. **[Theme System Guide](./guides/theming.md)** (Coming Soon)
   - Theme system overview
   - Color utilities
   - Custom theming
   - Dark/light mode implementation
   - Theme persistence

2. **[Theme Colors Quick Reference](./guides/theme-colors-quick-reference.md)** (Coming Soon)
   - All available theme colors
   - When to use each color
   - Semantic color usage

---

## 🎯 Looking for Something Specific?

### Component Documentation
- [MPButton](./api/README.md#mpbutton) - Buttons and actions
- [MPCard](./api/README.md#mpcard) - Content containers
- [MPText](./api/README.md#mptext) - Typography
- [MPTextField](./api/README.md#mptextfield) - Form inputs
- [MPCheckbox](./api/README.md#mpcheckbox) - Checkboxes
- [MPSwitch](./api/README.md#mpswitch) - Toggle switches
- [MPBadge](./api/README.md#mpbadge) - Status badges
- [MPChip](./api/README.md#mpchip) - Tags and labels
- [MPProgress](./api/README.md#mpprogress) - Progress indicators
- [MPDropdown](./api/README.md#mpdropdown) - Select dropdowns
- [MPTooltip](./api/README.md#mptooltip) - Tooltips
- [MPSnackbar](./api/README.md#mpsnackbar) - Notification bars
- [MPToast](./api/README.md#mptoast) - Quick notifications
- [MPDialog](./api/README.md#mpdialog) - Modal dialogs
- [MPBottomSheet](./api/README.md#mpbottomsheet) - Bottom modals
- [MPAppBar](./api/README.md#mpappbar) - App bars
- [MPNavigationRail](./api/README.md#mpnavigationrail) - Desktop sidebar
- [MPTab](./api/README.md#mptab) - Tab navigation
- [MPPlatformAdaptive](./api/README.md#mpplatformadaptive) - Platform widgets
- [MPListTile](./api/README.md#mplisttile) - List items
- [MPAvatar](./api/README.md#mpavatar) - User avatars
- [MPDivider](./api/README.md#mpdivider) - Dividers
- [MPEmptyState](./api/README.md#mpemptystate) - Empty states
- [MPSkeleton](./api/README.md#mpskeleton) - Loading skeletons
- [MPArticleCard](./api/README.md#mparticlecard) - Article cards

### Category Documentation
- **[Basic Components](./api/README.md#basic-components)** - Buttons, Cards, Text, Inputs
- **[Form Components](./api/README.md#form-components)** - Checkboxes, Switches, Badges, Chips, Progress, Dropdowns, Tooltips
- **[Feedback Components](./api/README.md#feedback-components)** - Toasts, Snackbars
- **[Navigation Components](./api/README.md#navigation-components)** - Dialogs, BottomSheets, AppBars, Rails, Tabs, Platform Adaptive
- **[Display Components](./api/README.md#display-components)** - ListTiles, Avatars, Dividers, EmptyStates, Skeletons, ArticleCards

---

## 💡 Learning Paths

### Path 1: Quick Start (30 minutes)
1. Read [Getting Started Guide](./getting-started/README.md)
2. Try the examples in [Common Use Cases](./examples/common-use-cases.md)
3. Reference [Component Quick Reference](./component-quick-reference.md) as needed

### Path 2: Deep Dive (2-3 hours)
1. Complete [Getting Started Guide](./getting-started/README.md)
2. Read entire [Component API Reference](./api/README.md)
3. Study [Best Practices Guide](./guides/best-practices.md)
4. Practice with [Common Use Cases](./examples/common-use-cases.md)

### Path 3: Mastery (1 week)
1. Complete all documentation
2. Explore the example app thoroughly
3. Implement a full-featured page using all components
4. Review [Best Practices Guide](./guides/best-practices.md) regularly
5. Contribute improvements!

---

## 🔍 Need Help Finding Something?

### By Topic

| Topic | Documentation |
|--------|---------------|
| Installation & Setup | [Getting Started](./getting-started/README.md) |
| Component APIs | [API Reference](./api/README.md) |
| Quick Lookup | [Quick Reference](./component-quick-reference.md) |
| Best Practices | [Best Practices](./guides/best-practices.md) |
| Real Examples | [Common Use Cases](./examples/common-use-cases.md) |
| Theme System | [Theme Guide](./guides/theming.md) (Coming Soon) |
| Troubleshooting | [Troubleshooting](./guides/troubleshooting.md) (Coming Soon) |

### By Skill Level

| Level | Documentation |
|--------|---------------|
| Beginner | [Getting Started](./getting-started/README.md) |
| Intermediate | [API Reference](./api/README.md), [Common Use Cases](./examples/common-use-cases.md) |
| Advanced | [Best Practices](./guides/best-practices.md), [Theme Guide](./guides/theming.md) |

---

## 📋 Component Categories

### 🔘 Basic Components (4)
- MPButton - Multiple variants and sizes
- MPCard - Content containers
- MPText - Enhanced typography
- MPTextField - Form inputs with validation

### 📝 Form Components (8)
- MPCheckbox - Checkboxes with states
- MPSwitch - Toggle switches
- MPBadge - Status indicators
- MPChip - Tags and labels
- MPProgress - Progress indicators (linear/circular)
- MPDropdown - Select with search
- MPTooltip - Contextual help
- MPTextField - Input fields

### 💬 Feedback Components (2)
- MPToast - Quick notifications
- MPSnackbar - Snackbar with actions

### 🧭 Navigation Components (6)
- MPDialog - Modal dialogs
- MPBottomSheet - Bottom modals
- MPAppBar - Theme-aware app bar
- MPNavigationRail - Desktop sidebar
- MPTab - Tab navigation
- MPPlatformAdaptive - Platform widgets

### 📰 Display Components (6)
- MPListTile - Standard list items
- MPAvatar - User profile images
- MPDivider - Dividers with styling
- MPEmptyState - Empty state placeholders
- MPSkeleton - Loading skeletons
- MPArticleCard - Article cards

---

## 🆘 Need Help?

### Documentation Issues
- Found a typo? [Open an issue](https://github.com/ajianaz/micropack-ui-kit/issues)
- Missing information? [Request a documentation update](https://github.com/ajianaz/micropack-ui-kit/issues)
- Confusing explanation? [Ask for clarification](https://github.com/ajianaz/micropack-ui-kit/discussions)

### Usage Help
- Can't get something working? Check [Troubleshooting Guide](./guides/troubleshooting.md)
- Need an example? See [Common Use Cases](./examples/common-use-cases.md)
- API questions? Review [Component API Reference](./api/README.md)

### Community Support
- [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues) - Bug reports and feature requests
- [GitHub Discussions](https://github.com/ajianaz/micropack-ui-kit/discussions) - Questions and discussions
- [Example App](../../example/) - Full working example application

---

## 📝 Documentation Status

| Documentation | Status | Last Updated |
|---------------|----------|--------------|
| Getting Started | ✅ Complete | 2025-12-23 |
| API Reference | ✅ Complete | 2025-12-23 |
| Best Practices | ✅ Complete | 2025-12-23 |
| Common Use Cases | ✅ Complete | 2025-12-23 |
| Quick Reference | ✅ Complete | 2025-12-23 |
| Theme System Guide | ✅ Complete | 2025-12-23 |
| Theme Colors Quick Reference | ✅ Complete | 2025-12-23 |
| Troubleshooting Guide | ✅ Complete | 2025-12-23 |

---

## 🎓 Additional Resources

### Official Flutter Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [Accessibility Guide](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility)

### Related Packages
- [flutter_animate](https://pub.dev/packages/flutter_animate) - Animation library
- [get_it](https://pub.dev/packages/get_it) - Service locator
- [google_fonts](https://pub.dev/packages/google_fonts) - Google Fonts

---

## 📈 Documentation Roadmap

### Planned Documentation
- [ ] Migration Guide - v0.2.0 to v0.3.0 (if needed)
- [ ] Performance Guide - Optimization tips
- [ ] Accessibility Guide - A11y best practices
- [ ] Testing Guide - Component testing patterns
- [ ] Animation Guide - Using flutter_animate
- [ ] Internationalization Guide - i18n support

### Improvements
- [ ] More interactive examples
- [ ] Video tutorials
- [ ] Copy-to-clipboard code snippets
- [ ] Searchable documentation
- [ ] Dark mode for documentation itself

---

## 🔗 Quick Links

- [Package README](../../README.md)
- [Getting Started](./getting-started/README.md)
- [Component API](./api/README.md)
- [Best Practices](./guides/best-practices.md)
- [Common Use Cases](./examples/common-use-cases.md)
- [Quick Reference](./component-quick-reference.md)
- [Theme System Guide](./guides/theming.md)
- [Theme Colors Quick Reference](./guides/theme-colors-quick-reference.md)
- [Troubleshooting Guide](./guides/troubleshooting.md)
- [CHANGELOG](../../CHANGELOG.md)
- [GitHub Repository](https://github.com/ajianaz/micropack-ui-kit.git)
- [Example App](../../example/)

---

## ✨ Thank You!

Thank you for using Micropack UI Kit! We hope this documentation helps you build beautiful, responsive, and accessible Flutter applications.

Happy coding! 🚀
