/// Central definition of the application's top-level routes.
///
/// Keeping the paths in one place avoids typos when navigating and makes it
/// easy to add nested routes later.
abstract final class AppRoutes {
  static const library = '/library';
  static const search = '/search';
  static const history = '/history';
  static const orders = '/orders';
  static const settings = '/settings';

  /// The create/edit entry form. [editorWithId] opens it for an existing entry.
  static const editor = '/editor';
  static String editorWithId(String id) => '$editor/$id';
}
