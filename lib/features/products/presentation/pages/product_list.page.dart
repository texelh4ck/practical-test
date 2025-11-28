import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:practical_test/config/routes/router.dart';
import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/features/auth/domain/usecases/logout.dart';
import 'package:practical_test/features/products/domain/entities/product.entity.dart';
import 'package:practical_test/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:practical_test/features/products/presentation/bloc/products/products_state.dart';
import 'package:practical_test/features/products/presentation/widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is DoneProducts) {
            return _buildProductList(state.products!);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text("Perfil"),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: Text("Mis Productos"),
                leading: Icon(Icons.shopping_bag),
                onTap: () {
                  Navigator.pushNamed(context, '/my-products');
                },
              ),
              ListTile(
                title: Text("Configuraciones"),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              Spacer(),
              ListTile(
                title: Text("Cerrar sesión"),
                leading: Icon(Icons.logout),
                onTap: () => _btLogout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildProductList(List<ProductEntity> products) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
        childAspectRatio: 0.7, // Aspect ratio of each item
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }

  void _btLogout(BuildContext context) async {
    LogoutUseCase usecase = GetIt.instance.get();
    final state = await usecase();
    if (state is DataSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.initialRoute,
        (route) => false,
      );
    }
  }
}
