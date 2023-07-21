import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Family.dart';
 
final productProvider = StateNotifierProvider<ProductNotifier, List<String>>(
  (ref) => ProductNotifier(),
);


class ProductNotifier extends StateNotifier<List<String>> {
  ProductNotifier() : super([]);

  void addProduct(String product) {
    state = [...state, product];
  }

  void removeProduct(int index) {
    state = List.from(state)..removeAt(index);
  }
}