import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String product_name;
  DateTime expiry_date;
  DateTime added_date;
  double quantity;
  String unit;
  Stock(this.product_name, this.expiry_date, this.added_date, this.quantity,
      this.unit);
  bool AddProduct() {
    db.collection("Products").doc().set({
      "Product_name": product_name,
      "Quantity": quantity,
      "unit": unit,
      "Add_date": Timestamp.fromDate(added_date),
      "exp_date": Timestamp.fromDate(expiry_date)
    }).onError((error, stackTrace) => print("error : $error"));
    return true;
  }

  bool edit2(String doc_id, double quantity) {
    double new_quantity = this.quantity - quantity;
    bool val = true;
    db.collection("Products").doc(doc_id).set({
      "Product_name": product_name,
      "Quantity": new_quantity,
      "Add_date": Timestamp.fromDate(added_date),
      "exp_date": Timestamp.fromDate(expiry_date) , 
      "unit" : unit , 
    }).onError((error, stackTrace) {
      print("error : $error");
      val = false;
    });
    return val;
  }

  bool edit(String doc_id) {
    bool val = true;
    db.collection("Products").doc(doc_id).set({
      "Product_name": product_name,
      "Quantity": quantity,
      "Add_date": Timestamp.fromDate(added_date),
      "exp_date": Timestamp.fromDate(expiry_date)
    }).onError((error, stackTrace) {
      print("error : $error");
      val = false;
    });
    return val;
  }

  static delete_product(String doc_id) {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Products").doc(doc_id).delete();
  }
}
