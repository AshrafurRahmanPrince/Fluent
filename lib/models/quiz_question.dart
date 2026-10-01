enum IELTSQuestionCategory {
  vocabulary,
  grammar,
  collocations,
  contextualReading,
  sentenceCompletion,
}

extension IELTSQuestionCategoryLabel on IELTSQuestionCategory {
  String get label => switch (this) {
        IELTSQuestionCategory.vocabulary => 'Vocabulary',
        IELTSQuestionCategory.grammar => 'Grammar',
        IELTSQuestionCategory.collocations => 'Collocations',
        IELTSQuestionCategory.contextualReading => 'Contextual Reading',
        IELTSQuestionCategory.sentenceCompletion => 'Sentence Completion',
      };
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.category,
    required this.prompt,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  })  : assert(options.length >= 2),
        assert(correctAnswerIndex >= 0),
        assert(correctAnswerIndex < options.length),
        assert(explanation != '');

  final String id;
  final IELTSQuestionCategory category;
  final String prompt;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
}
