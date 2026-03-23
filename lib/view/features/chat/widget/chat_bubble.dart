import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class ChatBubble extends StatelessWidget {
  final String? message;
  final String time;
  final bool isMe;
  final String? imagePath;

  const ChatBubble({
    super.key,
    this.message,
    required this.time,
    required this.isMe,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            padding: EdgeInsets.all(imagePath != null && message == null ? 4 : 10),
            decoration: BoxDecoration(
              color: isMe ? ColorsManager.purble : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isMe ? 18 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 18),
              ),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imagePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: kIsWeb
                        ? Image.network(
                            imagePath!,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                          ),
                  ),
                if (imagePath != null && message != null)
                  const SizedBox(height: 8),
                if (message != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: imagePath != null ? 6 : 4),
                    child: Text(
                      message!,
                      style: TextStyle(
                        fontSize: 14,
                        color: isMe ? Colors.white : ColorsManager.black,
                        height: 1.4,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              color: ColorsManager.lightGray,
            ),
          ),
        ],
      ),
    );
  }
}
