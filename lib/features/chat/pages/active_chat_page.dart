import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/common/widgets/loader.dart';
import 'package:heylo/features/auth/controller/auth_controller.dart';
import 'package:heylo/models/user_model.dart';
import 'package:heylo/theme/app_pallete.dart';

class ActiveChatPage extends ConsumerWidget {
  static const String routeName = '/active-chat';
  final String name;
  final String uid;

  const ActiveChatPage({Key? key, required this.name, required this.uid})
    : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: StreamBuilder<UserModel>(stream: ref.read(authControllerProvider).userDataById(uid) , builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Loader();
          }
          return Column(
              children: [
                Text(name),
                Text(snapshot.data!.isOnline ? 'Online' : 'Offline', style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),)
              ],
            );
          

        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: 4,
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0;
                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? AppPallete.primary.withOpacity(0.1)
                          : AppPallete.surfaceContainerHigh,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isMe ? 20 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 20),
                      ),
                    ),
                    child: Text(
                      isMe
                          ? 'Hey Sarah! Did you see the new design for Heylo?'
                          : 'Yes! It looks absolutely stunning. The atmospheric vibe is amazing.',
                      style: GoogleFonts.inter(
                        color: AppPallete.onSurface,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppPallete.surfaceContainerLow,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      fillColor: AppPallete.surfaceContainerLowest,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: AppPallete.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: AppPallete.onPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
