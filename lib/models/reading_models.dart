class ReadingWord {
  const ReadingWord({
    required this.word,
    required this.meaning,
    required this.partOfSpeech,
    required this.example,
    required this.passage,
    this.synonym,
  });

  final String word;
  final String meaning;
  final String partOfSpeech;
  final String example;
  final String passage;
  final String? synonym;
}

class ReadingQuestion {
  const ReadingQuestion({
    required this.prompt,
    required this.options,
    required this.answer,
    required this.explanation,
  });

  final String prompt;
  final List<String> options;
  final String answer;
  final String explanation;
}

class ReadingPassage {
  const ReadingPassage({
    required this.title,
    required this.level,
    required this.minutes,
    required this.text,
    required this.words,
    required this.questions,
  });

  final String title;
  final String level;
  final int minutes;
  final String text;
  final List<ReadingWord> words;
  final List<ReadingQuestion> questions;
}
