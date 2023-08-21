class TextCompletionData {
  final String text;
  final num index;
  final String finishReason;

  TextCompletionData(
      {required this.text, required this.index, required this.finishReason});

  factory TextCompletionData.fromJson(Map<String, dynamic> json) {
    return TextCompletionData(
      text: json['text'],
      index: json['index'],
      finishReason: json['finish_reason'],
    );
  }
}
