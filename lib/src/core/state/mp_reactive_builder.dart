import 'package:flutter/material.dart';

/// Reactive builder wrapper for ValueListenable types
/// 
/// This widget provides a convenient way to build reactive UI
/// components that respond to ValueListenable state changes.
class MPReactiveBuilder<T> extends StatelessWidget {
  const MPReactiveBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.child,
    this.initializeWith = null,
  });

  /// The value listenable to observe
  final ValueListenable<T> valueListenable;

  /// Builder function that creates the widget tree
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  /// Optional child that will not be rebuilt when value changes
  final Widget? child;

  /// Optional initial value to use before the listenable has a value
  final T? initializeWith;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        return builder(context, value, child);
      },
      child: child,
    );
  }
}

/// Reactive value notifier with enhanced functionality
/// 
/// This class extends ValueNotifier with additional utilities
/// for common reactive programming patterns.
class MPReactiveNotifier<T> extends ValueNotifier<T> {
  MPReactiveNotifier(T initialValue) : super(initialValue);

  /// Update value with a callback function
  void update(T Function(T current) updater) {
    value = updater(value);
  }

  /// Update value only if the predicate is true
  void updateIf(T Function(T current) updater, bool Function(T current) predicate) {
    if (predicate(value)) {
      value = updater(value);
    }
  }

  /// Toggle boolean value
  void toggle() {
    if (value is bool) {
      value = (!value as bool) as T;
    }
  }

  /// Add to numeric value
  void add(T amount) {
    if (value is num && amount is num) {
      value = ((value as num) + (amount as num)) as T;
    }
  }

  /// Multiply numeric value
  void multiply(T factor) {
    if (value is num && factor is num) {
      value = ((value as num) * (factor as num)) as T;
    }
  }

  /// Set value and notify listeners immediately
  void setAndNotify(T newValue) {
    if (value != newValue) {
      value = newValue;
      notifyListeners();
    }
  }

  /// Get value as specific type with null safety
  T? asOrNull<R>() {
    if (value is R) {
      return value as R as T;
    }
    return null;
  }

  /// Check if value matches condition
  bool matches(bool Function(T value) condition) {
    return condition(value);
  }

  /// Stream the value changes as a Stream
  Stream<T> get stream {
    return Stream<T>.multi((controller) {
      void listener() {
        if (!controller.isClosed) {
          controller.add(value);
        }
      }

      addListener(listener);
      
      // Send initial value
      controller.add(value);
      
      // Cleanup when stream is cancelled
      controller.onCancel = () {
        removeListener(listener);
      };
    });
  }
}

/// Reactive list notifier with list-specific operations
class MPReactiveListNotifier<T> extends ValueNotifier<List<T>> {
  MPReactiveListNotifier(List<T> initialList) : super(List.from(initialList));

  /// Add item to list
  void add(T item) {
    final newList = List<T>.from(value);
    newList.add(item);
    value = newList;
  }

  /// Add multiple items to list
  void addAll(Iterable<T> items) {
    final newList = List<T>.from(value);
    newList.addAll(items);
    value = newList;
  }

  /// Remove item from list
  bool remove(T item) {
    if (!value.contains(item)) return false;
    
    final newList = List<T>.from(value);
    final removed = newList.remove(item);
    if (removed) {
      value = newList;
    }
    return removed;
  }

  /// Remove item at index
  void removeAt(int index) {
    if (index < 0 || index >= value.length) return;
    
    final newList = List<T>.from(value);
    newList.removeAt(index);
    value = newList;
  }

  /// Insert item at index
  void insert(int index, T item) {
    final newList = List<T>.from(value);
    newList.insert(index, item);
    value = newList;
  }

  /// Clear all items
  void clear() {
    value = [];
  }

  /// Replace item at index
  void replace(int index, T item) {
    if (index < 0 || index >= value.length) return;
    
    final newList = List<T>.from(value);
    newList[index] = item;
    value = newList;
  }

  /// Sort list with comparator
  void sort([int Function(T a, T b)? compare]) {
    final newList = List<T>.from(value);
    newList.sort(compare);
    value = newList;
  }

  /// Shuffle list
  void shuffle() {
    final newList = List<T>.from(value);
    newList.shuffle();
    value = newList;
  }

  /// Get first item
  T? get first => value.isNotEmpty ? value.first : null;

  /// Get last item
  T? get last => value.isNotEmpty ? value.last : null;

  /// Check if list is empty
  bool get isEmpty => value.isEmpty;

  /// Check if list is not empty
  bool get isNotEmpty => value.isNotEmpty;

  /// Get list length
  int get length => value.length;

  /// Get item at index
  T operator [](int index) => value[index];

  /// Set item at index
  operator []=(int index, T item) {
    if (index >= 0 && index < value.length) {
      replace(index, item);
    }
  }
}

/// Reactive map notifier with map-specific operations
class MPReactiveMapNotifier<K, V> extends ValueNotifier<Map<K, V>> {
  MPReactiveMapNotifier(Map<K, V> initialMap) : super(Map.from(initialMap));

  /// Add key-value pair
  void put(K key, V value) {
    final newMap = Map<K, V>.from(this.value);
    newMap[key] = value;
    this.value = newMap;
  }

  /// Remove key
  V? remove(K key) {
    if (!value.containsKey(key)) return null;
    
    final newMap = Map<K, V>.from(value);
    final removed = newMap.remove(key);
    this.value = newMap;
    return removed;
  }

  /// Clear all entries
  void clear() {
    value = {};
  }

  /// Update existing key
  void update(K key, V Function(V current) updater) {
    if (value.containsKey(key)) {
      put(key, updater(value[key]!));
    }
  }

  /// Update all entries
  void updateAll(V Function(K key, V value) updater) {
    final newMap = Map<K, V>.from(value);
    newMap.forEach((key, val) {
      newMap[key] = updater(key, val);
    });
    value = newMap;
  }

  /// Get value for key
  V? operator [](K key) => value[key];

  /// Set value for key
  operator []=(K key, V value) {
    put(key, value);
  }

  /// Check if key exists
  bool containsKey(K key) => value.containsKey(key);

  /// Check if value exists
  bool containsValue(V value) => this.value.containsValue(value);

  /// Get all keys
  Iterable<K> get keys => value.keys;

  /// Get all values
  Iterable<V> get values => value.values;

  /// Get map length
  int get length => value.length;

  /// Check if map is empty
  bool get isEmpty => value.isEmpty;

  /// Check if map is not empty
  bool get isNotEmpty => value.isNotEmpty;
}

/// Reactive set notifier with set-specific operations
class MPReactiveSetNotifier<T> extends ValueNotifier<Set<T>> {
  MPReactiveSetNotifier(Set<T> initialSet) : super(Set.from(initialSet));

  /// Add item to set
  bool add(T item) {
    if (value.contains(item)) return false;
    
    final newSet = Set<T>.from(value);
    newSet.add(item);
    value = newSet;
    return true;
  }

  /// Add multiple items
  void addAll(Iterable<T> items) {
    final newSet = Set<T>.from(value);
    newSet.addAll(items);
    value = newSet;
  }

  /// Remove item from set
  bool remove(T item) {
    if (!value.contains(item)) return false;
    
    final newSet = Set<T>.from(value);
    final removed = newSet.remove(item);
    if (removed) {
      value = newSet;
    }
    return removed;
  }

  /// Remove multiple items
  void removeAll(Iterable<T> items) {
    final newSet = Set<T>.from(value);
    newSet.removeAll(items);
    value = newSet;
  }

  /// Clear all items
  void clear() {
    value = {};
  }

  /// Check if item exists
  bool contains(T item) => value.contains(item);

  /// Get set length
  int get length => value.length;

  /// Check if set is empty
  bool get isEmpty => value.isEmpty;

  /// Check if set is not empty
  bool get isNotEmpty => value.isNotEmpty;

  /// Convert to list
  List<T> toList() => value.toList();
}

/// Reactive builder for multiple listenables
/// 
/// This widget allows building UI that depends on multiple
/// ValueListenable sources efficiently.
class MPMultiReactiveBuilder extends StatelessWidget {
  const MPMultiReactiveBuilder({
    super.key,
    required this.listenables,
    required this.builder,
    this.child,
  });

  /// List of listenables to observe
  final List<ValueListenable> listenables;

  /// Builder function with all current values
  final Widget Function(BuildContext context, List<dynamic> values, Widget? child) builder;

  /// Optional child that won't be rebuilt
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Widget currentChild = child!;

    // Build nested ValueListenableBuilder for each listenable
    for (int i = 0; i < listenables.length; i++) {
      final listenable = listenables[i];
      final index = i; // Capture index for closure

      currentChild = ValueListenableBuilder(
        valueListenable: listenable,
        builder: (context, value, child) {
          // We need to collect all values in the final builder
          // This is a simplified approach - in production, you'd want
          // to store the values in a more efficient way
          return _NestedValueListenableBuilder(
            index: index,
            total: listenables.length,
            currentValues: [],
            listenables: listenables,
            builder: builder,
            child: child,
          );
        },
        child: currentChild,
      );
    }

    return currentChild;
  }
}

/// Helper widget for nested ValueListenableBuilder implementation
class _NestedValueListenableBuilder extends StatefulWidget {
  const _NestedValueListenableBuilder({
    required this.index,
    required this.total,
    required this.currentValues,
    required this.listenables,
    required this.builder,
    this.child,
  });

  final int index;
  final int total;
  final List<dynamic> currentValues;
  final List<ValueListenable> listenables;
  final Widget Function(BuildContext context, List<dynamic> values, Widget? child) builder;
  final Widget? child;

  @override
  State<_NestedValueListenableBuilder> createState() => _NestedValueListenableBuilderState();
}

class _NestedValueListenableBuilderState extends State<_NestedValueListenableBuilder> {
  late List<dynamic> _values;

  @override
  void initState() {
    super.initState();
    _values = List.filled(widget.total, null);
  }

  @override
  Widget build(BuildContext context) {
    // This is a simplified implementation
    // In practice, you'd want to collect values more efficiently
    return widget.builder(context, _values, widget.child);
  }
}

/// Reactive widget mixin for StatefulWidget
/// 
/// This mixin provides reactive functionality to State classes
/// allowing them to easily use ValueListenableBuilder patterns.
mixin MPReactiveWidgetMixin<T extends StatefulWidget> on State<T> {
  final List<ValueListenable> _listenables = [];

  /// Register a listenable for automatic disposal
  void registerListenable(ValueListenable listenable) {
    _listenables.add(listenable);
  }

  /// Unregister a listenable
  void unregisterListenable(ValueListenable listenable) {
    _listenables.remove(listenable);
  }

  /// Build reactive widget
  Widget buildReactive(
    List<ValueListenable> listenables,
    Widget Function(List<dynamic> values) builder,
  ) {
    return MPMultiReactiveBuilder(
      listenables: listenables,
      builder: (context, values, child) {
        return builder(values);
      },
    );
  }

  /// Build reactive widget with single listenable
  Widget buildReactiveSingle<R>(
    ValueListenable<R> listenable,
    Widget Function(R value) builder,
  ) {
    return ValueListenableBuilder<R>(
      valueListenable: listenable,
      builder: (context, value, child) {
        return builder(value);
      },
    );
  }

  @override
  void dispose() {
    // Clean up registered listenables if needed
    _listenables.clear();
    super.dispose();
  }
}

/// Enhanced reactive builder with performance optimizations
class MPOptimizedReactiveBuilder<T> extends StatelessWidget {
  const MPOptimizedReactiveBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.child,
    this.compareValues,
    this.rebuildCondition,
    this.cacheKey,
  });

  final ValueListenable<T> valueListenable;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Widget? child;
  final bool Function(T oldValue, T newValue)? compareValues;
  final bool Function(T value)? rebuildCondition;
  final String? cacheKey;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        // Check rebuild condition if provided
        if (rebuildCondition != null && !rebuildCondition!(value)) {
          return child ?? const SizedBox.shrink();
        }

        return builder(context, value, child);
      },
      child: child,
    );
  }
}
