import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:heylo/common/utils/utils.dart';
import 'package:heylo/features/chat/pages/active_chat_page.dart';
import 'package:heylo/models/user_model.dart';
import 'package:riverpod/riverpod.dart';


final selectContactsRepositoryProvider = Provider((ref) => SelectContactRepo(firestore: FirebaseFirestore.instance));

class SelectContactRepo {
  final FirebaseFirestore firestore;

  SelectContactRepo({
    required this.firestore,
  });

Future<List<Contact>> getContacts() async {
  List<Contact> contacts = [];
  try {
    if(await FlutterContacts.permissions.request(PermissionType.read) == PermissionStatus.granted){
     contacts = await FlutterContacts.getAll(properties: {ContactProperty.photoThumbnail, ContactProperty.name, ContactProperty.phone});
    }
  }catch(e){
    debugPrint(e.toString());
  }
  return contacts;
}

void selectContact(Contact selectedContact, BuildContext context) async {
  try {
    var userCollection = await firestore.collection('users').get();
    bool isFound = false;
    for(var document in userCollection.docs){
      var userData = UserModel.fromMap(document.data());
      String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(" ", '');
      if(selectedPhoneNum == userData.phoneNumber){
        isFound = true;
        Navigator.pushNamed(context, ActiveChatPage.routeName, arguments: {
          'name': userData.name,
          'uid': userData.uid,
        });
      }

    }
    if(!isFound){
      showSnackBar(context: context, message: 'This number does not exist on this app');
    }


  }catch(e){
    showSnackBar(context: context, message: e.toString());
  }
}
}