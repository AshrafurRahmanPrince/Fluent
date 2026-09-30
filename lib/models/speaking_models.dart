class PronunciationWord {
  const PronunciationWord(
      this.word, this.phonetic, this.meaning, this.example, this.level);
  final String word;
  final String phonetic;
  final String meaning;
  final String example;
  final String level;
}

class RepeatSentence {
  const RepeatSentence(this.sentence, this.level);
  final String sentence;
  final String level;
}

class DialogueTurn {
  const DialogueTurn(this.speaker, this.line);
  final String speaker;
  final String line;
}

class ConversationScenario {
  const ConversationScenario(
      {required this.title,
      required this.turns,
      required this.prompt,
      required this.responses,
      required this.correctResponse});
  final String title;
  final List<DialogueTurn> turns;
  final String prompt;
  final List<String> responses;
  final String correctResponse;
}

class SpeakingTopic {
  const SpeakingTopic(
      this.title, this.level, this.vocabulary, this.starters, this.questions);
  final String title;
  final String level;
  final List<String> vocabulary;
  final List<String> starters;
  final List<String> questions;
}

class SpeakingQuestion {
  const SpeakingQuestion(
      this.question, this.level, this.vocabulary, this.sampleAnswer);
  final String question;
  final String level;
  final List<String> vocabulary;
  final String sampleAnswer;
}

class CommonPhrase {
  const CommonPhrase(
      this.category, this.phrase, this.meaning, this.whenToUse, this.example);
  final String category;
  final String phrase;
  final String meaning;
  final String whenToUse;
  final List<DialogueTurn> example;
}

class SpeakingLessonContent {
  const SpeakingLessonContent(
      {required this.objectives,
      required this.vocabulary,
      required this.usefulPhrases,
      required this.conversation,
      required this.practicePrompt,
      required this.exerciseQuestion,
      required this.exerciseOptions,
      required this.correctOption,
      required this.finalChallenge});
  final List<String> objectives;
  final List<String> vocabulary;
  final List<String> usefulPhrases;
  final List<DialogueTurn> conversation;
  final String practicePrompt;
  final String exerciseQuestion;
  final List<String> exerciseOptions;
  final String correctOption;
  final String finalChallenge;
}
