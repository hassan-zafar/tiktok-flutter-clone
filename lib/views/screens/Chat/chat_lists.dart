import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/Constants/collections.dart';
import 'package:tiktok_tutorial/utilities/show_loading.dart';
import 'package:tiktok_tutorial/views/screens/Chat/comments_N_Chat.dart';

class ChatLists extends StatefulWidget {
  @override
  _ChatListsState createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: const Text("All Chats"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              chatListRef.orderBy("timestamp", descending: true).snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return const LoadingIndicator();
            }
            List<CommentsNMessages> chatHeads = [];
            print(snapshots.data!.docs.length);
            snapshots.data!.docs.forEach((e) {
              print("in snapshot");
              print(e["userId"]);
              chatHeads.add(CommentsNMessages.fromDocument(e));
              print(chatHeads);
            });
            if (snapshots.data == null || chatHeads.isEmpty) {
              return const Center(
                child: Text(
                  "No Active Chat Heads!!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: chatHeads.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentsNChat(
                                  chatId: chatHeads[index].userId,
                                  chatNotificationToken:
                                      chatHeads[index].androidNotificationToken,
                                  heroMsg: chatHeads[index].comment, isPostComment: false,
                                ))),
                    child: Container(
                      child: ListTile(
                        title: Text(chatHeads[index].userName!),
                        subtitle: Text(
                          chatHeads[index].comment!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
