# Best Practices Guide

Best practices for using Micropack UI Kit components effectively and efficiently.

## 📋 Table of Contents

- [Component Usage](#component-usage)
- [Theme Usage](#theme-usage)
- [Performance](#performance)
- [Accessibility](#accessibility)
- [Code Organization](#code-organization)
- [Testing](#testing)
- [Common Patterns](#common-patterns)

---

## 🧩 Component Usage

### 1. Use Consistent Variants

**✅ DO**: Use consistent variants for similar actions

```dart
// Primary actions
MPButton(text: 'Submit', variant: MPButtonVariant.primary, onPressed: _submit)
MPButton(text: 'Save', variant: MPButtonVariant.primary, onPressed: _save)

// Destructive actions
MPButton(text: 'Delete', variant: MPButtonVariant.danger, onPressed: _delete)
MPButton(text: 'Remove', variant: MPButtonVariant.danger, onPressed: _remove)
```

**❌ DON'T**: Mix variants inconsistently

```dart
// Inconsistent
MPButton(text: 'Submit', variant: MPButtonVariant.primary)
MPButton(text: 'Save', variant: MPButtonVariant.secondary)  // Different variant for same action
```

### 2. Provide Semantic Labels

**✅ DO**: Add semantic labels for accessibility

```dart
MPButton(
  text: 'Submit Form',
  semanticLabel: 'Submit user registration form',
  onPressed: _submit,
)

MPBadge(
  label: '3',
  semanticLabel: '3 unread notifications',
)
```

**❌ DON'T**: Leave components without semantic context

```dart
// No semantic label
MPBadge(label: '3')
```

### 3. Use Appropriate Sizes

**✅ DO**: Choose size based on context

```dart
// Primary action - prominent
MPButton(
  text: 'Get Started',
  variant: MPButtonVariant.primary,
  size: MPButtonSize.large,
  onPressed: _getStarted,
)

// Secondary action - medium
MPButton(
  text: 'Cancel',
  variant: MPButtonVariant.outlined,
  size: MPButtonSize.medium,
  onPressed: _cancel,
)

// Tertiary action - small
MPButton(
  text: 'Learn More',
  variant: MPButtonVariant.text,
  size: MPButtonSize.small,
  onPressed: _showDetails,
)
```

**❌ DON'T**: Use large size for everything

```dart
// Too large for secondary action
MPButton(text: 'Cancel', size: MPButtonSize.large)
```

### 4. Handle Loading States

**✅ DO**: Show loading during async operations

```dart
class SubmitButton extends StatefulWidget {
  const SubmitButton({super.key});
  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _loading = false;

  Future<void> _submit() async {
    setState(() => _loading = true);
    await _api.submit();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MPButton(
      text: 'Submit',
      loading: _loading,
      onPressed: _loading ? null : _submit,
    );
  }
}
```

**❌ DON'T**: Leave button active during operation

```dart
// No loading state, can be clicked multiple times
MPButton(text: 'Submit', onPressed: _submit)
```

### 5. Provide Validation Feedback

**✅ DO**: Validate and show errors

```dart
class EmailField extends StatelessWidget {
  const EmailField({super.key});
  @override
  Widget build(BuildContext context) {
    return MPTextField(
      hintText: 'Enter your email',
      prefixIcon: Icons.email,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Email is required';
        }
        if (!value!.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
```

**❌ DON'T**: Accept invalid input silently

```dart
// No validation
MPTextField(hintText: 'Enter email')
```

---

## 🎨 Theme Usage

### 1. Always Use Adaptive Colors

> **⚠️ CRITICAL**: Always use `context.mp.adaptiveBackgroundColor` instead of fixed colors like `context.mp.neutral90`. Fixed colors don't adapt to theme changes and will cause visibility issues.

**✅ DO**: Use adaptive colors

```dart
Container(
  color: context.mp.adaptiveBackgroundColor,  // ✅ Adapts to light/dark
  child: Text(
    'Hello World',
    style: TextStyle(color: context.mp.textColor),  // ✅ Adapts
  ),
)
```

**❌ DON'T**: Use fixed neutral colors

```dart
Container(
  color: context.mp.neutral90,  // ❌ Doesn't adapt, visible in light but invisible in dark
  child: Text(
    'Hello World',
    style: TextStyle(color: context.mp.neutral20),  // ❌ Same issue
  ),
)
```

### 2. Use Semantic Colors

**✅ DO**: Use semantic colors for their intended purpose

```dart
// Success state
Text('Saved successfully!', style: TextStyle(color: context.mp.successColor))
MPSnackbar.show(context: context, message: 'Success!', variant: MPSnackbarVariant.success)

// Error state
Text('Something went wrong', style: TextStyle(color: context.mp.errorColor))
MPToast.show(context: context, message: 'Error!', type: MPToastType.error)

// Warning state
Text('Warning!', style: TextStyle(color: context.mp.warningColor))
MPBadge(label: 'Warning', variant: MPBadgeVariant.notification)
```

**❌ DON'T**: Use arbitrary colors for semantic meaning

```dart
// Hard-coded color instead of semantic
Text('Success!', style: TextStyle(color: Colors.green))
```

### 3. Test Both Light and Dark Themes

**✅ DO**: Verify UI in both themes

```dart
// Use ThemeMode.system during development
MaterialApp(
  themeMode: ThemeMode.system,  // Test both by changing system theme
  theme: MPTheme.main().copyWith(extensions: [MPColorTheme.light]),
  darkTheme: MPTheme.main().copyWith(extensions: [MPColorTheme.dark]),
  // ...
)

// Provide theme toggle for easy testing
PopupMenuButton<ThemeMode>(
  icon: Icon(Icons.brightness_6),
  itemBuilder: (context) => [
    PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
    PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
  ],
  onSelected: (mode) => setState(() => _themeMode = mode),
)
```

**❌ DON'T**: Develop with only one theme

```dart
// Only testing light theme
MaterialApp(theme: MPTheme.main(), home: MyApp())
```

### 4. Respect System Preferences

**✅ DO**: Use system theme as default

```dart
MaterialApp(
  themeMode: ThemeMode.system,  // ✅ Respects user's system preference
  // ...
)
```

**❌ DON'T**: Force a theme

```dart
// Forces light theme even if user prefers dark
MaterialApp(themeMode: ThemeMode.light, // ...)
```

---

## ⚡ Performance

### 1. Use Const Constructors

**✅ DO**: Use const where possible

```dart
// Const widgets
const MPText.head('Title')
const MPBadge.dot()

// Const lists
const buttons = [
  MPButton(text: 'OK'),
  MPButton(text: 'Cancel'),
];

// Const values
const spacing = 16.0;
```

**❌ DON'T**: Avoid const unnecessarily

```dart
// Not const, creates new instances
MPText.head('Title')  // Missing const
MPBadge.dot()        // Missing const
```

### 2. Reuse Controllers

**✅ DO**: Manage controllers lifecycle properly

```dart
class MyForm extends StatefulWidget {
  const MyForm({super.key});
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPTextField(controller: _emailController, hintText: 'Email'),
        MPTextField(controller: _passwordController, hintText: 'Password'),
      ],
    );
  }
}
```

**❌ DON'T**: Create new controllers on every build

```dart
// Creates new controllers on every rebuild - memory leak!
Widget build(BuildContext context) {
  return Column(
    children: [
      MPTextField(controller: TextEditingController(), hintText: 'Email'),
      MPTextField(controller: TextEditingController(), hintText: 'Password'),
    ],
  );
}
```

### 3. Avoid Deep Widget Trees

**✅ DO**: Extract reusable widgets

```dart
// Extract list item
class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MPListTile(
      leading: MPAvatar(name: user.name),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}

// Use in list
ListView.builder(
  itemCount: users.length,
  itemBuilder: (context, index) => UserListItem(user: users[index]),
)
```

**❌ DON'T**: Build everything inline

```dart
// Deep nesting - hard to read and maintain
ListView.builder(
  itemCount: users.length,
  itemBuilder: (context, index) => Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        MPAvatar(name: users[index].name),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(users[index].name),
              Text(users[index].email),
            ],
          ),
        ),
      ],
    ),
  ),
)
```

### 4. Use Keys for Lists

**✅ DO**: Use unique keys for list items

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      key: ValueKey(items[index].id),  // ✅ Unique key
      title: Text(items[index].title),
    );
  },
)
```

**❌ DON'T**: Use index as key

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      key: ValueKey(index),  // ❌ Causes issues when list changes
      title: Text(items[index].title),
    );
  },
)
```

---

## ♿ Accessibility

### 1. Provide Sufficient Touch Targets

**✅ DO**: Ensure interactive elements are at least 44x44 points

```dart
// Good - large enough tap target
MPButton(
  text: 'Click Me',
  size: MPButtonSize.medium,  // 44px height
  onPressed: _onTap,
)

// Good - use padding for custom touch targets
GestureDetector(
  onTap: _onTap,
  child: Padding(
    padding: EdgeInsets.all(8),  // Add padding to reach 44x44
    child: Icon(Icons.delete),
  ),
)
```

**❌ DON'T**: Make touch targets too small

```dart
// Too small - hard to tap
GestureDetector(
  onTap: _onTap,
  child: Icon(Icons.delete),  // Only 24x24
)
```

### 2. Use Semantic Labels

**✅ DO**: Add semantic labels to components

```dart
MPButton(
  text: 'Submit',
  semanticLabel: 'Submit form',
  onPressed: _submit,
)

MPBadge(
  label: '3',
  semanticLabel: '3 new messages',
)

MPAvatar(
  name: 'John Doe',
  semanticLabel: 'User avatar for John Doe',
)
```

**❌ DON'T**: Leave components without semantic context

```dart
// Screen reader won't know what this is
Icon(Icons.menu)  // Just says "button"
```

### 3. Ensure Color Contrast

**✅ DO**: Use sufficient contrast ratios (WCAG AA: 4.5:1)

```dart
// Good contrast
Text(
  'Important Message',
  style: TextStyle(
    color: context.mp.textColor,  // Adapts for good contrast
    fontSize: 16,  // Minimum 16px for readability
  ),
)

// Good - avoid low contrast combinations
Container(
  color: context.mp.primary,  // Blue
  child: Text(
    'White Text',
    style: TextStyle(color: Colors.white),  // Good contrast
  ),
)
```

**❌ DON'T**: Use poor color combinations

```dart
// Poor contrast
Container(
  color: Colors.lightBlue,
  child: Text(
    'Light Text',
    style: TextStyle(color: Colors.lightBlue.withAlpha(50)),  // Hard to read
  ),
)
```

### 4. Test with Screen Readers

**✅ DO**: Verify your app works with VoiceOver (iOS) and TalkBack (Android)

```dart
// Good - descriptive semantic label
Semantics(
  button: true,
  label: 'Delete user profile photo',
  child: GestureDetector(
    onTap: _deletePhoto,
    child: Icon(Icons.delete),
  ),
)

// Good - use properly labeled components
MPButton(
  text: 'Save Changes',
  onPressed: _saveChanges,
)
```

**❌ DON'T**: Use unlabeled interactive elements

```dart
// Screen reader won't know what this does
GestureDetector(
  onTap: _someAction,
  child: Icon(Icons.someIcon),  // No label
)
```

---

## 📁 Code Organization

### 1. Extract Reusable Components

**✅ DO**: Create widget files for repeated UI

```dart
// lib/widgets/user_card.dart
class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MPCard(
      child: Column(
        children: [
          MPAvatar(name: user.name),
          MPText.head(user.name),
          MPText.body(user.email),
        ],
      ),
    );
  }
}

// Use multiple times
UserCard(user: user1)
UserCard(user: user2)
UserCard(user: user3)
```

**❌ DON'T**: Repeat widget code

```dart
// Repeated 3 times - hard to maintain
MPCard(child: Column(children: [MPAvatar(...), MPText(...), MPText(...)]))
MPCard(child: Column(children: [MPAvatar(...), MPText(...), MPText(...)]))
MPCard(child: Column(children: [MPAvatar(...), MPText(...), MPText(...)]))
```

### 2. Use Consistent Naming

**✅ DO**: Use descriptive names

```dart
// Clear naming
class UserProfilePage extends StatelessWidget { ... }
class UserEmailInput extends StatelessWidget { ... }
class SubmitButton extends StatelessWidget { ... }
```

**❌ DON'T**: Use vague names

```dart
// Unclear naming
class Page1 extends StatelessWidget { ... }
class Widget2 extends StatelessWidget { ... }
class Component3 extends StatelessWidget { ... }
```

### 3. Organize by Feature

**✅ DO**: Group related files

```dart
lib/
├── features/
│   ├── auth/
│   │   ├── login_page.dart
│   │   ├── register_page.dart
│   │   └── widgets/
│   │       ├── email_input.dart
│   │       └── password_input.dart
│   └── profile/
│       ├── profile_page.dart
│       └── widgets/
│           └── user_card.dart
└── widgets/
    └── shared/
        ├── loading_indicator.dart
        └── error_message.dart
```

**❌ DON'T**: Put everything in one folder

```dart
lib/
└── widgets/
    ├── login_page.dart
    ├── register_page.dart
    ├── profile_page.dart
    ├── email_input.dart
    ├── password_input.dart
    ├── user_card.dart
    ├── ... (50 more files)
```

---

## 🧪 Testing

### 1. Test Component States

**✅ DO**: Test all possible states

```dart
testWidgets('MPButton shows loading state', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MPButton(text: 'Loading', loading: true),
      ),
    ),
  );

  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});

testWidgets('MPButton is disabled when pressed is null', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MPButton(text: 'Disabled', onPressed: null),
      ),
    ),
  );

  final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
  expect(button.enabled, false);
});
```

**❌ DON'T**: Only test happy path

```dart
// Only tests default state
testWidgets('MPButton renders', (tester) async {
  await tester.pumpWidget(MaterialApp(home: MPButton(text: 'Test')));
  expect(find.text('Test'), findsOneWidget);
  // Missing: disabled state, loading state, different variants, etc.
});
```

### 2. Mock Services

**✅ DO**: Use mocks for dependencies

```dart
class MockAuthService extends Mock implements AuthService {}

testWidgets('LoginPage handles successful login', (tester) async {
  final mockAuth = MockAuthService();
  when(mockAuth.login(any, any)).thenAnswer((_) async => true);

  await tester.pumpWidget(
    MaterialApp(
      home: ChangeNotifierProvider<AuthService>.value(
        create: (_) => mockAuth,
        child: LoginPage(),
      ),
    ),
  );

  await tester.enterText(find.byType(MPTextField), 'test@example.com');
  await tester.enterText(find.byType(MPTextField).at(1), 'password');
  await tester.tap(find.byType(MPButton));
  await tester.pumpAndSettle();

  verify(mockAuth.login('test@example.com', 'password')).called(1);
});
```

**❌ DON'T**: Test with real services

```dart
// Tests depend on real API - flaky
testWidgets('LoginPage handles successful login', (tester) async {
  await tester.pumpWidget(MaterialApp(home: LoginPage()));
  await tester.enterText(find.byType(MPTextField), 'test@example.com');
  await tester.tap(find.byType(MPButton));
  // Calls real API - bad!
});
```

---

## 🔄 Common Patterns

### 1. Form Submission Pattern

```dart
class MyForm extends StatefulWidget {
  const MyForm({super.key});
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;  // Validation failed
    }

    setState(() => _loading = true);
    try {
      await _api.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      MPSnackbar.show(
        context: context,
        message: 'Login successful!',
        variant: MPSnackbarVariant.success,
      );
    } catch (e) {
      MPSnackbar.show(
        context: context,
        message: 'Login failed: $e',
        variant: MPSnackbarVariant.error,
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MPTextField(
                controller: _emailController,
                hintText: 'Email',
                validator: (v) => v?.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              MPTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                validator: (v) => v?.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              MPButton(
                text: 'Login',
                loading: _loading,
                onPressed: _loading ? null : _submit,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 2. Empty State Pattern

```dart
class EmptyList extends StatelessWidget {
  const EmptyList({super.key, this.onRefresh});
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: MPEmptyState(
          icon: Icons.inbox,
          title: 'No Items Yet',
          description: 'Start by adding your first item',
          action: MPButton(
            text: 'Add Item',
            variant: MPButtonVariant.outlined,
            onPressed: onRefresh,
          ),
        ),
      ),
    );
  }
}
```

### 3. Loading State Pattern

```dart
class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const MPCircularProgress(),
          const SizedBox(height: 16),
          MPText.label('Loading...', style: TextStyle(color: context.mp.subtitleColor)),
        ],
      ),
    );
  }
}
```

### 4. Error State Pattern

```dart
class ErrorContent extends StatelessWidget {
  const ErrorContent({super.key, required this.error, this.onRetry});
  final String error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: MPEmptyState(
          icon: Icons.error_outline,
          title: 'Something Went Wrong',
          description: error,
          action: onRetry != null
              ? MPButton(
                  text: 'Retry',
                  variant: MPButtonVariant.primary,
                  onPressed: onRetry,
                )
              : null,
        ),
      ),
    );
  }
}
```

---

## 🔗 Related Documentation

- [Getting Started](../getting-started/README.md)
- [Component API](../api/README.md)
- [Quick Reference](../component-quick-reference.md)
- [Theme System](../guides/theming.md)

## 🆘 Need Help?

- Check [Troubleshooting](./troubleshooting.md)
- Review [Examples](../examples/README.md)
- Search [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues)
