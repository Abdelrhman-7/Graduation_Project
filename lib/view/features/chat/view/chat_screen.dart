import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/view/features/chat/manager/chat_cubit.dart';
import 'package:graduation_project/view/features/chat/manager/chat_state.dart';
import 'package:graduation_project/view/features/chat/widget/chat_bubble.dart';
import 'package:graduation_project/view/features/chat/widget/chat_day_divider.dart';
import 'package:graduation_project/view/features/chat/widget/chat_input_bar.dart';
import 'package:graduation_project/view/features/chat/view/call_screen.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  void _showAttachmentOptions(BuildContext context, ChatCubit cubit) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
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
                  Navigator.pop(bottomSheetContext);
                  _pickMedia(ImageSource.gallery, isVideo: false, cubit: cubit);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.videocam,
                  color: ColorsManager.purble,
                ),
                title: const Text('Video Gallery'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _pickMedia(ImageSource.gallery, isVideo: true, cubit: cubit);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: ColorsManager.purble,
                ),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _pickMedia(ImageSource.camera, isVideo: false, cubit: cubit);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickMedia(ImageSource source, {required bool isVideo, required ChatCubit cubit}) async {
    final ImagePicker picker = ImagePicker();
    XFile? file;
    try {
      if (isVideo) {
        file = await picker.pickVideo(source: source);
      } else {
        file = await picker.pickImage(source: source);
      }
      if (file != null) {
         cubit.sendMessage(receiverId: 'doctor_1', imagePath: file.path);
      }
    } catch (e) {
      debugPrint('Error picking media: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getMessages(receiverId: 'doctor_1'),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is SendMessageSuccessState) {
            _controller.clear();
          }
        },
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            backgroundColor: const Color(0xFFF5F7FF),
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: state is GetMessagesLoadingState && cubit.messages.isEmpty
                      ? const Center(child: CircularProgressIndicator(color: ColorsManager.purble))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          itemCount: cubit.messages.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final msg = cubit.messages[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Day divider
                                if (msg.day != null) ...[
                                  ChatDayDivider(label: msg.day!),
                                  const SizedBox(height: 12),
                                ],
                                ChatBubble(
                                  message: msg.message,
                                  time: msg.time ?? 'Now',
                                  isMe: msg.isMe,
                                  imagePath: msg.imagePath,
                                ),
                              ],
                            );
                          },
                        ),
                ),
                ChatInputBar(
                  controller: _controller,
                  onSend: () {
                     cubit.sendMessage(
                       receiverId: 'doctor_1',
                       text: _controller.text,
                     );
                  },
                  onAttachTap: () => _showAttachmentOptions(context, cubit),
                ),
              ],
            ),
          );
        },
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
