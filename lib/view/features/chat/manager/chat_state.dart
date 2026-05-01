abstract class ChatState {}

class ChatInitial extends ChatState {}

class GetMessagesLoadingState extends ChatState {}
class GetMessagesSuccessState extends ChatState {}
class GetMessagesErrorState extends ChatState {
  final String error;
  GetMessagesErrorState(this.error);
}

class SendMessageLoadingState extends ChatState {}
class SendMessageSuccessState extends ChatState {}
class SendMessageErrorState extends ChatState {
  final String error;
  SendMessageErrorState(this.error);
}

class ReceiveMessageState extends ChatState {}
