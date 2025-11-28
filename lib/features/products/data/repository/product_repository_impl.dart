import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/features/products/data/data_sources/store_api.dart';
import 'package:practical_test/features/products/data/models/product.model.dart';
import 'package:practical_test/features/products/domain/entities/product.entity.dart';
import 'package:practical_test/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final StoreApi _storeApi = StoreApi();

  @override
  Future<DataState<List<ProductEntity>>> getProducts(int page) async {
    try {
      final products = await _storeApi.getProducts(page: page);
      List<ProductEntity> ps = [];
      for (var p in products.data) {
        ps.add(ProductModel.fromJson(p));
      }
      return DataSuccess(ps);
    } catch (e) {
      print(e);
    }
    return DataSuccess([]);
  }
}
