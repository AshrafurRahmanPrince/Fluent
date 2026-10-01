class IELTSListeningQuestion {
  const IELTSListeningQuestion({
    required this.prompt,
    required this.answer,
    required this.explanation,
    this.acceptableAnswers = const [],
  });

  final String prompt;
  final String answer;
  final String explanation;
  final List<String> acceptableAnswers;

  List<String> get allAcceptedAnswers => [answer, ...acceptableAnswers];
}

class IELTSListeningSection {
  const IELTSListeningSection({
    required this.title,
    required this.audioScript,
    required this.questions,
  });

  final String title;
  final String audioScript;
  final List<IELTSListeningQuestion> questions;
}

class IELTSListeningTest {
  const IELTSListeningTest({
    required this.title,
    required this.sections,
  });

  final String title;
  final List<IELTSListeningSection> sections;

  List<IELTSListeningQuestion> get questions => [
        for (final section in sections) ...section.questions,
      ];
}