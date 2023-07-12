import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Services/Family.dart';

class FamilyEditor extends StatefulWidget {
  final Family? initialFamily;
  final DocumentReference? doc;

  const FamilyEditor({Key? key, this.initialFamily, this.doc})
      : super(key: key);

  @override
  _FamilyEditorState createState() => _FamilyEditorState();
}

class _FamilyEditorState extends State<FamilyEditor> {
  final _kidKey = GlobalKey<FormState>();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController fatherSickController = TextEditingController();
  TextEditingController motherSickController = TextEditingController();
  TextEditingController kidsNameController = TextEditingController();
  TextEditingController kidsAgeController = TextEditingController();
  TextEditingController kidsWorkController = TextEditingController();
  TextEditingController kidsSickController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool fatherInLife = true;
  bool motherInLife = true;
  List<Kids> kids = [];
  String _selectedloc = "";
  void check() {
    Family? init = widget.initialFamily;
    if (init != null) {
      print("it's not null");
      familyNameController = TextEditingController(text: init.family_name);
      fatherNameController = TextEditingController(text: init.father_name);
      motherNameController = TextEditingController(text: init.mother_name);
      fatherSickController = TextEditingController(text: init.father_sick);
      motherSickController = TextEditingController(text: init.mother_sick);
      _selectedloc = init.location ; 
      fatherInLife = init.fatherInLife;
      motherInLife = init.motherInLife;
      kids = init.kids;
      print("this is kids $kids");
    } else {
      print("it's null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  void addKid() {
    if (_kidKey.currentState!.validate()) {
      _kidKey.currentState!.save();
      final Kids newKid = Kids(
        name: kidsNameController.text,
        age: int.parse(kidsAgeController.text),
        work: kidsWorkController.text,
        sick: kidsSickController.text,
      );
      setState(() {
        kids.add(newKid);
      });
      kidsNameController.clear();
      kidsAgeController.clear();
      kidsWorkController.clear();
      kidsSickController.clear();
    }
  }

  void editKid(int index) {
    final Kids editedKid = Kids(
      name: kidsNameController.text,
      age: int.parse(kidsAgeController.text),
      work: kidsWorkController.text,
      sick: kidsSickController.text,
    );
    setState(() {
      kids[index] = editedKid;
    });
    kidsNameController.clear();
    kidsAgeController.clear();
    kidsWorkController.clear();
    kidsSickController.clear();
  }

  void saveFamily(bool edit) {
    print("this is kids $kids");
    final Family newFamily = Family(
      family_name: familyNameController.text,
      father_name: fatherNameController.text,
      mother_name: motherNameController.text,
      father_sick: fatherSickController.text,
      mother_sick: motherSickController.text,
      fatherInLife: fatherInLife,
      motherInLife: motherInLife,
      location: _selectedloc,
      kids: kids,
    );
    if (edit) {
      print("m editiing");
      newFamily.edit_family(widget.doc!.id.toString());
    } else {
      print("m adding");
      newFamily.add_family();
    }

    fatherNameController.clear();
    motherNameController.clear();
    fatherSickController.clear();
    motherSickController.clear();
    kidsNameController.clear();
    kidsAgeController.clear();
    kidsWorkController.clear();
    kidsSickController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Family'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: familyNameController,
                decoration: InputDecoration(labelText: 'Family name'),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(142, 104, 58, 183),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 218, 218, 218)),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Pick a location"),
                              content: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "open the map and copy the location",
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          if (!await launchUrl(Uri.parse(
                                              'https://www.google.com/maps'))) {
                                            print("error");
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text("error"),
                                                      content: Text(
                                                          "error opening the map"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("OK"))
                                                      ],
                                                    ));
                                          }
                                        },
                                        child: Text("OPEN THE Map")),
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: 'past location here'),
                                      controller: locationController,
                                    )
                                  ],
                                ),
                                width: 300,
                                height: 300,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedloc = locationController.text;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("save"))
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.map))
                  ],
                ),
              ),
              (_selectedloc != "")
                  ? Text("Location is $_selectedloc")
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Father',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: fatherNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              Row(
                children: [
                  Text('Is father alive?'),
                  Checkbox(
                    value: fatherInLife,
                    onChanged: (value) {
                      setState(() {
                        fatherInLife = value!;
                      });
                    },
                  ),
                ],
              ),
              fatherInLife
                  ? TextField(
                      controller: fatherSickController,
                      decoration: InputDecoration(labelText: 'Sickness'),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(height: 16.0),
              Text(
                'Mother',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: motherNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              Row(
                children: [
                  Text('Is mother alive?'),
                  Checkbox(
                    value: motherInLife,
                    onChanged: (value) {
                      setState(() {
                        motherInLife = value!;
                      });
                    },
                  ),
                ],
              ),
              motherInLife
                  ? TextField(
                      controller: motherSickController,
                      decoration: InputDecoration(labelText: 'Sickness'),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(height: 16.0),
              Text(
                'Kids',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: kids.length,
                itemBuilder: (context, index) {
                  final kid = kids[index];
                  return ListTile(
                    title: Text(kid.name),
                    subtitle: Row(
                      children: [
                        Text(
                            'Age: ${kid.age} Work: ${kid.work} Sickness: ${kid.sick}'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                kids.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete)),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            kidsNameController.text = kid.name;
                            kidsAgeController.text = kid.age.toString();
                            kidsWorkController.text = kid.work;
                            kidsSickController.text = kid.sick;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Edit Kid'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: kidsNameController,
                                          decoration: InputDecoration(
                                              labelText: 'Name'),
                                        ),
                                        TextField(
                                          controller: kidsAgeController,
                                          decoration:
                                              InputDecoration(labelText: 'Age'),
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextField(
                                          controller: kidsWorkController,
                                          decoration: InputDecoration(
                                              labelText: 'Work'),
                                        ),
                                        TextField(
                                          controller: kidsSickController,
                                          decoration: InputDecoration(
                                              labelText: 'Sickness'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        editKid(index);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Add a Kid',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Form(
                  key: _kidKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "field can't be null ! ";
                          }
                          return null;
                        },
                        controller: kidsNameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "field can't be null ! ";
                          }
                          return null;
                        },
                        controller: kidsAgeController,
                        decoration: InputDecoration(labelText: 'Age'),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "field can't be null ! ";
                          }
                          return null;
                        },
                        controller: kidsWorkController,
                        decoration: InputDecoration(labelText: 'Work'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "field can't be null ! ";
                          }
                          return null;
                        },
                        controller: kidsSickController,
                        decoration: InputDecoration(labelText: 'Sickness'),
                      ),
                      ElevatedButton(
                        child: Text('Add Kid'),
                        onPressed: addKid,
                      ),
                    ],
                  )),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text(widget.initialFamily == null
                    ? 'Add the Family'
                    : 'Save edits'),
                onPressed: () {
                  if (widget.initialFamily == null) {
                    saveFamily(false);
                  } else {
                    saveFamily(true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
