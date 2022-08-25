import 'package:flutter/material.dart';
import 'package:my_contact/add_contact_page.dart';
import 'package:my_contact/contacts.dart';
import 'package:my_contact/database_helper.dart';

class DemoContact extends StatefulWidget {
  const DemoContact({Key? key}) : super(key: key);

  @override
  State<DemoContact> createState() => _DemoContactState();
}

class _DemoContactState extends State<DemoContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),

      /// add Future Builder to get contacts
      body: FutureBuilder<List<Contact>>(
          future: DBHelper.readContacts(),

          /// read contacts list here
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            /// if snapshot has no data yet
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Loading..."),
                  ],
                ),
              );
            }

            /// if snapshot return empty [], show text
            /// else show contact list
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("No Contact in List yet!"),
                  )
                : ListView(
                    children: snapshot.data!.map((contacts) {
                      return Center(
                        child: ListTile(
                          title: Text(contacts.name),
                          subtitle: Text(contacts.contact),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await DBHelper.deleteContacts(contacts.id!);
                              setState(() {});
                            },
                          ),
                          onTap: () async {
                            final refresh = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AddContactPage(
                                  contact: Contact(
                                    id: contacts.id,
                                    name: contacts.name,
                                    contact: contacts.contact,
                                  ),
                                ),
                              ),
                            );
                            if(refresh){
                              print('It is Refresh: $refresh');
                              setState(() {
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddContactPage(),
            ),
          );
          if (refresh) {
            setState(() {});
          }
        },
      ),
    );
  }
}

/// Now let's create add contacts page
