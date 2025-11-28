import 'package:get_it/get_it.dart';
import 'package:practical_test/features/auth/domain/repository/auth_repository.dart';
import 'package:practical_test/features/auth/presentation/pages/login.page.dart';
import 'package:practical_test/features/products/presentation/pages/details.page.dart';
import 'package:practical_test/features/products/presentation/pages/product_list.page.dart';
import 'package:practical_test/features/shared/pages/not_implemented.page.dart';

class AppRouter {
  static get initialRoute {
    final AuthRepository auth = GetIt.instance.get<AuthRepository>();
    if (auth.currentUser != null) {
      return '/products';
    }
    return '/auth/login';
    // return '/auth/login';
  }

  static get routes => {
    '/auth/login': (_) => LoginPage(),
    '/products': (_) => ProductListPage(),
    '/products/details': (_) => DetailsProductPage(),
    '/profile': (_) => NotImplementedPage(),
    '/my-products': (_) => NotImplementedPage(),
    '/settings': (_) => NotImplementedPage(),
  };
}
