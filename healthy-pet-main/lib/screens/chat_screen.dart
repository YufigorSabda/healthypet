import 'package:flutter/material.dart';
import 'package:healthypet/models/doctor_model.dart';
import 'package:healthypet/models/chat_message.dart';
import 'package:healthypet/screens/subscribe_screen.dart';

class ChatScreen extends StatefulWidget {
  final DoctorModel doctorModel;

  ChatScreen({required this.doctorModel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> chatMessages = [];
  int userReplies = 0;

  @override
  void initState() {
    super.initState();
    // Menambahkan pesan otomatis dari dokter saat pertama kali masuk chat
    _handleDoctorIntroduction();
  }

  void _handleDoctorIntroduction() {
    setState(() {
      chatMessages.add(ChatMessage(
        text: 'Halo, saya dokter ${widget.doctorModel.name}. Sebelum kita mulai, perkenalkan nama, alamat, dan hewan peliharaan kamu dulu ya!',
        isDoctor: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.doctorModel.name}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return _buildChatMessage(chatMessages[index]);
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatMessage(ChatMessage chatMessage) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: chatMessage.isDoctor ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        chatMessage.text,
        style: TextStyle(
          color: chatMessage.isDoctor ? Colors.white : Colors.black,
          // Contoh pemilihan font dan ukuran font
          fontFamily: 'Arial', // Ganti dengan font yang Anda inginkan
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: 'Type a message...'),
              onSubmitted: (message) {
                _handleUserReply(message);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (userReplies < 3) {
                _handleUserReply();
              } else {
                _showSubscriptionNotification(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleUserReply([String? message]) {
    setState(() {
      userReplies++;
      chatMessages.add(ChatMessage(text: message ?? 'User message $userReplies', isDoctor: false));

      if (userReplies == 1) {
        chatMessages.add(ChatMessage(text: 'Oke Nabila, Salam kenal yaa, ada perlu apa?', isDoctor: true));
      } else if (userReplies == 2) {
        chatMessages.add(ChatMessage(text: 'Oke nabila, kita atur jadwal ya', isDoctor: true));
      } else if (userReplies == 3) {
        chatMessages.add(ChatMessage(text: 'okedeh, yuk subscribe dulu sebelum lanjut!', isDoctor: true));
      }
    });
  }

  void _showSubscriptionNotification(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Woop, Kesempatan chat gratis kamu sudah habis ya'),
          content: Text('Subscribe dulu yuk untuk lanjut konsultasi! Bisa bikin janji juga!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscribeScreen()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
