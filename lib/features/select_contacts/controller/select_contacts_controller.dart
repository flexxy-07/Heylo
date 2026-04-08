import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact/contact.dart';
import 'package:heylo/features/select_contacts/repo/select_contact_repo.dart';
import 'package:riverpod/riverpod.dart';

final getContactsProvider = FutureProvider((ref){
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactRepository.getContacts();
});

final selectContactControllerProvider = Provider((ref){
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);

  return SelectContactsController(ref: ref, selectContactRepo: selectContactRepository );

}) ;

class SelectContactsController {
  final Ref ref;
  final SelectContactRepo selectContactRepo;
  SelectContactsController({
    required this.ref,
    required this.selectContactRepo,
  });

  void selectContact(Contact selectedContact, BuildContext context){
    selectContactRepo.selectContact(selectedContact, context);
  }
}