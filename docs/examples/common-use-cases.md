# Common Use Cases

Real-world examples of how to use Micropack UI Kit components in common scenarios.

## 📋 Table of Contents

- [Authentication Forms](#authentication-forms)
- [User Profiles](#user-profiles)
- [Settings Pages](#settings-pages)
- [Lists & Grids](#lists--grids)
- [Empty States](#empty-states)
- [Loading States](#loading-states)
- [Success/Error Feedback](#successerror-feedback)
- [Dashboard Widgets](#dashboard-widgets)
- [Search & Filter](#search--filter)
- [Confirmation Dialogs](#confirmation-dialogs)

---

## 🔐 Authentication Forms

### Login Form

```dart
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _rememberMe = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      await _authService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        MPSnackbar.show(
          context: context,
          message: 'Login successful!',
          variant: MPSnackbarVariant.success,
        );
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (mounted) {
        MPSnackbar.show(
          context: context,
          message: 'Login failed: ${e.toString()}',
          variant: MPSnackbarVariant.error,
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MPText.head(
                    'Sign In',
                    fontSize: 28,
                  ),
                  const SizedBox(height: 8),
                  MPText.body(
                    'Enter your credentials to continue',
                    style: TextStyle(
                      color: context.mp.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  MPTextField(
                    hintText: 'Email Address',
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email is required';
                      }
                      if (!value!.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  MPTextField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    prefixIcon: Icons.lock,
                    suffixIcon: Icons.visibility,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Password is required';
                      }
                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      MPCheckbox(
                        value: _rememberMe,
                        onToggle: (value) =>
                            setState(() => _rememberMe = value ?? false),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: MPText.label('Remember me'),
                      ),
                      const Spacer(),
                      MPButton(
                        text: 'Forgot Password?',
                        variant: MPButtonVariant.text,
                        size: MPButtonSize.small,
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/forgot-password'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  MPButton(
                    text: 'Sign In',
                    variant: MPButtonVariant.primary,
                    size: MPButtonSize.large,
                    loading: _loading,
                    width: double.infinity,
                    onPressed: _loading ? null : _login,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MPText.body('Don\'t have an account?'),
                      const SizedBox(width: 4),
                      MPButton(
                        text: 'Sign Up',
                        variant: MPButtonVariant.text,
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

---

## 👤 User Profiles

### User Profile Card

```dart
class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MPCard(
      elevation: true,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.mp.primary.withValues(alpha: 0.8),
                      context.mp.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                child: MPAvatar(
                  image: NetworkImage(user.avatarUrl),
                  name: user.name,
                  size: 64,
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                MPText.head(
                  user.name,
                  fontSize: 20,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                MPText.label(
                  user.role,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.mp.subtitleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  children: user.skills
                          .map((skill) => MPChip(
                                label: skill,
                                variant: MPChipVariant.outlined,
                              ))
                          .toList(),
                ),
                const SizedBox(height: 16),
                Divider(color: context.mp.dividerColor),
                const SizedBox(height: 16),
                _ProfileRow(
                  icon: Icons.email,
                  label: user.email,
                ),
                const SizedBox(height: 12),
                _ProfileRow(
                  icon: Icons.phone,
                  label: user.phone,
                ),
                const SizedBox(height: 12),
                _ProfileRow(
                  icon: Icons.location_on,
                  label: user.location,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: MPButton(
                        text: 'Message',
                        variant: MPButtonVariant.outlined,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MPButton(
                        text: 'Edit Profile',
                        variant: MPButtonVariant.primary,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    super.key,
    required this.icon,
    required this.label,
  });
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.mp.subtitleColor),
        const SizedBox(width: 12),
        Expanded(
          child: MPText.body(
            label,
            style: TextStyle(color: context.mp.subtitleColor),
          ),
        ),
      ],
    );
  }
}
```

---

## ⚙️ Settings Pages

### Settings List with Toggles

```dart
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: MPText.subhead('Account'),
          ),
          _SettingsTile(
            icon: Icons.person,
            title: 'Profile Settings',
            description: 'Update your profile information',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.security,
            title: 'Security',
            description: 'Change password and 2FA',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MPText.subhead('Preferences'),
          ),
          _SettingsToggle(
            icon: Icons.notifications,
            title: 'Push Notifications',
            description: 'Receive push notifications',
            value: true,
            onChanged: (value) {},
          ),
          _SettingsToggle(
            icon: Icons.email,
            title: 'Email Notifications',
            description: 'Receive email updates',
            value: true,
            onChanged: (value) {},
          ),
          _SettingsToggle(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            description: 'Use dark theme',
            value: false,
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MPText.subhead('Data & Storage'),
          ),
          _SettingsTile(
            icon: Icons.storage,
            title: 'Storage',
            description: 'Manage your storage space',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.download,
            title: 'Export Data',
            description: 'Download your data',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MPButton(
              text: 'Sign Out',
              variant: MPButtonVariant.danger,
              width: double.infinity,
              onPressed: () => _showSignOutDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    MPDialog.show(
      context: context,
      title: 'Sign Out',
      content: 'Are you sure you want to sign out?',
      type: DialogType.warning,
      confirmText: 'Sign Out',
      cancelText: 'Cancel',
      onConfirm: () {
        Navigator.of(context).pop();
        // Handle sign out
      },
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  const _SettingsToggle({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MPListTile(
        leading: Icon(icon, color: context.mp.primary),
        title: Text(title),
        subtitle: Text(
          description,
          style: TextStyle(color: context.mp.subtitleColor),
        ),
        trailing: MPSwitch(
          value: value,
          onToggle: onChanged,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MPListTile(
        leading: Icon(icon, color: context.mp.primary),
        title: Text(title),
        subtitle: Text(
          description,
          style: TextStyle(color: context.mp.subtitleColor),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
```

---

## 📋 Lists & Grids

### User List with Status Badges

```dart
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final List<User> _users = [
    User(name: 'John Doe', status: 'online'),
    User(name: 'Jane Smith', status: 'away'),
    User(name: 'Bob Wilson', status: 'offline'),
    User(name: 'Alice Brown', status: 'online'),
  ];
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          MPButton(
            text: 'Filter',
            icon: Icons.filter_list,
            variant: MPButtonVariant.outlined,
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return _UserListItem(user: user);
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    MPDialog.show(
      context: context,
      title: 'Filter Users',
      customContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MPChip(
            label: 'All',
            variant: MPChipVariant.filter,
            selected: _filter == 'all',
            onTap: () => setState(() => _filter = 'all'),
          ),
          const SizedBox(width: 8),
          MPChip(
            label: 'Online',
            variant: MPChipVariant.filter,
            selected: _filter == 'online',
            onTap: () => setState(() => _filter = 'online'),
          ),
          const SizedBox(width: 8),
          MPChip(
            label: 'Offline',
            variant: MPChipVariant.filter,
            selected: _filter == 'offline',
            onTap: () => setState(() => _filter = 'offline'),
          ),
        ],
      ),
    );
  }
}

class _UserListItem extends StatelessWidget {
  const _UserListItem({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MPListTile(
      leading: MPAvatar(
        name: user.name,
        size: 48,
      ),
      title: Text(user.name),
      subtitle: Text(
        'Last seen 2 hours ago',
        style: TextStyle(color: context.mp.subtitleColor),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StatusBadge(status: user.status),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: context.mp.subtitleColor),
        ],
      ),
      onTap: () => print('Tap user'),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final isOnline = status == 'online';
    return MPBadge(
      label: status,
      variant: MPBadgeVariant.notification,
      leading: Icon(
        isOnline ? Icons.circle : Icons.circle_outlined,
        size: 8,
        color: isOnline ? context.mp.successColor : context.mp.subtitleColor,
      ),
    );
  }
}
```

---

## 📭 Empty States

### Empty List with Action

```dart
class EmptyListPage extends StatelessWidget {
  const EmptyListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
      ),
      body: MPEmptyState(
        icon: Icons.inbox,
        title: 'No Tasks Yet',
        description: 'You haven\'t created any tasks. Start by adding your first task!',
        action: MPButton(
          text: 'Create Task',
          icon: Icons.add,
          variant: MPButtonVariant.primary,
          onPressed: () => _showCreateTaskDialog(context),
        ),
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context) {
    MPDialog.show(
      context: context,
      title: 'Create New Task',
      content: 'Enter task details below',
      confirmText: 'Create',
      onConfirm: () {
        Navigator.of(context).pop();
        MPToast.show(
          context: context,
          message: 'Task created successfully!',
          type: MPToastType.success,
        );
      },
    );
  }
}
```

---

## ⏳ Loading States

### Full Page Loading

```dart
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading...'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MPCircularProgress(),
            const SizedBox(height: 16),
            MPText.label(
              'Please wait...',
              style: TextStyle(color: context.mp.subtitleColor),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Card Loading Skeleton

```dart
class LoadingUserCard extends StatelessWidget {
  const LoadingUserCard({super.key});
  @override
  Widget build(BuildContext context) {
    return MPCard(
      child: Column(
        children: [
          Row(
            children: [
              MPSkeleton(type: MPSkeletonType.circle, size: 64),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPSkeleton(type: MPSkeletonType.line, width: 150),
                    const SizedBox(height: 8),
                    MPSkeleton(type: MPSkeletonType.line, width: 100),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          MPSkeleton(type: MPSkeletonType.rect, width: double.infinity, height: 120),
          const SizedBox(height: 12),
          MPSkeleton(type: MPSkeletonType.line, width: 200),
          MPSkeleton(type: MPSkeletonType.line, width: 150),
        ],
      ),
    );
  }
}
```

---

## ✅ Success/Error Feedback

### Form Submission Feedback

```dart
class SubmissionHandler {
  static Future<void> handleSubmit(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    try {
      await action();

      if (context.mounted) {
        MPSnackbar.show(
          context: context,
          message: 'Changes saved successfully!',
          variant: MPSnackbarVariant.success,
        );
      }
    } catch (e) {
      if (context.mounted) {
        MPSnackbar.show(
          context: context,
          message: 'Error: ${e.toString()}',
          variant: MPSnackbarVariant.error,
          duration: const Duration(seconds: 5),
          action: MPSnackbarAction(
            label: 'RETRY',
            onPressed: () => handleSubmit(context, action),
          ),
        );
      }
    }
  }
}

// Usage
class MyForm extends StatelessWidget {
  const MyForm({super.key});
  @override
  Widget build(BuildContext context) {
    return MPButton(
      text: 'Save',
      onPressed: () => SubmissionHandler.handleSubmit(
        context,
        _saveChanges,
      ),
    );
  }
}
```

---

## 🎯 Dashboard Widgets

### Stats Card with Progress

```dart
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.progress,
    required this.icon,
    this.color,
  });
  final String title;
  final String value;
  final double progress;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? context.mp.primary;
    return MPCard(
      elevation: true,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: cardColor, size: 24),
                ),
                const Spacer(),
                MPText.label(
                  'This Month',
                  style: TextStyle(color: context.mp.subtitleColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MPText.head(
              value,
              fontSize: 32,
              style: TextStyle(color: cardColor),
            ),
            const SizedBox(height: 8),
            MPText.body(
              title,
              style: TextStyle(color: context.mp.subtitleColor),
            ),
            const SizedBox(height: 16),
            MPProgressBar(
              value: progress,
              color: cardColor,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MPText.small(
                  '${(progress * 100).toInt()}% complete',
                  style: TextStyle(color: context.mp.subtitleColor),
                ),
                MPText.small(
                  'View Details',
                  style: TextStyle(color: context.mp.primary),
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

---

## 🔍 Search & Filter

### Search Bar with Filters

```dart
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String _category = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: MPTextField(
              hintText: 'Search...',
              controller: _searchController,
              prefixIcon: Icons.search,
              onSubmitted: (value) => _performSearch(value),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _CategoryChip(
                  label: 'All',
                  selected: _category == 'all',
                  onTap: () => setState(() => _category = 'all'),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: 'Products',
                  selected: _category == 'products',
                  onTap: () => setState(() => _category = 'products'),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: 'Services',
                  selected: _category == 'services',
                  onTap: () => setState(() => _category = 'services'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch(String query) {
    MPToast.show(
      context: context,
      message: 'Searching for: $query',
      type: MPToastType.info,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MPChip(
      label: label,
      variant: MPChipVariant.filter,
      selected: selected,
      onTap: onTap,
    );
  }
}
```

---

## 🗑️ Confirmation Dialogs

### Delete Confirmation with Undo

```dart
class DeleteHandler {
  static Future<void> confirmDelete(
    BuildContext context, {
    required String itemName,
    required Future<void> Function() onDelete,
  }) async {
    final confirmed = await _showConfirmDialog(context, itemName);
    if (!confirmed) return;

    try {
      await onDelete();

      if (context.mounted) {
        MPSnackbar.show(
          context: context,
          message: '$itemName deleted',
          variant: MPSnackbarVariant.info,
          action: MPSnackbarAction(
            label: 'UNDO',
            onPressed: () => _undoDelete(),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        MPToast.show(
          context: context,
          message: 'Failed to delete: ${e.toString()}',
          type: MPToastType.error,
        );
      }
    }
  }

  static Future<bool> _showConfirmDialog(
    BuildContext context,
    String itemName,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => MPDialog(
        title: 'Delete $itemName',
        content: 'This action cannot be undone. Are you sure?',
        type: DialogType.warning,
        confirmText: 'Delete',
        cancelText: 'Cancel',
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
    return result ?? false;
  }

  static void _undoDelete() {
    // Implement undo logic
    MPToast.show(
      context: context,
      message: 'Item restored',
      type: MPToastType.success,
    );
  }
}

// Usage
MPButton(
  text: 'Delete',
  variant: MPButtonVariant.danger,
  onPressed: () => DeleteHandler.confirmDelete(
    context,
    itemName: 'User',
    onDelete: _deleteUser,
  ),
)
```

---

## 🔗 Related Documentation

- [Getting Started](../getting-started/README.md)
- [Component API](../api/README.md)
- [Best Practices](./best-practices.md)
- [Quick Reference](../component-quick-reference.md)

## 🆘 Need Help?

- Check [Troubleshooting](./troubleshooting.md)
- Review [Examples](../examples/README.md)
- Search [GitHub Issues](https://github.com/ajianaz/micropack-ui-kit/issues)
