import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';

const readingFeatures = <LearningFeature>[
  LearningFeature(
    title: 'Vocabulary Builder',
    description: 'Learn new words from reading passages',
    icon: Icons.bookmarks_rounded,
  ),
  LearningFeature(
    title: 'Reading Comprehension',
    description: 'Read a passage and answer questions',
    icon: Icons.quiz_rounded,
  ),
  LearningFeature(
    title: 'Skimming Practice',
    description: 'Quickly understand the main idea of a passage',
    icon: Icons.speed_rounded,
  ),
  LearningFeature(
    title: 'Scanning Practice',
    description: 'Find specific information from a passage',
    icon: Icons.search_rounded,
  ),
  LearningFeature(
    title: 'Grammar in Reading',
    description: 'Understand grammar through real passages',
    icon: Icons.format_shapes_rounded,
  ),
  LearningFeature(
    title: 'Daily Reading',
    description: 'Practice a short reading lesson every day',
    icon: Icons.auto_stories_rounded,
  ),
];

const readingLessons = <Lesson>[
  Lesson(
      title: 'Daily Life',
      level: 'Beginner',
      duration: 12,
      completed: false,
      summary: 'Everyday scenes and common vocabulary.'),
  Lesson(
      title: 'Travel',
      level: 'Beginner',
      duration: 15,
      completed: false,
      summary: 'Useful travel phrases and destination reading.'),
  Lesson(
      title: 'Education',
      level: 'Intermediate',
      duration: 18,
      completed: false,
      summary: 'Campus life and learning contexts.'),
  Lesson(
      title: 'Technology',
      level: 'Intermediate',
      duration: 17,
      completed: false,
      summary: 'Read about devices, software, and updates.'),
  Lesson(
      title: 'Environment',
      level: 'Intermediate',
      duration: 20,
      completed: false,
      summary: 'Text about nature and sustainability.'),
  Lesson(
      title: 'Communication',
      level: 'Advanced',
      duration: 22,
      completed: false,
      summary: 'Improving clarity and message comprehension.'),
];

const writingFeatures = <LearningFeature>[
  LearningFeature(
    title: 'Sentence Building',
    description: 'Arrange words to create correct sentences',
    icon: Icons.format_list_bulleted_rounded,
  ),
  LearningFeature(
    title: 'Grammar Practice',
    description: 'Improve tense, articles, and agreement',
    icon: Icons.rule_rounded,
  ),
  LearningFeature(
    title: 'Vocabulary for Writing',
    description: 'Use useful words and phrases in context',
    icon: Icons.translate_rounded,
  ),
  LearningFeature(
    title: 'Paragraph Writing',
    description: 'Write clear paragraphs on different topics',
    icon: Icons.notes_rounded,
  ),
  LearningFeature(
    title: 'Email Writing',
    description: 'Write formal and informal emails',
    icon: Icons.mail_rounded,
  ),
  LearningFeature(
    title: 'Story Writing',
    description: 'Create short stories from given topics',
    icon: Icons.auto_stories_rounded,
  ),
  LearningFeature(
    title: 'Writing Correction',
    description: 'Identify and fix grammar mistakes',
    icon: Icons.edit_rounded,
  ),
];

const writingLessons = <Lesson>[
  Lesson(
      title: 'Sentence Basics',
      level: 'Beginner',
      duration: 10,
      completed: true,
      summary: 'Learn core sentence patterns and structure.'),
  Lesson(
      title: 'Paragraph Writing',
      level: 'Beginner',
      duration: 14,
      completed: true,
      summary: 'Organize main ideas and supporting points.'),
  Lesson(
      title: 'Descriptive Writing',
      level: 'Intermediate',
      duration: 16,
      completed: false,
      summary: 'Use details and sensory words.'),
  Lesson(
      title: 'Email Writing',
      level: 'Intermediate',
      duration: 18,
      completed: false,
      summary: 'Compose clear messages for real situations.'),
  Lesson(
      title: 'Opinion Writing',
      level: 'Intermediate',
      duration: 20,
      completed: false,
      summary: 'Support ideas with reasons and examples.'),
  Lesson(
      title: 'Story Writing',
      level: 'Advanced',
      duration: 22,
      completed: false,
      summary: 'Create engaging narratives from prompts.'),
];

const speakingFeatures = <LearningFeature>[
  LearningFeature(
    title: 'Pronunciation Practice',
    description: 'Improve sound accuracy and fluency',
    icon: Icons.mic_rounded,
  ),
  LearningFeature(
    title: 'Repeat After Me',
    description: 'Listen, repeat, and build confidence',
    icon: Icons.record_voice_over_rounded,
  ),
  LearningFeature(
    title: 'Daily Conversation',
    description: 'Practice real-life speaking situations',
    icon: Icons.chat_rounded,
  ),
  LearningFeature(
    title: 'Speaking Topics',
    description: 'Talk about chosen topics with confidence',
    icon: Icons.lightbulb_rounded,
  ),
  LearningFeature(
    title: 'Question & Answer',
    description: 'Answer common questions naturally',
    icon: Icons.question_answer_rounded,
  ),
  LearningFeature(
    title: 'Role Play',
    description: 'Act out everyday scenarios',
    icon: Icons.people_alt_rounded,
  ),
  LearningFeature(
    title: 'Common Phrases',
    description: 'Learn useful everyday English phrases',
    icon: Icons.auto_fix_high_rounded,
  ),
];

const speakingLessons = <Lesson>[
  Lesson(
      title: 'Introducing Yourself',
      level: 'Beginner',
      duration: 12,
      completed: true,
      summary: 'Share your name, work, and interests.'),
  Lesson(
      title: 'Talking About Family',
      level: 'Beginner',
      duration: 14,
      completed: true,
      summary: 'Describe family members and relationships.'),
  Lesson(
      title: 'Daily Routine',
      level: 'Beginner',
      duration: 15,
      completed: false,
      summary: 'Talk about your habits and schedule.'),
  Lesson(
      title: 'Shopping Conversation',
      level: 'Intermediate',
      duration: 16,
      completed: false,
      summary: 'Ask for prices and product information.'),
  Lesson(
      title: 'Travel Conversation',
      level: 'Intermediate',
      duration: 18,
      completed: false,
      summary: 'Practice booking, directions, and check-in.'),
  Lesson(
      title: 'Job/Interview Conversation',
      level: 'Advanced',
      duration: 24,
      completed: false,
      summary: 'Answer interview questions with confidence.'),
];

const listeningFeatures = <LearningFeature>[
  LearningFeature(
    title: 'Listening Practice',
    description: 'Listen, understand, and answer',
    icon: Icons.hearing_rounded,
  ),
  LearningFeature(
    title: 'Dictation',
    description: 'Type what you hear accurately',
    icon: Icons.keyboard_voice_rounded,
  ),
  LearningFeature(
    title: 'Listen & Choose',
    description: 'Hear audio and select the correct answer',
    icon: Icons.touch_app_rounded,
  ),
  LearningFeature(
    title: 'Vocabulary Listening',
    description: 'Match spoken words with their meaning',
    icon: Icons.library_music_rounded,
  ),
  LearningFeature(
    title: 'Conversation Listening',
    description: 'Follow realistic discussions',
    icon: Icons.forum_rounded,
  ),
  LearningFeature(
    title: 'Slow Listening',
    description: 'Adjust playback speed for clearer comprehension',
    icon: Icons.slow_motion_video_rounded,
  ),
  LearningFeature(
    title: 'Listening Comprehension',
    description: 'Answer MCQs based on audio',
    icon: Icons.headphones_rounded,
  ),
];

const listeningLessons = <Lesson>[
  Lesson(
      title: 'Everyday English',
      level: 'Beginner',
      duration: 11,
      completed: true,
      summary: 'Common words and phrases used in daily life.'),
  Lesson(
      title: 'At School',
      level: 'Beginner',
      duration: 13,
      completed: true,
      summary: 'Hear classroom expressions and routine tasks.'),
  Lesson(
      title: 'At the Restaurant',
      level: 'Intermediate',
      duration: 15,
      completed: false,
      summary: 'Understand food and service conversations.'),
  Lesson(
      title: 'Travel',
      level: 'Intermediate',
      duration: 16,
      completed: false,
      summary: 'Listen for travel instructions and announcements.'),
  Lesson(
      title: 'Phone Conversation',
      level: 'Intermediate',
      duration: 17,
      completed: false,
      summary: 'Catch key information during calls.'),
  Lesson(
      title: 'News & Information',
      level: 'Advanced',
      duration: 20,
      completed: false,
      summary: 'Follow main points in spoken information.'),
];

const moduleProgressValues = <String, ModuleProgress>{
  'Reading': ModuleProgress(title: 'Reading Progress', completed: 8, total: 12),
  'Writing': ModuleProgress(title: 'Writing Progress', completed: 4, total: 8),
  'Speaking':
      ModuleProgress(title: 'Speaking Progress', completed: 5, total: 10),
  'Listening':
      ModuleProgress(title: 'Listening Progress', completed: 6, total: 9),
};
