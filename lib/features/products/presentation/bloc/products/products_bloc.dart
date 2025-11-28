import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/features/products/domain/repository/product_repository.dart';
import 'package:practical_test/features/products/presentation/bloc/products/products_event.dart';
import 'package:practical_test/features/products/presentation/bloc/products/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;

  ProductsBloc(this._productRepository) : super(InitialProductState()) {
    on<GetProducts>(_onGetProducts);
  }

  FutureOr<void> _onGetProducts(
    GetProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(LoadingProductsState());
    final state = await _productRepository.getProducts(event.page);
    if (state is DataSuccess) {
      emit(DoneProducts(products: state.data));
    }
  }
}
