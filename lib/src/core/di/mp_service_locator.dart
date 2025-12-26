import 'package:get_it/get_it.dart';

/// MicroPack UI Kit Service Locator
///
/// Central dependency injection container for all services and singletons.
/// Uses get_it package for fast and efficient service resolution.
class MPServiceLocator {
  MPServiceLocator._();

  /// Singleton instance
  static final MPServiceLocator _instance = MPServiceLocator._();

  /// Get the singleton instance
  static MPServiceLocator get instance => _instance;

  /// GetIt service locator instance
  final GetIt _getIt = GetIt.instance;

  /// Check if service locator is initialized
  bool _isInitialized = false;

  /// Initialize all core services
  ///
  /// Call this in main() before runApp()
  void init({
    bool allowReinit = false,
  }) {
    if (_isInitialized && !allowReinit) {
      return;
    }

    // Register all core services here
    // Future services can be added as needed

    _isInitialized = true;
  }

  /// Reset the service locator
  ///
  /// Useful for testing or app restart scenarios
  void reset() {
    _getIt.reset();
    _isInitialized = false;
  }

  /// Register a lazy singleton
  ///
  /// The service will be created only when first requested
  /// and the same instance will be returned on subsequent calls
  void registerLazySingleton<T extends Object>(T Function() factoryFunc) {
    if (_getIt.isRegistered<T>()) {
      _getIt.unregister<T>();
    }
    _getIt.registerLazySingleton<T>(factoryFunc);
  }

  /// Register a singleton
  ///
  /// The service will be created immediately
  /// and the same instance will be returned on subsequent calls
  void registerSingleton<T extends Object>(T instance) {
    if (_getIt.isRegistered<T>()) {
      _getIt.unregister<T>();
    }
    _getIt.registerSingleton<T>(instance);
  }

  /// Register a factory
  ///
  /// A new instance will be created each time the service is requested
  void registerFactory<T extends Object>(T Function() factoryFunc) {
    if (_getIt.isRegistered<T>()) {
      _getIt.unregister<T>();
    }
    _getIt.registerFactory<T>(factoryFunc);
  }

  /// Get a registered service
  ///
  /// Throws StateError if service is not registered
  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  /// Check if a service is registered
  bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }

  /// Unregister a service
  ///
  /// Returns true if service was unregistered, false if it wasn't registered
  bool unregister<T extends Object>() {
    if (_getIt.isRegistered<T>()) {
      _getIt.unregister<T>();
      return true;
    }
    return false;
  }
}

/// Extension for convenient service access
extension MPServiceLocatorExtension on MPServiceLocator {
  /// Convenience getter for accessing services
  /// Usage: MPServiceLocator.instance<MyService>()
  T call<T extends Object>() => get<T>();
}

/// Global convenience accessor for service locator
///
/// Usage:
/// ```dart
/// final myService = mpServiceLocator<MyService>();
/// // or
/// final myService = MPServiceLocator.instance.get<MyService>();
/// ```
T mpServiceLocator<T extends Object>() {
  return MPServiceLocator.instance.get<T>();
}
