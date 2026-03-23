import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class CallScreen extends StatelessWidget {
  final bool isVideoCall;
  final String callerName;

  const CallScreen({
    super.key,
    required this.isVideoCall,
    required this.callerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Stack(
          children: [
            // If Video Call, show dummy camera view
            if (isVideoCall)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2C3E50), Color(0xFF000000)],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.person, size: 200, color: Colors.white10),
                ),
              ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top section (Caller Info)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        radius: 50,
                        // ignore: deprecated_member_use
                        backgroundColor: ColorsManager.purble.withOpacity(0.2),
                        child: const Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      CustomText(
                        text: callerName,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: isVideoCall ? 'Video calling...' : 'Calling...',
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),

                // Bottom section (Call controls)
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlBtn(
                        icon: Icons.mic_off,
                        color: Colors.white24,
                        iconColor: Colors.white,
                        onTap: () {},
                      ),
                      if (isVideoCall)
                        _buildControlBtn(
                          icon: Icons.cameraswitch,
                          color: Colors.white24,
                          iconColor: Colors.white,
                          onTap: () {},
                        ),
                      _buildControlBtn(
                        icon: Icons.call_end,
                        color: Colors.red,
                        iconColor: Colors.white,
                        size: 64,
                        iconSize: 32,
                        onTap: () => Navigator.pop(context),
                      ),
                      _buildControlBtn(
                        icon: Icons.volume_up,
                        color: Colors.white24,
                        iconColor: Colors.white,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBtn({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
    double size = 52,
    double iconSize = 24,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(icon, color: iconColor, size: iconSize),
        ),
      ),
    );
  }
}
