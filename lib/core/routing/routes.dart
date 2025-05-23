abstract class Routes {
  // 메인화면
  static const String devHome = '/dev-home';
  static const String devComponents = '/dev-components';

  static const String login = '/login';
  static const String splash = '/splash';

  // 레시피 화면
  static const String savedRecipes = '/saved-recipes';
  static const String filter = '/filter';
  static const String search = 'search';
  static const String homeSearch = '$mainHome/$search';
  static const String recipeDetail = '/recipe-detail/:id';
  static String recipeDetailPath(int id) => '/recipe-detail/$id';

  static const String mainHome = '/home';
  static const String mainCreate = '/create';
  static const String mainNotifications = '/notifications';
  static const String mainProfile = '/profile';
}
