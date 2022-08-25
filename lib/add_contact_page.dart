import 'package:flutter/material.dart';
import 'package:my_contact/contacts.dart';
import 'package:my_contact/database_helper.dart';

class AddContactPage extends StatefulWidget {
   const AddContactPage({Key? key, this.contact}) : super(key: key);

  final Contact? contact;
  @override
  State<AddContactPage> createState() => _AddContactPageState();
}


class _AddContactPageState extends State<AddContactPage> {
  /// for TextField
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _contactController.text = widget.contact!.contact;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contacts"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(_nameController, 'Name'),
              const SizedBox(height: 30),
              _buildTextField(_contactController, 'Contact'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (widget.contact != null) {
                    await DBHelper.updateContacts(
                      Contact(
                        id: widget.contact!.id,
                        name: _nameController.text,
                        contact: _contactController.text,

                      ),

                    );
                  }else{
                    await DBHelper.createContacts(
                      Contact(
                        name: _nameController.text,
                        contact: _contactController.text,
                      ),
                    );
                  }


                  Navigator.of(context).pop(true);
                },
                child: const Text('Add to Contact List'),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
