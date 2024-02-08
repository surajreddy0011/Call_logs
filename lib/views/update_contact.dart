// import 'package:flutter/foundation.dart';
import 'package:contacts_app/controllers/crud_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact(
      {super.key,
      required this.docID,
      required this.name,
      required this.email,
      required this.phone});
  final String docID, name, email, phone;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController.text = widget.email;
    _nameController.text = widget.name;
    _phoneController.text = widget.phone;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Contact"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter any name  " : null,
                      controller: _nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text('Name')),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text('Phone')),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) => value!.length < 8
                          ? "Password should have atleast 8 characters."
                          : null,
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text('Email')),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        CRUDService().updateContact(
                            _nameController.text,
                            _phoneController.text,
                            _emailController.text,
                            widget.docID);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: OutlinedButton(
                    onPressed: () {
                      CRUDService().deleteContact(widget.docID);
                    },
                    child: Text(
                      'delete',
                      style: TextStyle(fontSize: 18),
                    ),
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
