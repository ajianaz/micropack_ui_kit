# Examples and Demos

Complete examples and demonstrations of Micropack UI Kit components and features.

## 📚 Table of Contents

- [Getting Started Examples](#getting-started)
- [Component Examples](#component-examples)
- [Theme Examples](#theme-examples)
- [Advanced Examples](#advanced-examples)

## 🚀 Getting Started Examples

### Basic App Setup

```dart
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MPTextStyle.defaultFontFamily = 'Inter';
  
  runApp(
    MPComponentInit(
      builder: (_) => MaterialApp(
        title: 'My App',
        theme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.light],
        ),
        darkTheme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.dark],
        ),
        home: ExampleHomePage(),
      ),
    ),
  );
}
```

### Theme Toggle Implementation

```dart
class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Demo'),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(_getThemeIcon()),
            itemBuilder: (context) => [
              PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
              PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              PopupMenuItem(value: ThemeMode.system, child: Text('System')),
            ],
            onSelected: (mode) => setState(() => _themeMode = mode),
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: context.mp.adaptiveBackgroundColor,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Theme Demo',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: context.mp.textColor,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Current theme: ${_getThemeModeText()}',
                style: TextStyle(
                  fontSize: 18,
                  color: context.mp.subtitleColor,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: context.mp.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Primary Button',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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

  IconData _getThemeIcon() {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_brightness;
    }
  }

  String _getThemeModeText() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}
```

## 🧩 Component Examples

### Article Card Gallery

```dart
class ArticleCardGallery extends StatelessWidget {
  const ArticleCardGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: Text('Article Cards'),
        backgroundColor: context.mp.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Standard Variant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            MPArticleCard(
              title: 'Getting Started with Flutter',
              description: 'Learn the basics of Flutter development with this comprehensive guide.',
              author: 'Sarah Johnson',
              date: 'March 15, 2024',
              readTime: '5 min read',
              imageUrl: 'https://picsum.photos/400/200?random=1',
              variant: MPArticleCardVariant.standard,
              onTap: () => _openArticle('flutter-basics'),
            ),
            SizedBox(height: 24),
            Text(
              'Elevated Variant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            MPArticleCard(
              title: 'Advanced State Management',
              description: 'Explore advanced state management patterns in Flutter applications.',
              author: 'Mike Chen',
              date: 'March 14, 2024',
              readTime: '8 min read',
              imageUrl: 'https://picsum.photos/400/200?random=2',
              variant: MPArticleCardVariant.elevated,
              size: MPArticleCardSize.large,
              onTap: () => _openArticle('state-management'),
            ),
            SizedBox(height: 24),
            Text(
              'Outlined Variant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            MPArticleCard(
              title: 'UI Design Patterns',
              description: 'Common UI design patterns and how to implement them in Flutter.',
              author: 'Emily Davis',
              date: 'March 13, 2024',
              readTime: '6 min read',
              imageUrl: 'https://picsum.photos/400/200?random=3',
              variant: MPArticleCardVariant.outlined,
              onTap: () => _openArticle('ui-patterns'),
              category: 'Design',
              tags: ['UI', 'Flutter', 'Design'],
            ),
          ],
        ),
      ),
    );
  }

  void _openArticle(String articleId) {
    // Handle article navigation
    print('Opening article: $articleId');
  }
}
```

### Button Variants Showcase

```dart
class ButtonShowcase extends StatelessWidget {
  const ButtonShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: Text('Button Showcase'),
        backgroundColor: context.mp.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Primary Buttons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                MPButton(
                  text: 'Small',
                  size: MPButtonSize.small,
                  onPressed: () => print('Small pressed'),
                ),
                MPButton(
                  text: 'Medium',
                  size: MPButtonSize.medium,
                  onPressed: () => print('Medium pressed'),
                ),
                MPButton(
                  text: 'Large',
                  size: MPButtonSize.large,
                  onPressed: () => print('Large pressed'),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Secondary Buttons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                MPButton(
                  text: 'Standard',
                  variant: MPButtonVariant.secondary,
                  onPressed: () => print('Secondary pressed'),
                ),
                MPButton(
                  text: 'Outline',
                  variant: MPButtonVariant.outline,
                  onPressed: () => print('Outline pressed'),
                ),
                MPButton(
                  text: 'Ghost',
                  variant: MPButtonVariant.ghost,
                  onPressed: () => print('Ghost pressed'),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Special Buttons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.mp.textColor,
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                MPButton(
                  text: 'Success',
                  variant: MPButtonVariant.success,
                  fullWidth: true,
                  onPressed: () => print('Success pressed'),
                ),
                SizedBox(height: 8),
                MPButton(
                  text: 'Warning',
                  variant: MPButtonVariant.warning,
                  fullWidth: true,
                  onPressed: () => print('Warning pressed'),
                ),
                SizedBox(height: 8),
                MPButton(
                  text: 'Danger',
                  variant: MPButtonVariant.danger,
                  fullWidth: true,
                  onPressed: () => print('Danger pressed'),
                ),
                SizedBox(height: 8),
                MPButton(
                  text: 'Loading',
                  variant: MPButtonVariant.primary,
                  fullWidth: true,
                  isLoading: true,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 Theme Examples

### Custom Color Theme

```dart
MaterialApp(
  theme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.light.copyWith(
        primary: Colors.deepPurple,
        primarySurface: Colors.deepPurple.shade50,
        primaryFocus: Colors.deepPurple.shade200,
        primaryBorder: Colors.deepPurple.shade300,
        primaryHover: Colors.deepPurple.shade400,
        primaryPressed: Colors.deepPurple.shade600,
        neutral10: Colors.grey.shade50,
        neutral20: Colors.grey.shade100,
        neutral30: Colors.grey.shade200,
        neutral40: Colors.grey.shade300,
        neutral50: Colors.grey.shade400,
        neutral60: Colors.grey.shade500,
        neutral70: Colors.grey.shade600,
        neutral80: Colors.grey.shade700,
        neutral90: Colors.grey.shade800,
        neutral100: Colors.grey.shade900,
      ),
    ],
  ),
  darkTheme: MPTheme.main().copyWith(
    extensions: [
      MPColorTheme.dark.copyWith(
        primary: Colors.deepPurple,
        primarySurface: Colors.deepPurple.shade900,
        primaryFocus: Colors.deepPurple.shade700,
        primaryBorder: Colors.deepPurple.shade600,
        primaryHover: Colors.deepPurple.shade500,
        primaryPressed: Colors.deepPurple.shade400,
      ),
    ],
  ),
  home: YourApp(),
)
```

### Brand Color Customization

```dart
void main() {
  // Initialize with custom brand colors
  MpUiKit.init(
    colorBrand: Colors.blue.shade700,
    colorBrand2: Colors.white,
    colorStroke: Colors.blue.shade300,
    colorText: Colors.blue.shade900,
    colorError: Colors.red.shade600,
    colorDisable: Colors.grey.shade400,
  );
  
  runApp(MyApp());
}
```

## 🔧 Advanced Examples

### Responsive Layout

```dart
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return _buildDesktopLayout();
          } else if (constraints.maxWidth > 800) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildSidebar()),
        Expanded(flex: 8, child: _buildMainContent()),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Expanded(flex: 1, child: _buildSidebar()),
        Expanded(flex: 3, child: _buildMainContent()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return _buildMainContent();
  }

  Widget _buildSidebar() {
    return Container(
      color: context.mp.neutral20,
      child: Column(
        children: [
          _buildSidebarItem('Dashboard', Icons.dashboard),
          _buildSidebarItem('Profile', Icons.person),
          _buildSidebarItem('Settings', Icons.settings),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: context.mp.textColor),
      title: Text(title, style: TextStyle(color: context.mp.textColor)),
      onTap: () => print('Navigate to $title'),
    );
  }

  Widget _buildMainContent() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Main Content',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: context.mp.textColor,
            ),
          ),
          SizedBox(height: 16),
          MPArticleCard(
            title: 'Responsive Design',
            description: 'Building layouts that work across all device sizes.',
            author: 'UI Team',
            date: 'March 15, 2024',
            readTime: '4 min read',
            variant: MPArticleCardVariant.elevated,
            onTap: () => print('Open article'),
          ),
        ],
      ),
    );
  }
}
```

### Form with Validation

```dart
class ValidationForm extends StatefulWidget {
  const ValidationForm({super.key});

  @override
  State<ValidationForm> createState() => _ValidationFormState();
}

class _ValidationFormState extends State<ValidationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: Text('Validation Form'),
        backgroundColor: context.mp.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MPTextField(
                controller: _nameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Name is required';
                  }
                  if ((value?.length ?? 0) < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              MPTextField(
                controller: _emailController,
                hintText: 'Email Address',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value ?? '')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              MPTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                prefixIcon: Icons.lock,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Password is required';
                  }
                  if ((value?.length ?? 0) < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              MPButton(
                text: _isLoading ? 'Creating Account...' : 'Sign Up',
                variant: MPButtonVariant.primary,
                size: MPButtonSize.large,
                fullWidth: true,
                isLoading: _isLoading,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      try {
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));
        
        // Show success dialog
        MPDialog.show(
          context: context,
          title: 'Success!',
          content: Text('Account created successfully!'),
          type: DialogType.success,
          onConfirm: () => Navigator.pop(context),
        );
      } catch (error) {
        // Show error dialog
        MPDialog.show(
          context: context,
          title: 'Error',
          content: Text('Failed to create account. Please try again.'),
          type: DialogType.error,
          onConfirm: () => Navigator.pop(context),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
```

## 🔗 Live Demos

For interactive demonstrations of these examples, check out our:

- **Example App**: [GitHub Repository](https://github.com/your-repo/micropack_ui_kit_example)
- **Online Demo**: [Web Demo](https://demo.example.com/micropack-ui-kit)
- **Video Tutorials**: [YouTube Channel](https://youtube.com/your-channel)

## 📚 Learning Resources

- [Getting Started Guide](../getting-started/README.md) - Basic setup
- [API Reference](../api/README.md) - Complete documentation
- [Theme Guide](../guides/theming.md) - Advanced theming

## 🤝 Contributing Examples

Have a great example to share? Please contribute!

1. Fork the repository
2. Add your example to the appropriate section
3. Update documentation
4. Submit a pull request

We love community contributions! 🎉
