class MySingleton {
  // Private constructor to prevent instantiation from outside the class.
  MySingleton._();

  // Singleton instance variable to hold the single instance of the class.
  static final MySingleton _instance = MySingleton._();

  // Factory method to provide access to the singleton instance.
  factory MySingleton() {
    return _instance;
  }

  // Variables to store your values.
  String email = '';
  String phone = '';

  // Add other variables as needed.
}
