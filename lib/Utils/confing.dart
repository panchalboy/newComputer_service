enum Flavor { DEV, PROD, TEST }

class Config {
  static Flavor appFlavor;
  static String get baseUrlLogin {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'http://rapid.quizpe.in/api/';
      default:
        return 'http://rapid.quizpe.in/api/';
    }
  }
}
