import 'package:flutter/material.dart';
import 'package:heylo/common/widgets/error.dart';
import 'package:heylo/features/auth/pages/login_page.dart';
import 'package:heylo/features/auth/pages/user_information_page.dart';
import 'package:heylo/features/chat/pages/chats_home_page.dart';
import 'package:heylo/features/chat/pages/active_chat_page.dart';
import 'package:heylo/features/profile/pages/user_profile_page.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case LoginPage.routeName:
      return MaterialPageRoute(builder: (context) => const LoginPage());  

    case ChatsHomePage.routeName:
      return MaterialPageRoute(builder: (context) => const ChatsHomePage());

    case ActiveChatPage.routeName:
      return MaterialPageRoute(builder: (context) => const ActiveChatPage());

    case UserProfilePage.routeName:
      return MaterialPageRoute(builder: (context) => const UserProfilePage());

    case UserInformationPage.routeName:
      return MaterialPageRoute(builder: (context) => const UserInformationPage());

    default:
      return MaterialPageRoute(builder: (context) =>  Scaffold(
        body: ErrorPage(error: 'Route not found')
      ));
  }
}