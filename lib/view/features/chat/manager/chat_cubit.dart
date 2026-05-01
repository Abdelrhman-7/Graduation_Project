import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/model/message_model.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  List<MessageModel> messages = [];

  // دالة لجلب الرسايل من الـ API
  Future<void> getMessages({required String receiverId}) async {
    emit(GetMessagesLoadingState());
    try {
      // محاكاة للـ API Call لحد ما الباك إند يكون جاهز
      await Future.delayed(const Duration(milliseconds: 800));
      
      messages = [
        MessageModel(message: 'Hello! I have reviewed your recent lab results. How are you feeling today?', time: '10:02 AM', isMe: false, day: 'Today'),
        MessageModel(message: 'Hi Doctor, I\'ve been feeling a bit tired lately. Is something wrong?', time: '10:05 AM', isMe: true),
        MessageModel(message: 'Your hemoglobin trend is slightly elevated at 14.2 g/dL, but that\'s within normal range. The fatigue might be due to your cholesterol level.', time: '10:07 AM', isMe: false),
        MessageModel(message: 'Should I be worried about the cholesterol?', time: '10:09 AM', isMe: true),
        MessageModel(message: 'At 210 mg/dL it\'s slightly above the recommended limit of 200 mg/dL. I\'d suggest dietary changes and a follow-up in 4 weeks.', time: '10:12 AM', isMe: false),
        MessageModel(message: 'Thank you Doctor! I\'ll follow your advice.', time: '10:14 AM', isMe: true),
      ];
      
      emit(GetMessagesSuccessState());
    } catch (e) {
      emit(GetMessagesErrorState(e.toString()));
    }
  }

  // دالة لإرسال رسالة
  Future<void> sendMessage({required String receiverId, String? text, String? imagePath}) async {
    if ((text == null || text.trim().isEmpty) && imagePath == null) return;

    // إضافة الرسالة للـ UI فوراً عشان اليوزر ميحسش بتأخير
    final newMessage = MessageModel(
      message: text,
      imagePath: imagePath,
      time: 'Now',
      isMe: true,
    );
    messages.add(newMessage);
    emit(SendMessageLoadingState());

    try {
      // 1- بنكلم الـ API هنا بالـ (Dio) عشان نسيف الرسالة في الداتابيز
      // await DioHelper.postData(url: 'api/chat/send', data: {...});
      await Future.delayed(const Duration(milliseconds: 500)); 
      
      emit(SendMessageSuccessState());
      
      // 2- السيموليشن ده مؤقت لحد ما نربط ويب سوكيت ييجي منه رد الدكتور أوتوماتيك
      Future.delayed(const Duration(seconds: 2), () {
        messages.add(MessageModel(
          message: 'Thank you for your message. I will review this and get back to you shortly.',
          time: 'Now',
          isMe: false,
        ));
        emit(ReceiveMessageState());
      });

    } catch (e) {
      emit(SendMessageErrorState(e.toString()));
    }
  }
}
