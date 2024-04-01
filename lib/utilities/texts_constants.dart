class Texts {
  static String titleApp() => 'Mi Lunch POS';
  static String titleAppHome() => 'Mi Lunch';
  static String titleMenu() => 'Menu';

  static String hello() => 'Hola!';
  static String loginText() => 'Ingresa tu codigo de sesión para iniciar turno';

  static String cancel() => 'Cancel';
  static String delete() => 'Delete';
  static String logout() => 'Logout';
  static String no() => 'No';
  static String yes() => 'Yes';
  static String close() => 'Close';

  static String turneActive() => 'TurneActive';

  static String errorLogin() => 'Error al iniciar tuno';
}

class DatabaseEnv {
  static String mongoUri() =>
      "mongodb+srv://munozmarinandresfelipe:P3FukYeZ4y37Mz2k@devcluster.1otn7gc.mongodb.net/Develop?retryWrites=true&w=majority&appName=DevCluster";
  static String categoriesCollect() => "categories";
  static String productCollect() => "products_beta";
  static String usersCollect() => "users";
}
