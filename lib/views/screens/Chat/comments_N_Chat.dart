import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/Components/message_bubble_widget.dart';
import 'package:tiktok_tutorial/Constants/collections.dart';
import 'package:tiktok_tutorial/Constants/constants.dart';
import 'package:tiktok_tutorial/Services/notificationHandler.dart';
import 'package:tiktok_tutorial/models/user.dart';
import 'package:tiktok_tutorial/utilities/custom_toast.dart';
import 'package:tiktok_tutorial/utilities/show_loading.dart';
// import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';

class CommentsNChat extends StatefulWidget {
  // final String? postId;
  // final String? postOwnerId;
  final String? chatId;
  final String? heroMsg;
  // final bool? isParent;
  final String? chatNotificationToken;
//  final String userName;
  CommentsNChat({
    // this.postId,
    // this.postMediaUrl,
    // this.postOwnerId,
    required this.chatId,
    // required this.isParent,
    this.heroMsg,
    // @required this.isPostComment,
    required this.chatNotificationToken, required bool isPostComment,
    // @required this.isProductComment
  });
  @override
  CommentsNChatState createState() => CommentsNChatState();
}

TextEditingController _commentNMessagesController = TextEditingController();

class CommentsNChatState extends State<CommentsNChat> {
  // final String? postId;
  // final String? postOwnerId;
  // final bool? isComment;
//  final String userName;
  // CommentsNChatState({
  // required this.postId,
  // required this.postOwnerId,
  // required this.isComment,

  // });
  List<AppUserModel> allAdmins = [];
  String? chatHeadId;
  List<CommentsNMessages> commentsListGlobal = [];

  getAdmins() async {
    QuerySnapshot snapshots =
        await userRef.where('isAdmin', isEqualTo: true).get();
    snapshots.docs.forEach((e) {
      allAdmins.add(AppUserModel.fromDocument(e));
    });
  }

  @override
  initState() {
    super.initState();
    if (mounted) {
      setState(() {
        chatHeadId =
            currentUser!.isAdmin != null && currentUser!.isAdmin == true
                ? widget.chatId
                : currentUser!.uid;
      });
    }
    getAdmins();
  }

  buildChat() {
    print(widget.chatId);
    return StreamBuilder<QuerySnapshot>(
      stream:
          // currentUser!.isAdmin!
          // ? chatRoomRef
          //     .doc(currentUser!.isAdmin != null && currentUser!.isAdmin == true
          //         ? widget.chatId
          //         : currentUser!.id)
          //     .collection("chats")
          //     .snapshots()
          // :
          chatRoomRef
              .doc(currentUser!.isAdmin != null && currentUser!.isAdmin == true
                  ? widget.chatId
                  : currentUser!.uid)
              .collection("chats")
              .orderBy("timestamp", descending: false)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingIndicator();
        }

        List<CommentsNMessages> chatMessages = [];
        snapshot.data!.docs.forEach((DocumentSnapshot doc) {
          chatMessages.add(CommentsNMessages.fromDocument(doc));
        });
        print(chatMessages);
        return ListView(
          children: chatMessages,
        );
      },
    );
  }

  addChatMessage() {
    String commentId = const Uuid().v1();
    String date = DateTime.now().toString();
    DateTime dateparse = DateTime.parse(date);
    String formattedDate =
        '${dateparse.day}-${dateparse.month}-${dateparse.year}';
    if (_commentNMessagesController.text.trim().length > 1) {
      chatRoomRef
          .doc(currentUser!.isAdmin != null && currentUser!.isAdmin == true
              ? widget.chatId
              : currentUser!.uid)
          .collection("chats")
          .doc(commentId)
          .set({
        "userName": currentUser!.name,
        "userId": currentUser!.uid,
        "androidNotificationToken": currentUser!.androidNotificationToken,
        "comment": _commentNMessagesController.text,
        "timestamp": DateTime.now(),
        // 'formattedTime':
        // "avatarUrl": currentUser!.imageUrl,
        "commentId": commentId,
      });
      currentUser!.isAdmin
          ? null
          : chatListRef
              .doc(currentUser!.isAdmin? widget.chatId : currentUser!.uid)
              .set({
              "userName": currentUser!.name,
              "userId": currentUser!.uid,
              "comment": _commentNMessagesController.text,
              "timestamp": DateTime.now(),
              "androidNotificationToken": widget.chatNotificationToken ??
                  currentUser!.androidNotificationToken,
            });
      // sendNotificationToAdmin(
      //     type: "adminChats", title: "Admin Chats", isAdminChat: true);
      // if (isAdmin) {
      //   activityFeedRef.doc(widget.chatId).collection('feedItems').add({
      //     "type": "adminChats",
      //     "commentData": _commentNMessagesController.text,
      //     "userName": currentUser.userName,
      //     "userId": currentUser.id,
      //     "userProfileImg": currentUser.photoUrl,
      //     "postId": widget.chatId,
      //     "mediaUrl": postMediaUrl,
      //     "timestamp": timestamp,
      //   });
      sendAndRetrieveMessage(
          token: widget.chatNotificationToken!,
          message: _commentNMessagesController.text,
          title: "Admin Chats",
          context: context);
      // }

    } else {
      CustomToast.successToast(
          message: "Message field shouldn't be left Empty");
    }
    _commentNMessagesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Message",
          // style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: buildChat(),
            ),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: _commentNMessagesController,
                decoration: const InputDecoration(
                    hintText: "Write a message...",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              trailing: IconButton(
                onPressed: addChatMessage,
                icon: const Icon(
                  Icons.send,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(
            //   height: 50,
            // ),
          ],
        ),
      ),
    );
  }
}

class CommentsNMessages extends StatefulWidget {
  final String? userName;
  final String? userId;
  final String? avatarUrl;
  final String? comment;
  final Timestamp? timestamp;
  final String? commentId;
  final String? androidNotificationToken;
  CommentsNMessages({
    this.userName,
    this.userId,
    this.avatarUrl,
    this.comment,
    this.timestamp,
    this.commentId,
    this.androidNotificationToken,
  });
  factory CommentsNMessages.fromDocument(doc) {
    return CommentsNMessages(
      // avatarUrl: doc['avatarUrl'],
      comment: doc.data()['comment'],
      timestamp: doc.data()['timestamp'],
      userId: doc.data()['userId'],
      userName: doc.data()['userName'],
      commentId: doc.data()["commentId"],
      androidNotificationToken: doc["androidNotificationToken"],
    );
  }

  @override
  _CommentsNMessagesState createState() => _CommentsNMessagesState();
}

class _CommentsNMessagesState extends State<CommentsNMessages> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12, right: 12, left: 12),
      child: buildMessageBubble(context),
    );
  }

  buildMessageBubble(BuildContext context) {
    bool isMe = currentUser!.uid == widget.userId;
    return MessageBubble(
      isMe: isMe,
      isDelivered: false,
      text: widget.comment,
      time:
          '${widget.timestamp!.toDate().hour}:${widget.timestamp!.toDate().minute}',
    );
    //  Padding(
    //   padding: const EdgeInsets.only(left: 14.0, right: 14.0),
    //   child: Container(
    //     width: MediaQuery.of(context).size.width * 0.5,
    //     decoration: BoxDecoration(
    //       color: isMe ? Colors.orange : Colors.brown,
    //       borderRadius: isMe
    //           ? BorderRadius.only(
    //               bottomLeft: Radius.circular(20),
    //               bottomRight: Radius.circular(20),
    //               topLeft: Radius.circular(20),
    //             )
    //           : BorderRadius.only(
    //               bottomLeft: Radius.circular(20),
    //               bottomRight: Radius.circular(20),
    //               topRight: Radius.circular(20),
    //             ),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               widget.avatarUrl != null && widget.avatarUrl != ''
    //                   ? CircleAvatar(
    //                       backgroundImage:
    //                           CachedNetworkImageProvider(widget.avatarUrl!),
    //                     )
    //                   : CircleAvatar(backgroundImage: AssetImage(logo)),
    //               SizedBox(
    //                 width: 8,
    //               ),
    //               Expanded(
    //                 child: Column(
    //                   // crossAxisAlignment: CrossAxisAlignment.start,
    //                   // mainAxisAlignment: MainAxisAlignment.start,
    //                   // mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: [
    //                         Text("${widget.userName} : ",
    //                             style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 14.0,
    //                                 color: Colors.white)),
    //                         Flexible(
    //                           child: Text(
    //                             "${widget.comment}",
    //                             style: TextStyle(
    //                                 fontSize: 14.0, color: Colors.white),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     // Text(
    //                     //   timeago.format(widget.timestamp!.toDate()),
    //                     //   style: TextStyle(color: Colors.black54, fontSize: 12),
    //                     // ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
