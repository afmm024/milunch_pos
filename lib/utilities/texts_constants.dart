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
  static List<String> titles = <String>[
    'Efectivo',
    'Nequi',
    'Daviplata',
    'Mixto'
  ];
  static List<String> ids = <String>['efectivo', 'nequi', 'daviplata', 'mixto'];
  static List<String> imagesFromNetwork = <String>[
    "https://cdn-icons-png.freepik.com/512/3898/3898031.png",
    "https://seeklogo.com/images/N/nequi-logo-58FBE82BA6-seeklogo.com.png",
    "https://seeklogo.com/images/D/daviplata-logo-C6804BA51B-seeklogo.com.png",
    "https://cdn-icons-png.flaticon.com/512/4564/4564998.png"
  ];
}

class DatabaseEnv {
  static String mongoUri() =>
      "mongodb+srv://munozmarinandresfelipe:P3FukYeZ4y37Mz2k@devcluster.1otn7gc.mongodb.net/Develop?retryWrites=true&w=majority&appName=DevCluster";
  static String categoriesCollect() => "categories";
  static String productCollect() => "products_beta";
  static String usersCollect() => "users";
  static String orderCollect() => "orders";
  static String paramsCollect() => "params";
  static String turnCollect() => "turns";
}
