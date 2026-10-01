enum IELTSReadingCategory { academic, generalTraining }

enum IELTSReadingQuestionType {
  multipleChoice,
  sentenceCompletion,
  summaryCompletion,
  trueFalseNotGiven,
}

extension IELTSReadingCategoryLabel on IELTSReadingCategory {
  String get label => switch (this) {
        IELTSReadingCategory.academic => 'Academic Reading',
        IELTSReadingCategory.generalTraining => 'General Training Reading',
      };
}

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
    required this.answer,
    required this.explanation,
    this.options = const [],
    this.type = IELTSReadingQuestionType.multipleChoice,
  });

  final String prompt;
  final List<String> options;
  final String answer;
  final String explanation;
  final IELTSReadingQuestionType type;
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

class IELTSReadingSection {
  const IELTSReadingSection({
    required this.title,
    required this.questions,
  });

  final String title;
  final List<ReadingQuestion> questions;
}

class IELTSReadingTest {
  const IELTSReadingTest({
    required this.title,
    required this.category,
    required this.passage,
    required this.sections,
  });

  final String title;
  final IELTSReadingCategory category;
  final ReadingPassage passage;
  final List<IELTSReadingSection> sections;

  List<ReadingQuestion> get questions => [
        for (final section in sections) ...section.questions,
      ];
}
