abstract class ProductsEvent {}

class GetProducts extends ProductsEvent {
  final int page;
  GetProducts({required this.page});
}
