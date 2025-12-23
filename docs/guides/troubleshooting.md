# Troubleshooting Guide

Common issues and solutions when using Micropack UI Kit.

## 📋 Table of Contents

- [Theme Issues](#theme-issues)
- [Component Issues](#component-issues)
- [Build Issues](#build-issues)
- [Runtime Issues](#runtime-issues)
- [Performance Issues](#performance-issues)
- [Accessibility Issues](#accessibility-issues)

---

## 🎨 Theme Issues

### Issue: Colors Not Adapting to Theme Changes

**Symptom**:
- Colors stay the same when switching between light and dark themes
- Text becomes unreadable in dark mode
- Background colors don't update

**Cause**:
- Using fixed colors (`context.mp.neutral90`) instead of adaptive colors (`context.mp.textColor`)

**Solution**:

```dart
// ❌ WRONG: Using fixed colors
Container(
  color: context.mp.neutral90,  // Won't adapt
  child: Text(
    'Hello',
    style: TextStyle(color: context.mp.neutral20),  // Won't adapt
  ),
)

// ✅ CORRECT: Using adaptive colors
Container(
  color: context.mp.adaptiveBackgroundColor,  // Adapts
  child: Text(
    'Hello',
    style: TextStyle(color: context.mp.textColor),  // Adapts
  ),
)
```

**Prevention**:
- Always use `context.mp.textColor`, `context.mp.cardColor`, etc.
- Never use `context.mp.neutral90`, `context.mp.neutral20`, etc. in app code
- See [Theme Colors Quick Reference](./theme-colors-quick-reference.md) for all adaptive colors

---

### Issue: Theme Extension Not Working

**Symptom**:
- Error: `NoSuchMethodError: Class 'ThemeData' has no instance getter 'mp'`
- Can't access `context.mp` properties

**Cause**:
- Forgot to wrap app with `MPComponentInit`
- Theme extension not registered

**Solution**:

```dart
// ❌ WRONG: No MPComponentInit
void main() {
  runApp(
    MaterialApp(
      theme: MPTheme.main(),
      home: MyApp(),
    ),
  );
}

// ✅ CORRECT: Wrap with MPComponentInit
void main() {
  runApp(
    MPComponentInit(
      builder: (_) => MaterialApp(
        theme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.light],
        ),
        darkTheme: MPTheme.main().copyWith(
          extensions: [MPColorTheme.dark],
        ),
        home: MyApp(),
      ),
    ),
  );
}
```

---

### Issue: Custom Font Not Applied

**Symptom**:
- Components use default font instead of custom font
- Font family doesn't match configuration

**Cause**:
- Font not declared in `pubspec.yaml`
- Font family name doesn't match

**Solution**:

```dart
// Step 1: Declare font in pubspec.yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: fonts/Inter-Regular.ttf
        - asset: fonts/Inter-Medium.ttf
        - asset: fonts/Inter-Bold.ttf

// Step 2: Initialize with font name
void main() {
  MpUiKit.init(
    fontName: 'Inter',  // Must match family name in pubspec.yaml
  );

  runApp(const MyApp());
}

// Step 3: Or set globally
MPTextStyle.defaultFontFamily = 'Inter';
```

---

### Issue: Brand Colors Not Showing

**Symptom**:
- Default colors used instead of custom brand colors
- Brand colors don't match configuration

**Cause**:
- `MpUiKit.init()` not called
- Init called after `runApp()`

**Solution**:

```dart
// ❌ WRONG: Init after runApp
void main() {
  runApp(const MyApp());
  MpUiKit.init(colorBrand: Colors.red);  // Too late!
}

// ✅ CORRECT: Init before runApp
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MpUiKit.init(
    colorBrand: Color(0xFF6366F1),      // Must call before runApp
    colorBrand2: Color(0xFFF472B6),
  );

  runApp(const MyApp());
}
```

---

## 🧩 Component Issues

### Issue: MPButton Not Responding to Taps

**Symptom**:
- Button doesn't trigger `onPressed` callback
- Visual feedback shows but nothing happens

**Cause**:
- `onPressed` is null
- Button wrapped in `AbsorbPointer`
- Button inside disabled widget

**Solution**:

```dart
// ❌ WRONG: onPressed is null
MPButton(
  text: 'Click Me',
  onPressed: null,  // Button will be disabled
)

// ❌ WRONG: Wrapped in AbsorbPointer
AbsorbPointer(
  child: MPButton(
    text: 'Click Me',
    onPressed: _handleTap,
  ),
)

// ✅ CORRECT: Proper onPressed
MPButton(
  text: 'Click Me',
  onPressed: _handleTap,  // Must provide callback
)

// ✅ CORRECT: With loading state
MPButton(
  text: 'Saving...',
  loading: _loading,
  onPressed: _loading ? null : _handleTap,  // Disable when loading
)
```

---

### Issue: MPTextField Validation Not Working

**Symptom**:
- Validator function not called
- No error messages shown
- Form always validates as valid

**Cause**:
- Form not wrapped with `Form` widget
- Not using `TextEditingController`
- Not calling `_formKey.currentState.validate()`

**Solution**:

```dart
// ❌ WRONG: No Form wrapper
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPTextField(
          hintText: 'Email',
          validator: (v) => v?.isEmpty ? 'Required' : null,
        ),
        MPButton(
          text: 'Submit',
          onPressed: () => print('Submit'),
        ),
      ],
    );
  }
}

// ✅ CORRECT: Wrap with Form and use form key
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,  // MUST provide form key
      child: Column(
        children: [
          MPTextField(
            hintText: 'Email',
            validator: (v) => v?.isEmpty ? 'Required' : null,
          ),
          MPButton(
            text: 'Submit',
            onPressed: () {
              if (_formKey.currentState!.validate()) {  // MUST call validate()
                // Submit logic
              }
            },
          ),
        ],
      ),
    );
  }
}
```

---

### Issue: MPSnackbar Not Showing

**Symptom**:
- Snackbar doesn't appear when called
- Appears then immediately disappears
- Shows in wrong position

**Cause**:
- Context used doesn't have Scaffold ancestor
- Duration is too short
- Called before widget tree is ready

**Solution**:

```dart
// ❌ WRONG: Using context without Scaffold
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This context doesn't have Scaffold yet
    return Column(
      children: [
        MPButton(
          text: 'Show Snackbar',
          onPressed: () => MPSnackbar.show(
            context: context,  // ❌ Wrong context!
            message: 'Hello',
          ),
        ),
      ],
    );
  }
}

// ✅ CORRECT: Get Scaffold context or use Builder
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MPButton(
            text: 'Show Snackbar',
            onPressed: () => MPSnackbar.show(
              context: context,  // ✅ This context has Scaffold
              message: 'Hello',
              duration: Duration(seconds: 3),  // ✅ Provide duration
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Alternative: Use Builder for proper context
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Column(
          children: [
            MPButton(
              text: 'Show Snackbar',
              onPressed: () => MPSnackbar.show(
                context: context,  // ✅ Builder provides correct context
                message: 'Hello',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### Issue: MPDialog Not Showing

**Symptom**:
- Dialog doesn't appear
- Error: `No Scaffold widget found`
- Dialog shows but background doesn't dim

**Cause**:
- Context doesn't have Navigator
- Not using `showDialog` properly
- Missing `Navigator.of(context).pop()`

**Solution**:

```dart
// ✅ CORRECT: Basic dialog
MPDialog.show(
  context: context,
  title: 'Confirmation',
  content: 'Are you sure?',
  confirmText: 'Yes',
  cancelText: 'No',
  onConfirm: () => Navigator.of(context).pop(),  // ✅ Must pop manually
  onCancel: () => Navigator.of(context).pop(),
)

// ✅ CORRECT: With callback
Future<void> _showDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => MPDialog(
      title: 'Delete Item',
      content: 'This cannot be undone.',
      type: DialogType.warning,
      onConfirm: () => Navigator.of(context).pop(true),
      onCancel: () => Navigator.of(context).pop(false),
    ),
  );

  if (result == true) {
    // User confirmed
    _deleteItem();
  }
}
```

---

## 🔨 Build Issues

### Issue: Package Not Found

**Symptom**:
- Error: `Error: Could not resolve the package 'micropack_ui_kit'`
- `import 'package:micropack_ui_kit/micropack_ui_kit.dart';` not working

**Cause**:
- Package not added to `pubspec.yaml`
- `flutter pub get` not run
- Incorrect package name

**Solution**:

```yaml
# Step 1: Add to pubspec.yaml
dependencies:
  micropack_ui_kit: ^0.3.0  # ✅ Add this line
  flutter:
    sdk: flutter
```

```bash
# Step 2: Install dependencies
flutter pub get

# Step 3: Clean build if needed
flutter clean
flutter pub get
```

```dart
// Step 4: Import with correct name
import 'package:micropack_ui_kit/micropack_ui_kit.dart';  // ✅ Correct name

// ❌ WRONG: Incorrect name
import 'package:micropack_ui_kit/ui_kit.dart';
```

---

### Issue: Font Assets Not Loading

**Symptom**:
- Error: `Unable to load asset: fonts/Inter-Regular.ttf`
- Default system fonts used

**Cause**:
- Fonts not in correct folder
- Asset path incorrect in `pubspec.yaml`
- Cache issue

**Solution**:

```yaml
# Step 1: Check folder structure
# project/
#   fonts/
#     Inter-Regular.ttf
#     Inter-Medium.ttf
#     Inter-Bold.ttf

# Step 2: Declare in pubspec.yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: fonts/Inter-Regular.ttf
        - asset: fonts/Inter-Medium.ttf
        - asset: fonts/Inter-Bold.ttf
```

```bash
# Step 3: Clean cache
flutter clean
flutter pub get
flutter run
```

---

## ⚡ Runtime Issues

### Issue: Controller Not Disposed

**Symptom**:
- Warning: `TextEditingController was used after being disposed`
- Memory leaks over time
- App becomes slow

**Cause**:
- Not disposing controllers in `dispose()` method

**Solution**:

```dart
// ❌ WRONG: Not disposing controller
class MyForm extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPTextField(
          controller: TextEditingController(),  // ❌ Created every build
          hintText: 'Email',
        ),
      ],
    );
  }
}

// ✅ CORRECT: Create once, dispose once
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _emailController = TextEditingController();  // ✅ Create once
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();  // ✅ Dispose controllers
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPTextField(
          controller: _emailController,  // ✅ Reuse controller
          hintText: 'Email',
        ),
        MPTextField(
          controller: _passwordController,
          hintText: 'Password',
        ),
      ],
    );
  }
}
```

---

### Issue: Null Safety Errors

**Symptom**:
- Error: `A value of type 'Null' can't be assigned to a parameter of type 'String'`
- Runtime errors with null values

**Cause**:
- Not handling nullable values properly
- Missing null checks

**Solution**:

```dart
// ❌ WRONG: Not handling null
String email = _emailController.text;  // Might be null
Text(email)  // Error!

// ✅ CORRECT: Handle null properly
String? email = _emailController.text;
Text(email ?? 'No email')  // Provide default

// ✅ CORRECT: Use null-aware operators
Text(_emailController.text ?? 'No email')

// ✅ CORRECT: Check for null
if (_emailController.text != null) {
  Text(_emailController.text!)
}
```

---

## 🚀 Performance Issues

### Issue: App is Slow

**Symptom**:
- App becomes slow over time
- UI lags when switching screens
- High memory usage

**Cause**:
- Creating new controllers on every build
- Not using `const` widgets
- Deep widget trees

**Solution**:

```dart
// ❌ WRONG: Creating controllers on every build
class BadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPTextField(
          controller: TextEditingController(),  // ❌ New controller every build
          hintText: 'Email',
        ),
      ],
    );
  }
}

// ✅ CORRECT: Use const widgets
class GoodWidget extends StatelessWidget {
  const GoodWidget({super.key});  // ✅ Const constructor

  @override
  Widget build(BuildContext context) {
    return const Column(  // ✅ Const widget
      children: [
        MPText.head('Title'),  // ✅ Const text
      ],
    );
  }
}

// ✅ CORRECT: Extract reusable widgets
class ReusableCard extends StatelessWidget {
  const ReusableCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MPCard(  // ✅ Reusable widget
      child: MPText.head(title),
    );
  }
}
```

---

### Issue: Too Many Rebuilds

**Symptom**:
- Widgets rebuilding unnecessarily
- Performance degradation
- Animations are jerky

**Cause**:
- Not using `const` widgets
- Not using proper keys
- Building complex widgets inline

**Solution**:

```dart
// ❌ WRONG: Building inline without const
class BadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Item 1'),  // ❌ Not const
        Text('Item 2'),  // ❌ Not const
        Text('Item 3'),  // ❌ Not const
      ],
    );
  }
}

// ✅ CORRECT: Use const and extract widgets
class GoodWidget extends StatelessWidget {
  const GoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(  // ✅ Const
      children: [
        _ItemText('Item 1'),  // ✅ Const widget
        _ItemText('Item 2'),
        _ItemText('Item 3'),
      ],
    );
  }
}

// ✅ CORRECT: Extract widget
class _ItemText extends StatelessWidget {
  const _ItemText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);  // ✅ Reusable
  }
}
```

---

## ♿ Accessibility Issues

### Issue: Touch Targets Too Small

**Symptom**:
- Users can't tap small buttons
- Accessibility warnings
- Poor user experience

**Cause**:
- Interactive elements smaller than 44x44 points

**Solution**:

```dart
// ❌ WRONG: Touch target too small (24x24)
GestureDetector(
  onTap: () {},
  child: Icon(Icons.delete),  // ❌ Only 24x24
)

// ✅ CORRECT: Add padding to reach 44x44
GestureDetector(
  onTap: () {},
  child: Padding(
    padding: EdgeInsets.all(10),  // ✅ 24 + 20 = 44
    child: Icon(Icons.delete),
  ),
)

// ✅ CORRECT: Use MPButton (already correct size)
MPButton(
  text: 'Delete',  // ✅ Button has minimum 44px height
  onPressed: () {},
)
```

---

### Issue: Poor Color Contrast

**Symptom**:
- Text hard to read
- Accessibility warnings
- WCAG AA ratio not met (4.5:1)

**Cause**:
- Using colors with insufficient contrast
- Using fixed colors that don't adapt

**Solution**:

```dart
// ❌ WRONG: Poor contrast
Container(
  color: Colors.lightBlue,
  child: Text(
    'Text on light blue',  // ❌ Hard to read
    style: TextStyle(color: Colors.lightBlue.withValues(alpha: 0.5)),
  ),
)

// ✅ CORRECT: Use adaptive colors with good contrast
Container(
  color: context.mp.adaptiveBackgroundColor,  // ✅ Adapts for contrast
  child: Text(
    'Readable text',
    style: TextStyle(
      color: context.mp.textColor,  // ✅ High contrast
      fontSize: 16,  // ✅ Minimum 16px for readability
    ),
  ),
)
```

---

## 🔗 Related Documentation

- [Getting Started](../getting-started/README.md)
- [Component API Reference](../api/README.md)
- [Best Practices](./best-practices.md)
- [Theme System](./theming.md)

## 🆘 Still Need Help?

If you couldn't find a solution here:

1. Check [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues) for similar problems
2. Search [GitHub Discussions](https://github.com/ajianaz/micropack-ui-kit/discussions) for community help
3. [Create a new issue](https://github.com/ajianaz/micropack-ui-kit/issues/new) with:
   - Your Flutter SDK version
   - Your micropack_ui_kit version
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Error messages (if any)
