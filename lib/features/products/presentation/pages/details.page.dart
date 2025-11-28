import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:practical_test/core/utils/messages.dart';
import 'package:practical_test/features/products/domain/entities/product.entity.dart';
import 'package:practical_test/features/shared/bloc/geolocation_cubit.dart';

class DetailsProductPage extends StatelessWidget {
  ProductEntity? product;

  DetailsProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)!.settings.arguments as ProductEntity;
    if (product == null) Navigator.pop(context);
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: SafeArea(
        child: Column(
          children: [
            _buildMap(),
            _buildDetails(context),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _btBuy(context),
                child: Text("Comprar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMap() {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        width: double.infinity,
        height: 200,
        child: BlocBuilder<GeolocationCubit, GeolocationState>(
          builder: (context, state) {
            if (state is GeolocationDone) {
              return ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      state.position?.latitude ?? 0.0,
                      state.position?.longitude ?? 0.0,
                    ),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.practical.test',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            state.position?.latitude ?? 0.0,
                            state.position?.longitude ?? 0.0,
                          ),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.stars_rounded,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }

  _buildDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: product!.id,
            child: Image.network(
              product!.image,
              width: 150,
              height: 200,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: 150,
                  height: 200,
                  child: Center(child: CupertinoActivityIndicator()),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product!.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  product!.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _btBuy(BuildContext context) async {
    final ok = await showYesOrNoDialog(
      context,
      'Comprar Producto',
      'Está seguro que desea comprar el producto seleccionado?',
    );
    if (ok) {
      showToastMessage(
        context,
        'La compra se realizo de manera exitosa',
        icon: Icon(Icons.check_circle_outline_outlined, color: Colors.black),
        color: Colors.lightGreen,
      );
    }
  }
}
