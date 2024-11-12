import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_210562/domain/entities/message.dart';

import 'package:yes_no_210562/presentation/providers/chat_provider.dart';
import 'package:yes_no_210562/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_210562/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_210562/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://pbs.twimg.com/profile_images/1851581330544558080/mCdyWAIv_400x400.jpg'),
          ),
        ),
        title: const Text('Jose🦊'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];
                       
                      return (message.fromWho == FromWho.hers)
                          ? HerMessageBubble( message: message )
                          : MyMessageBubble( message: message );
                    })),

            /// Caja de texto de mensajes
            MessageFieldBox(
              // onValue: (value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
