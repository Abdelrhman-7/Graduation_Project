import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/view/features/chat/widget/chat_bubble.dart';
import 'package:graduation_project/view/features/chat/widget/chat_day_divider.dart';
import 'package:graduation_project/view/features/chat/widget/chat_input_bar.dart';
import 'package:graduation_project/view/features/chat/view/call_screen.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // Sample conversation data
  final List<Map<String, dynamic>> _messages = [
    {
      'message':
          'Hello! I have reviewed your recent lab results. How are you feeling today?',
      'time': '10:02 AM',
      'isMe': false,
      'day': 'Today',
    },
    {
      'message':
          'Hi Doctor, I\'ve been feeling a bit tired lately. Is something wrong?',
      'time': '10:05 AM',
      'isMe': true,
      'day': null,
    },
    {
      'message':
          'Your hemoglobin trend is slightly elevated at 14.2 g/dL, but that\'s within normal range. The fatigue might be due to your cholesterol level.',
      'time': '10:07 AM',
      'isMe': false,
      'day': null,
    },
    {
      'message': 'Should I be worried about the cholesterol?',
      'time': '10:09 AM',
      'isMe': true,
      'day': null,
    },
    {
      'message':
          'At 210 mg/dL it\'s slightly above the recommended limit of 200 mg/dL. I\'d suggest dietary changes and a follow-up in 4 weeks.',
      'time': '10:12 AM',
      'isMe': false,
      'day': null,
    },
    {
      'message': 'Thank you Doctor! I\'ll follow your advice.',
      'time': '10:14 AM',
      'isMe': true,
      'day': null,
    },
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({
        'message': text,
        'time': 'Now',
        'isMe': true,
        'day': null,
      });
      _controller.clear();
    });

    // Simulated reply
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'message':
                'Thank you for your message. I will review this and get back to you shortly.',
            'time': 'Now',
            'isMe': false,
            'day': null,
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: ColorsManager.purble,
                ),
                title: const Text('Photo Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.gallery, isVideo: false);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.videocam,
                  color: ColorsManager.purble,
                ),
                title: const Text('Video Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.gallery, isVideo: true);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: ColorsManager.purble,
                ),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.camera, isVideo: false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickMedia(ImageSource source, {required bool isVideo}) async {
    final ImagePicker picker = ImagePicker();
    XFile? file;
    try {
      if (isVideo) {
        file = await picker.pickVideo(source: source);
      } else {
        file = await picker.pickImage(source: source);
      }
      if (file != null) {
        setState(() {
          _messages.add({
            'message': null,
            'imagePath': file!.path,
            'time': 'Now',
            'isMe': true,
            'day': null,
          });
        });
      }
    } catch (e) {
      debugPrint('Error picking media: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: _messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Day divider
                    if (msg['day'] != null) ...[
                      ChatDayDivider(label: msg['day'] as String),
                      const SizedBox(height: 12),
                    ],
                    ChatBubble(
                      message: msg['message'] as String?,
                      time: msg['time'] as String,
                      isMe: msg['isMe'] as bool,
                      imagePath: msg['imagePath'] as String?,
                    ),
                  ],
                );
              },
            ),
          ),
          ChatInputBar(
            controller: _controller,
            onSend: _sendMessage,
            onAttachTap: _showAttachmentOptions,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: ColorsManager.black,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: ColorsManager.purble.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: ColorsManager.purble,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          // Name + status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dr. Sarah Johnson',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: ColorsManager.iconGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 11,
                      color: ColorsManager.iconGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.videocam_outlined,
            color: ColorsManager.purble,
            size: 24,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CallScreen(
                  isVideoCall: true,
                  callerName: 'Dr. Sarah Johnson',
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.phone_outlined,
            color: ColorsManager.purble,
            size: 22,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CallScreen(
                  isVideoCall: false,
                  callerName: 'Dr. Sarah Johnson',
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
