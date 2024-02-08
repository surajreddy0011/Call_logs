// import 'package:flutter/foundation.dart';
import 'package:contacts_app/controllers/crud_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
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
                      keyboardType: TextInputType.number,
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
                        CRUDService().addNewContacts(_nameController.text,
                            _phoneController.text, _emailController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Create',
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
