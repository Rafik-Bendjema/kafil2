import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/Services/Chips_module.dart';


class ProductList extends ConsumerWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromARGB(76, 155, 39, 176),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Chip(
            label: Text(products[index]),
            backgroundColor: Colors.white,
            deleteIcon: Icon(Icons.close),
            onDeleted: () {
              ref.read(productProvider.notifier).removeProduct(index);
            },
          );
        },
      ),
    );
  }
}
