/// Typed route paths. Widgets never use raw string paths; they use these
/// constants (and, from M1 on, generated typed helpers per route).
abstract final class RibhRoutes {
  static const auth = '/auth';
  static const home = '/home';
  static const invest = '/invest';
  static const grow = '/grow';
  static const barakah = '/barakah';
  static const me = '/me';

  /// Pushed route over the shell; opened from Home's wallet entry.
  static const wallet = '/wallet';

  /// Campaign detail, pushed with a Hero from marketplace and portfolio.
  static const campaignPattern = '/campaign/:id';
  static String campaign(String id) => '/campaign/$id';

  /// Service pages (real bodies arrive in M7; the routes are real now).
  static const servicePattern = '/services/:id';
  static String service(String id) => '/services/$id';

  /// Me sub-pages (pushed).
  static const shariahBoard = '/me/shariah-board';
  static const help = '/me/help';
}
