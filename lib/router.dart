import 'package:flutter/material.dart';
import 'package:heylo/common/widgets/error.dart';
import 'package:heylo/features/auth/pages/login_page.dart';
import 'package:heylo/features/auth/pages/user_information_page.dart';
import 'package:heylo/features/chat/pages/chats_home_page.dart';
import 'package:heylo/features/chat/pages/active_chat_page.dart';
import 'package:heylo/features/profile/pages/user_profile_page.dart';
import 'package:heylo/features/select_contacts/pages/select_contact_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case LoginPage.routeName:
      return MaterialPageRoute(builder: (context) => const LoginPage());  

    case ChatsHomePage.routeName:
      return MaterialPageRoute(builder: (context) => const ChatsHomePage());

    case ActiveChatPage.routeName:
    final arguments = settings.arguments as Map<String, dynamic>;
    final name = arguments['name'];
    final uid = arguments['uid'];
      return MaterialPageRoute(builder: (context) => ActiveChatPage(name: name, uid: uid));

    case UserProfilePage.routeName:
      return MaterialPageRoute(builder: (context) => const UserProfilePage());

    case UserInformationPage.routeName:
      return MaterialPageRoute(builder: (context) => const UserInformationPage());

    case SelectContactScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SelectContactScreen());

    

    default:
      return MaterialPageRoute(builder: (context) =>  Scaffold(
        body: ErrorPage(error: 'Route not found')
      ));
  }
}