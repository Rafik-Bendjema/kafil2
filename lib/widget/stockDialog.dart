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
  final _product_straem =
      FirebaseFirestore.instance.collection('Products').snapshots();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _product_straem,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 48,
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          String Doc_id = document.reference.id;
                          print("this is doc id : $Doc_id");
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          DateTime add_date = data['Add_date'].toDate();
                          DateTime exp_date = data['exp_date'].toDate();
                          Stock produit = Stock(data['Product_name'], exp_date,
                              add_date, data['Quantity'], data['unit']);

                          return Card(
                            color: Colors.grey[400],
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: ListTile(
                                        title: Text(
                                            "product : ${produit.product_name}"),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                                "quanity : ${produit.quantity}  ${produit.unit}"),
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
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Form(
                                                        key: _formKey,
                                                        child: Column(
                                                          children: [
                                                            Row(children: [
                                                              Expanded(
                                                                child:
                                                                    TextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                        null) {
                                                                      return "can't be empty";
                                                                    }
                                                                    if (double.parse(
                                                                            value) >
                                                                        produit
                                                                            .quantity) {
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
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  child: Text(
                                                                      produit
                                                                          .unit)),
                                                            ]),
                                                            TextButton(
                                                                onPressed: () {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    produit.edit2(
                                                                        document
                                                                            .id,
                                                                        double.parse(
                                                                            quantityController.text));
                                                                    ref
                                                                        .read(productProvider
                                                                            .notifier)
                                                                        .addProduct(
                                                                            "${produit.product_name} ${quantityController.text} ${produit.unit}");

                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child: Text(
                                                                    "done"))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        icon: Icon(Icons.add))
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
                        .toList()
                        .cast(),
                  );
                }),
          ),
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
