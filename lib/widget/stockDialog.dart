import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Services/Chips_module.dart';
import '../Services/Stock.dart';
import 'ProductsList.dart';

class StockDialog extends ConsumerStatefulWidget {
  StockDialog({super.key});

  @override
  ConsumerState<StockDialog> createState() => _StockDialogState();
}

class _StockDialogState extends ConsumerState<StockDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductsList = ref.watch(choosedProductProvider);
    print(ProductsList.length);
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: ProductsList.length,
                  itemBuilder: (context, index) => Card(
                      color: Colors.grey[400],
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text(
                                      "product : ${ProductsList[index].s.product_name}"),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                          "quanity : ${ProductsList[index].available}  ${ProductsList[index].s.unit}"),
                                      SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: Container(
                                                height: 200,
                                                padding: EdgeInsets.all(20),
                                                child: Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    children: [
                                                      Row(children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value ==
                                                                  null) {
                                                                return "can't be empty";
                                                              }
                                                              if (double.parse(
                                                                      value) >
                                                                  ProductsList[
                                                                          index]
                                                                      .available) {
                                                                return "the selected value is bigger then the actual quatity";
                                                              }
                                                              return null;
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                quantityController,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        "quantity"),
                                                          ),
                                                        ),
                                                        FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                                ProductsList[
                                                                        index]
                                                                    .s
                                                                    .unit)),
                                                      ]),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              ref
                                                                  .read(choosedProductProvider
                                                                      .notifier)
                                                                  .refresh(
                                                                      index,
                                                                      double.parse(
                                                                          quantityController
                                                                              .text));
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                            print(ref
                                                                .read(
                                                                    choosedProductProvider)[0]
                                                                .consumed);
                                                          },
                                                          child: Text("done"))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          )
                        ],
                      )))),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"))
        ]),
      ),
    );
  }
}
