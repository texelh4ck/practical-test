import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/features/products/domain/entities/product.entity.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductEntity>>> getProducts(int page);
}
