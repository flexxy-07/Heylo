import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heylo/common/widgets/error.dart';
import 'package:heylo/common/widgets/loader.dart';
import 'package:heylo/features/select_contacts/controller/select_contacts_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  static const String routeName = '/select-contacts';
  const SelectContactScreen({super.key});

  void selectContact(WidgetRef ref, Contact selectedContact, BuildContext context){
    ref.read(selectContactControllerProvider).selectContact(selectedContact, context);

  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],  
        
      ),
      body: ref.watch(getContactsProvider).when(
        data: (contactList) => ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) { 
            final contact = contactList[index];
            return InkWell(
              onTap: () => selectContact(ref, contact, context),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: Text(contact.displayName ?? '', style: const TextStyle(
                    fontSize: 18,
                    
                  ),), 
                  leading: contact.photo?.thumbnail == null 
                      ? null 
                      : CircleAvatar(
                          backgroundImage: MemoryImage(contact.photo!.thumbnail!),
                          radius: 30,
                        ),
                ),
              ),
            );
          },
        ),
        error: (err, trace) => ErrorPage(error: err.toString()), 
        loading: () => const Loader(),
      ),
    );
  }
}