import 'package:practical_test/features/products/domain/entities/product.entity.dart';

abstract class ProductsState {
  final List<ProductEntity>? products;

  ProductsState({this.products});
}

class InitialProductState extends ProductsState {}

class LoadingProductsState extends ProductsState {}

class DoneProducts extends ProductsState {
  DoneProducts({super.products});
}
