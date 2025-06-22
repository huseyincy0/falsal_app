import 'package:flutter/material.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  final String falType;
  const ChatScreen({Key? key, required this.falType}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_ChatMessage> messages = [];
  final TextEditingController messageController = TextEditingController();
  bool isRecording = false;
  int secondsLeft = 15 * 60; // 15 dakika
  Timer? timer;
  bool canSend = true;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        setState(() {
          canSend = false;
        });
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    final min = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final sec = (secondsLeft % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  Color get themeColor {
    switch (widget.falType) {
      case 'Kahve Falı':
        return const Color(0xFF4B2E2E);
      case 'Aşk Falı':
        return const Color(0xFFFFB6C1);
      case 'Tarot':
        return const Color(0xFF1E1A35);
      case 'İskambil':
        return const Color(0xFF8B0000);
      default:
        return Colors.deepPurple;
    }
  }

  Color get bubbleColorUser {
    switch (widget.falType) {
      case 'Kahve Falı':
        return const Color(0xFFF3E3D3);
      case 'Aşk Falı':
        return const Color(0xFFC9A0DC);
      case 'Tarot':
        return const Color(0xFFB3C7F7);
      case 'İskambil':
        return const Color(0xFFD3D3D3);
      default:
        return Colors.purple[100]!;
    }
  }

  Color get bubbleColorFortune {
    switch (widget.falType) {
      case 'Kahve Falı':
        return const Color(0xFFFFD700);
      case 'Aşk Falı':
        return const Color(0xFFFFFFFF);
      case 'Tarot':
        return const Color(0xFFFFD700);
      case 'İskambil':
        return const Color(0xFF000000);
      default:
        return Colors.purple[300]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Falcı Adı', style: TextStyle(color: bubbleColorFortune, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.star, color: bubbleColorFortune, size: 16),
                      const SizedBox(width: 4),
                      Text('4.9', style: TextStyle(color: bubbleColorFortune, fontSize: 12)),
                      const SizedBox(width: 8),
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text('Online', style: TextStyle(color: bubbleColorFortune, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(formattedTime, style: TextStyle(color: bubbleColorFortune, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: msg.isUser ? bubbleColorUser : bubbleColorFortune,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: msg.isAudio
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.mic, color: themeColor),
                              const SizedBox(width: 8),
                              Text('Sesli Mesaj', style: TextStyle(color: themeColor)),
                            ],
                          )
                        : Text(msg.text, style: TextStyle(color: themeColor, fontSize: 16)),
                  ),
                );
              },
            ),
          ),
          if (!canSend)
            Container(
              color: themeColor.withOpacity(0.95),
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Görüşme süresi doldu. Artık mesaj gönderemezsiniz.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          if (canSend)
            _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: themeColor.withOpacity(0.95),
        child: Row(
          children: [
            IconButton(
              icon: Icon(isRecording ? Icons.stop : Icons.mic, color: Colors.white),
              onPressed: () {
                setState(() {
                  isRecording = !isRecording;
                });
                if (isRecording) {
                  // Ses kaydı başlat (dummy)
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      isRecording = false;
                      messages.add(_ChatMessage(isUser: true, text: '', isAudio: true));
                    });
                  });
                }
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: messageController,
                enabled: !isRecording,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: isRecording ? 'Ses kaydediliyor...' : 'Mesaj yaz...'
                ),
                onSubmitted: (val) => _sendMessage(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: isRecording ? null : _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(_ChatMessage(isUser: true, text: text));
        messageController.clear();
      });
      // Dummy: Falcıdan otomatik cevap
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          messages.add(_ChatMessage(isUser: false, text: 'Falcıdan otomatik cevap.'));
        });
      });
    }
  }
}

class _ChatMessage {
  final bool isUser;
  final String text;
  final bool isAudio;
  _ChatMessage({required this.isUser, required this.text, this.isAudio = false});
} 