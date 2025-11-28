import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_test/features/products/domain/entities/product.entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/products/details', arguments: product);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            children: [
              Hero(
                tag: product.id,
                child: Image.network(
                  product.image,
                  height: 200,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) => SizedBox(
                    height: 200,
                    child: Center(
                      child: loadingProgress != null
                          ? CupertinoActivityIndicator()
                          : child,
                    ),
                  ),
                ),
              ),
              Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
