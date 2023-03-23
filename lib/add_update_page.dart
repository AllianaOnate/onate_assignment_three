import 'package:Bulohaton/db_handler.dart';
import 'package:Bulohaton/home_page.dart';
import 'package:Bulohaton/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddUpdateTask extends StatefulWidget {
  final String? todoId;
  final String? todoTitle;
  final String? todoDesc;
  final String? todoDT;
  final bool? update;

  AddUpdateTask({
    this.todoId,
    this.todoTitle,
    this.todoDesc,
    this.todoDT,
    this.update,
  });

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;

  final _formKey = GlobalKey<FormState>();

  late String todoTitle;
  late String todoDesc;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  void data() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');

    var data = {
      'title': todoTitle,
      'description': todoDesc,
      'created': DateTime.now(),
    };
    ref.add(data);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.todoTitle);
    final descController = TextEditingController(text: widget.todoDesc);
    String appTitle;
    if (widget.update == true) {
      appTitle = "Update Task";
    } else {
      appTitle = "Add Task";
    }

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/update_bg.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            appTitle,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: titleController,
                          onFieldSubmitted: (String value) {
                            setState(() {
                              titleController.text = value;
                            });
                          },
                          maxLength: 100,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Note Title",
                          ),
                          onChanged: (_val) {
                            todoTitle = _val;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter some text";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 5,
                          controller: descController,
                          onFieldSubmitted: (String value) {
                            setState(() {
                              titleController.text = value;
                            });
                          },
                          maxLength: 300,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Write your notes here",
                          ),
                          onChanged: (_val) {
                            todoDesc = _val;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter some text";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              CollectionReference ref = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('notes');
                              if (widget.update == true) {
                                // dbHelper!.update(
                                //   TodoModel(
                                //     id: widget.todoId,
                                //     title: titleController.text,
                                //     desc: descController.text,
                                //     dateandtime: widget.todoDT,
                                //   ),
                                // );
                                await ref.doc(widget.todoId.toString()).update({
                                  'title': titleController.text,
                                  'desc': descController.text,
                                });
                              } else {
                                // dbHelper!.insert(
                                //   TodoModel(
                                //     title: titleController.text,
                                //     desc: descController.text,
                                //     dateandtime: DateFormat('yMd')
                                //         .add_jm()
                                //         .format(DateTime.now())
                                //         .toString(),
                                //   ),
                                // );
                                await ref.add({
                                  'title': titleController.text,
                                  'desc': descController.text,
                                  'date': DateTime.now(),
                                });
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                              titleController.clear();
                              descController.clear();
                              print("Data successfully added");
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 55,
                            width: 120,
                            decoration: BoxDecoration(
                              // boxShadow: [
                              //  BoxShadow(
                              //    color: Colors.black12,
                              //    blurRadius: 5,
                              //    spreadRadius: 1,
                              //  ),
                              //],
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            titleController.clear();
                            descController.clear();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 55,
                            width: 120,
                            decoration: BoxDecoration(
                              // boxShadow: [
                              //  BoxShadow(
                              //    color: Colors.black12,
                              //    blurRadius: 5,
                              //    spreadRadius: 1,
                              //  ),
                              //],
                            ),
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}