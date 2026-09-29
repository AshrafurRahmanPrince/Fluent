import 'package:fluento/models/reading_models.dart';

const readingLessonsByTitle = <String, ReadingPassage>{
  'Daily Life': ReadingPassage(
    title: 'Morning at the University',
    level: 'Beginner',
    minutes: 12,
    text:
        'Mina usually wakes up at seven. She prepares breakfast and packs her books before leaving home.\n\nShe attends university in the morning. After class, she eats lunch with a friend and reviews her notes.\n\nIn the evening, Mina helps her family, reads for a while, and relaxes before bed.',
    words: [
      ReadingWord(
          word: 'routine',
          meaning: 'The usual way you do things each day.',
          partOfSpeech: 'Noun',
          example: 'My morning routine starts with breakfast.',
          passage: 'Mina follows a simple routine before university.',
          synonym: 'schedule'),
      ReadingWord(
          word: 'usually',
          meaning: 'In most situations; most of the time.',
          partOfSpeech: 'Adverb',
          example: 'I usually walk to class.',
          passage: 'Mina usually wakes up at seven.',
          synonym: 'normally'),
      ReadingWord(
          word: 'prepare',
          meaning: 'To get something ready.',
          partOfSpeech: 'Verb',
          example: 'We prepare lunch together.',
          passage: 'She prepares breakfast before leaving home.',
          synonym: 'make ready'),
      ReadingWord(
          word: 'attend',
          meaning: 'To go to an event, class, or meeting.',
          partOfSpeech: 'Verb',
          example: 'They attend a computer class.',
          passage: 'She attends university in the morning.',
          synonym: 'go to'),
      ReadingWord(
          word: 'relax',
          meaning: 'To rest and feel calm.',
          partOfSpeech: 'Verb',
          example: 'I relax by reading.',
          passage: 'She relaxes before bed.',
          synonym: 'rest'),
    ],
    questions: [
      ReadingQuestion(
          prompt: 'What is the passage mainly about?',
          options: [
            'Mina’s daily routine',
            'A university exam',
            'A family holiday',
            'A cooking lesson'
          ],
          answer: 'Mina’s daily routine',
          explanation:
              'The passage describes Mina’s activities from morning until bedtime.'),
      ReadingQuestion(
          prompt: 'What does Mina do before leaving home?',
          options: [
            'She prepares breakfast and packs her books.',
            'She visits a friend.',
            'She reviews her notes.',
            'She goes to bed.'
          ],
          answer: 'She prepares breakfast and packs her books.',
          explanation:
              'The first paragraph says she prepares breakfast and packs her books.'),
      ReadingQuestion(
          prompt: 'True or false: Mina reviews her notes after class.',
          options: ['True', 'False'],
          answer: 'True',
          explanation: 'After lunch, Mina reviews her notes.'),
      ReadingQuestion(
          prompt: 'When does Mina attend university?',
          options: [
            'In the morning',
            'At midnight',
            'In the evening',
            'Only on weekends'
          ],
          answer: 'In the morning',
          explanation:
              'The passage states that she attends university in the morning.'),
    ],
  ),
  'Travel': ReadingPassage(
    title: 'A Weekend by the Sea',
    level: 'Beginner',
    minutes: 15,
    text:
        'Arif planned a weekend trip with his sister. They bought a train ticket to Cox’s Bazar, their destination.\n\nAfter the journey, they checked into a small hotel near the beach. They explored the local market and tried fresh fish.\n\nThe sea was quiet in the morning. Arif took photos, and his sister collected shells. They returned home with happy memories.',
    words: [
      ReadingWord(
          word: 'journey',
          meaning: 'A trip from one place to another.',
          partOfSpeech: 'Noun',
          example: 'Our journey by train took two hours.',
          passage: 'After the journey, they checked into a hotel.',
          synonym: 'trip'),
      ReadingWord(
          word: 'destination',
          meaning: 'The place someone is travelling to.',
          partOfSpeech: 'Noun',
          example: 'Our destination is the coast.',
          passage: 'Cox’s Bazar was their destination.',
          synonym: 'goal'),
      ReadingWord(
          word: 'ticket',
          meaning: 'A pass that lets you travel or enter a place.',
          partOfSpeech: 'Noun',
          example: 'She bought a bus ticket.',
          passage: 'They bought a train ticket.',
          synonym: 'pass'),
      ReadingWord(
          word: 'hotel',
          meaning: 'A place where travellers can stay.',
          partOfSpeech: 'Noun',
          example: 'We stayed at a small hotel.',
          passage: 'They checked into a hotel near the beach.',
          synonym: 'inn'),
      ReadingWord(
          word: 'explore',
          meaning: 'To visit or learn about a place.',
          partOfSpeech: 'Verb',
          example: 'We explored the old town.',
          passage: 'They explored the local market.',
          synonym: 'discover'),
    ],
    questions: [
      ReadingQuestion(
          prompt: 'Where did Arif and his sister travel?',
          options: [
            'Cox’s Bazar',
            'Dhaka University',
            'A mountain village',
            'A city museum'
          ],
          answer: 'Cox’s Bazar',
          explanation: 'They bought a train ticket to Cox’s Bazar.'),
      ReadingQuestion(
          prompt: 'How did they travel?',
          options: ['By train', 'By bicycle', 'By plane', 'By boat'],
          answer: 'By train',
          explanation: 'The passage says they bought a train ticket.'),
      ReadingQuestion(
          prompt: 'What did Arif’s sister collect?',
          options: ['Shells', 'Tickets', 'Books', 'Flowers'],
          answer: 'Shells',
          explanation: 'She collected shells by the sea.'),
      ReadingQuestion(
          prompt: 'What does “destination” mean here?',
          options: [
            'The place they travelled to',
            'A hotel room',
            'A type of ticket',
            'A meal'
          ],
          answer: 'The place they travelled to',
          explanation: 'Cox’s Bazar is the place they planned to visit.'),
    ],
  ),
  'Education': ReadingPassage(
    title: 'Learning at University',
    level: 'Intermediate',
    minutes: 18,
    text:
        'Education gives students knowledge and helps them develop useful skills. At university, learners attend classes, discuss ideas, and complete assignments.\n\nNadia plans her week so she has time to study and rest. For a biology project, she visits the library and uses reliable sources for her research.\n\nGood study habits do not make every task easy, but they help students understand difficult ideas and use what they learn.',
    words: [
      ReadingWord(
          word: 'education',
          meaning: 'The process of learning and teaching.',
          partOfSpeech: 'Noun',
          example: 'Education can open new opportunities.',
          passage: 'Education helps students develop useful skills.'),
      ReadingWord(
          word: 'knowledge',
          meaning: 'Information and understanding gained by learning.',
          partOfSpeech: 'Noun',
          example: 'Reading gives us knowledge.',
          passage: 'Education gives students knowledge.'),
      ReadingWord(
          word: 'assignment',
          meaning: 'A piece of work given to a student.',
          partOfSpeech: 'Noun',
          example: 'I finished my science assignment.',
          passage: 'Learners complete assignments.'),
      ReadingWord(
          word: 'research',
          meaning: 'Careful study to discover information.',
          partOfSpeech: 'Noun',
          example: 'Her research used library books.',
          passage: 'She uses reliable sources for her research.'),
      ReadingWord(
          word: 'skill',
          meaning: 'An ability learned through practice.',
          partOfSpeech: 'Noun',
          example: 'Writing is a useful skill.',
          passage: 'Students develop useful skills.'),
    ],
    questions: [
      ReadingQuestion(
          prompt: 'What is the main idea?',
          options: [
            'Good study habits help students learn.',
            'University students should avoid libraries.',
            'Assignments are never useful.',
            'Rest is not important.'
          ],
          answer: 'Good study habits help students learn.',
          explanation:
              'The passage explains how education and study habits support learning.'),
      ReadingQuestion(
          prompt: 'Why does Nadia visit the library?',
          options: [
            'To research a biology project',
            'To meet her family',
            'To attend a sports class',
            'To submit a ticket'
          ],
          answer: 'To research a biology project',
          explanation: 'She uses reliable sources for her biology project.'),
      ReadingQuestion(
          prompt: 'What does “reliable” mean in the passage?',
          options: [
            'Trustworthy',
            'Very old',
            'Difficult to find',
            'Unrelated'
          ],
          answer: 'Trustworthy',
          explanation: 'Reliable sources are sources a student can trust.'),
      ReadingQuestion(
          prompt: 'What can be inferred about Nadia?',
          options: [
            'She plans her time carefully.',
            'She never takes breaks.',
            'She dislikes learning.',
            'She avoids assignments.'
          ],
          answer: 'She plans her time carefully.',
          explanation: 'The passage says she plans time for study and rest.'),
    ],
  ),
  'Technology': ReadingPassage(
    title: 'Technology in Everyday Learning',
    level: 'Intermediate',
    minutes: 17,
    text:
        'Technology is part of everyday life. A smartphone is a digital device that helps people find information and communicate. Students can use the internet to join online classes and share notes.\n\nThese tools make learning flexible, especially for people who live far from school. However, notifications can distract learners, and not everyone has a reliable connection.\n\nTechnology works best when people choose useful tools and take breaks from screens.',
    words: [
      ReadingWord(
          word: 'technology',
          meaning: 'Tools and systems created to solve problems.',
          partOfSpeech: 'Noun',
          example: 'Technology helps us learn online.',
          passage: 'Technology is part of everyday life.'),
      ReadingWord(
          word: 'digital',
          meaning: 'Using electronic computer technology.',
          partOfSpeech: 'Adjective',
          example: 'I read a digital book.',
          passage: 'A smartphone is a digital device.'),
      ReadingWord(
          word: 'device',
          meaning: 'A tool or piece of equipment.',
          partOfSpeech: 'Noun',
          example: 'A tablet is a useful device.',
          passage: 'A smartphone is a digital device.'),
      ReadingWord(
          word: 'communication',
          meaning: 'Sharing information with others.',
          partOfSpeech: 'Noun',
          example: 'Video calls support communication.',
          passage: 'A smartphone helps people communicate.'),
      ReadingWord(
          word: 'innovation',
          meaning: 'A new idea or way of doing something.',
          partOfSpeech: 'Noun',
          example: 'Online maps were an important innovation.',
          passage: 'New technology brings innovation to learning.'),
    ],
    questions: [
      ReadingQuestion(
          prompt: 'What is the passage mainly about?',
          options: [
            'Benefits and challenges of learning technology',
            'How to repair a smartphone',
            'The history of the internet',
            'Why students should stop studying'
          ],
          answer: 'Benefits and challenges of learning technology',
          explanation:
              'The passage describes helpful uses of technology and possible problems.'),
      ReadingQuestion(
          prompt: 'How can students use the internet?',
          options: [
            'To join online classes and share notes',
            'To avoid all communication',
            'To repair every device',
            'To remove notifications'
          ],
          answer: 'To join online classes and share notes',
          explanation:
              'The first paragraph gives online classes and sharing notes as examples.'),
      ReadingQuestion(
          prompt: 'What does “flexible” mean in the passage?',
          options: [
            'Able to fit different needs or schedules',
            'Very expensive',
            'Hard to understand',
            'Without electricity'
          ],
          answer: 'Able to fit different needs or schedules',
          explanation:
              'Online learning can help people who live far from school.'),
      ReadingQuestion(
          prompt: 'What can be inferred about notifications?',
          options: [
            'They may interrupt learning.',
            'They always improve focus.',
            'They replace internet access.',
            'They are needed for every class.'
          ],
          answer: 'They may interrupt learning.',
          explanation: 'The passage says notifications can distract learners.'),
    ],
  ),
  'Environment': ReadingPassage(
    title: 'Small Actions for a Cleaner Environment',
    level: 'Intermediate',
    minutes: 20,
    text:
        'The environment includes the air, water, land, plants, and animals around us. Pollution can harm these parts of nature. Plastic waste in rivers, for example, can hurt wildlife.\n\nPeople can help by reducing waste, reusing bags, and sorting materials to recycle. Communities can also plant trees and protect local parks.\n\nConservation needs effort from individuals and governments. Small daily choices are useful when many people make them.',
    words: [
      ReadingWord(
          word: 'pollution',
          meaning: 'Harmful substances in air, water, or land.',
          partOfSpeech: 'Noun',
          example: 'Car smoke can cause air pollution.',
          passage: 'Pollution can harm parts of nature.'),
      ReadingWord(
          word: 'recycle',
          meaning: 'To process used materials so they can be used again.',
          partOfSpeech: 'Verb',
          example: 'We recycle paper at school.',
          passage: 'People can sort materials to recycle.'),
      ReadingWord(
          word: 'environment',
          meaning: 'The natural world around us.',
          partOfSpeech: 'Noun',
          example: 'We should care for the environment.',
          passage:
              'The environment includes air, water, land, plants, and animals.'),
      ReadingWord(
          word: 'waste',
          meaning: 'Things that are no longer needed and are thrown away.',
          partOfSpeech: 'Noun',
          example: 'We can reduce food waste.',
          passage: 'People can help by reducing waste.'),
      ReadingWord(
          word: 'conservation',
          meaning: 'The protection of nature and resources.',
          partOfSpeech: 'Noun',
          example: 'Forest conservation protects wildlife.',
          passage: 'Conservation needs effort from everyone.'),
    ],
    questions: [
      ReadingQuestion(
          prompt: 'What is the passage mainly about?',
          options: [
            'Ways to care for the environment',
            'How to build a house',
            'Why rivers should be avoided',
            'The history of plastic'
          ],
          answer: 'Ways to care for the environment',
          explanation:
              'The passage describes environmental problems and actions people can take.'),
      ReadingQuestion(
          prompt: 'How can plastic waste affect rivers?',
          options: [
            'It can hurt wildlife.',
            'It makes all water clean.',
            'It helps trees grow.',
            'It reduces the need to recycle.'
          ],
          answer: 'It can hurt wildlife.',
          explanation:
              'The first paragraph says plastic waste in rivers can hurt wildlife.'),
      ReadingQuestion(
          prompt: 'Which action is suggested?',
          options: [
            'Reuse bags',
            'Throw waste into rivers',
            'Cut down local trees',
            'Ignore parks'
          ],
          answer: 'Reuse bags',
          explanation:
              'The passage suggests reducing waste, reusing bags, and recycling.'),
      ReadingQuestion(
          prompt: 'Why do small choices matter?',
          options: [
            'Many people making them can help.',
            'They stop all pollution immediately.',
            'Only governments can make them.',
            'They remove the need for conservation.'
          ],
          answer: 'Many people making them can help.',
          explanation:
              'The passage says small choices are useful when many people make them.'),
    ],
  ),
  'Communication': ReadingPassage(
    title: 'Communicating Clearly',
    level: 'Advanced',
    minutes: 22,
    text:
        'Communication is more than exchanging words. Verbal communication uses spoken or written language, while non-verbal communication includes facial expressions, gestures, and tone. These signals can support a message or change how it is understood.\n\nIn a group discussion, effective communication depends on listening as well as speaking. People need to notice different viewpoints, ask clear questions, and respond with respect.\n\nDigital tools make interaction across distances easier, but a short message can sometimes hide emotion or intention. Choosing the right channel and checking that a message is understood can prevent confusion.',
    words: [
      ReadingWord(
          word: 'communicate',
          meaning: 'To share ideas, information, or feelings.',
          partOfSpeech: 'Verb',
          example: 'We communicate by speaking and writing.',
          passage: 'People communicate in more than one way.'),
      ReadingWord(
          word: 'expression',
          meaning: 'A look or action that shows a feeling or idea.',
          partOfSpeech: 'Noun',
          example: 'Her expression showed surprise.',
          passage: 'Facial expressions can support a message.'),
      ReadingWord(
          word: 'interaction',
          meaning: 'An exchange between people.',
          partOfSpeech: 'Noun',
          example: 'The class interaction was friendly.',
          passage: 'Digital tools make interaction across distances easier.'),
      ReadingWord(
          word: 'message',
          meaning: 'Information sent from one person to another.',
          partOfSpeech: 'Noun',
          example: 'Please read the message carefully.',
          passage: 'Tone can change how a message is understood.'),
      ReadingWord(
          word: 'effective',
          meaning: 'Successful in producing the result you want.',
          partOfSpeech: 'Adjective',
          example: 'A clear question is effective.',
          passage: 'Effective communication includes listening.'),
    ],
    questions: [
      ReadingQuestion(
          prompt: 'What is the central idea?',
          options: [
            'Clear communication uses words, signals, and listening.',
            'Digital messages are always easy to understand.',
            'Speaking is more important than listening.',
            'Gestures should never be used.'
          ],
          answer: 'Clear communication uses words, signals, and listening.',
          explanation:
              'The passage explains verbal and non-verbal signals, listening, and clear messages.'),
      ReadingQuestion(
          prompt: 'What is non-verbal communication?',
          options: [
            'Expressions, gestures, and tone',
            'Only written language',
            'A message sent by email',
            'A list of questions'
          ],
          answer: 'Expressions, gestures, and tone',
          explanation:
              'The first paragraph names these as non-verbal signals.'),
      ReadingQuestion(
          prompt: 'Why can a short digital message cause confusion?',
          options: [
            'It may hide emotion or intention.',
            'It always contains too many words.',
            'It cannot travel across distances.',
            'It replaces every conversation.'
          ],
          answer: 'It may hide emotion or intention.',
          explanation:
              'The final paragraph says short messages can hide emotion or intention.'),
      ReadingQuestion(
          prompt: 'What can be inferred about effective group discussions?',
          options: [
            'Participants should listen and respect different views.',
            'Only one person should speak.',
            'Questions should be avoided.',
            'Tone never matters.'
          ],
          answer: 'Participants should listen and respect different views.',
          explanation:
              'The passage recommends listening, noticing viewpoints, asking questions, and responding respectfully.'),
    ],
  ),
};

const vocabularyCategories = <String, List<ReadingWord>>{
  'Daily Life': [
    ReadingWord(
        word: 'routine',
        meaning: 'The usual way you do things each day.',
        partOfSpeech: 'Noun',
        example: 'My routine begins with breakfast.',
        passage: 'A regular routine can make mornings easier.',
        synonym: 'schedule'),
    ReadingWord(
        word: 'prepare',
        meaning: 'To get something ready.',
        partOfSpeech: 'Verb',
        example: 'I prepare my bag at night.',
        passage: 'She prepares her books before class.',
        synonym: 'make ready'),
    ReadingWord(
        word: 'relax',
        meaning: 'To rest and feel calm.',
        partOfSpeech: 'Verb',
        example: 'I relax after work.',
        passage: 'He reads to relax in the evening.',
        synonym: 'rest'),
  ],
  'Travel': [
    ReadingWord(
        word: 'journey',
        meaning: 'A trip from one place to another.',
        partOfSpeech: 'Noun',
        example: 'The journey was comfortable.',
        passage: 'Our journey to the village was exciting.',
        synonym: 'trip'),
    ReadingWord(
        word: 'destination',
        meaning: 'The place someone is travelling to.',
        partOfSpeech: 'Noun',
        example: 'The beach is our destination.',
        passage: 'They reached their destination before sunset.',
        synonym: 'goal'),
    ReadingWord(
        word: 'ticket',
        meaning: 'A pass for travel or entry.',
        partOfSpeech: 'Noun',
        example: 'Keep your train ticket safe.',
        passage: 'I bought a ticket at the station.',
        synonym: 'pass'),
  ],
  'Education': [
    ReadingWord(
        word: 'knowledge',
        meaning: 'Understanding gained by learning.',
        partOfSpeech: 'Noun',
        example: 'Books can increase our knowledge.',
        passage: 'The course gave students useful knowledge.'),
    ReadingWord(
        word: 'assignment',
        meaning: 'Work given to a student.',
        partOfSpeech: 'Noun',
        example: 'We completed the assignment together.',
        passage: 'Her assignment is due on Friday.'),
    ReadingWord(
        word: 'research',
        meaning: 'Careful study to find information.',
        partOfSpeech: 'Noun',
        example: 'He used books for his research.',
        passage: 'The students did research in the library.'),
  ],
  'Technology': [
    ReadingWord(
        word: 'digital',
        meaning: 'Using electronic computer technology.',
        partOfSpeech: 'Adjective',
        example: 'I use a digital calendar.',
        passage: 'The digital classroom has online lessons.'),
    ReadingWord(
        word: 'device',
        meaning: 'A tool or piece of equipment.',
        partOfSpeech: 'Noun',
        example: 'A phone is a useful device.',
        passage: 'The device connects to the internet.'),
    ReadingWord(
        word: 'innovation',
        meaning: 'A new idea or method.',
        partOfSpeech: 'Noun',
        example: 'The app is a useful innovation.',
        passage: 'Innovation can make learning easier.'),
  ],
  'Environment': [
    ReadingWord(
        word: 'pollution',
        meaning: 'Harmful substances in nature.',
        partOfSpeech: 'Noun',
        example: 'Pollution can harm animals.',
        passage: 'The town is working to reduce pollution.'),
    ReadingWord(
        word: 'recycle',
        meaning: 'To use materials again after processing.',
        partOfSpeech: 'Verb',
        example: 'We recycle bottles at school.',
        passage: 'Residents recycle paper and glass.'),
    ReadingWord(
        word: 'conservation',
        meaning: 'Protection of nature and resources.',
        partOfSpeech: 'Noun',
        example: 'Conservation protects forests.',
        passage: 'The park supports wildlife conservation.'),
  ],
  'Communication': [
    ReadingWord(
        word: 'message',
        meaning: 'Information sent to someone.',
        partOfSpeech: 'Noun',
        example: 'I received your message.',
        passage: 'Her message was short and clear.'),
    ReadingWord(
        word: 'expression',
        meaning: 'A look or action that shows a feeling.',
        partOfSpeech: 'Noun',
        example: 'His expression showed joy.',
        passage: 'A smile is a friendly expression.'),
    ReadingWord(
        word: 'interaction',
        meaning: 'An exchange between people.',
        partOfSpeech: 'Noun',
        example: 'The interaction was helpful.',
        passage: 'Online tools allow interaction with classmates.'),
  ],
  'Health': [
    ReadingWord(
        word: 'healthy',
        meaning: 'In good physical or mental condition.',
        partOfSpeech: 'Adjective',
        example: 'Walking is a healthy activity.',
        passage: 'A healthy breakfast gives her energy.'),
    ReadingWord(
        word: 'exercise',
        meaning: 'Activity that helps keep the body strong.',
        partOfSpeech: 'Noun',
        example: 'Exercise is good for your heart.',
        passage: 'The doctor recommended daily exercise.'),
    ReadingWord(
        word: 'balanced',
        meaning: 'Having the right mix of different things.',
        partOfSpeech: 'Adjective',
        example: 'He eats a balanced meal.',
        passage: 'A balanced diet includes different foods.'),
  ],
  'Work & Career': [
    ReadingWord(
        word: 'career',
        meaning: 'A person’s long-term work life.',
        partOfSpeech: 'Noun',
        example: 'She plans a career in science.',
        passage: 'He is building a career in design.'),
    ReadingWord(
        word: 'colleague',
        meaning: 'A person you work with.',
        partOfSpeech: 'Noun',
        example: 'My colleague helped me.',
        passage: 'A colleague shared the project notes.'),
    ReadingWord(
        word: 'experience',
        meaning: 'Knowledge gained by doing something.',
        partOfSpeech: 'Noun',
        example: 'The job gave her useful experience.',
        passage: 'Work experience helped him learn new skills.'),
  ],
};

final comprehensionPassages = <String, ReadingPassage>{
  'Beginner': readingLessonsByTitle['Daily Life']!,
  'Intermediate': readingLessonsByTitle['Technology']!,
  'Advanced': readingLessonsByTitle['Communication']!,
};

const skimmingPassage = ReadingPassage(
  title: 'Why City Parks Matter',
  level: 'Beginner',
  minutes: 5,
  text:
      'City parks give people a place to walk, play, and rest. Trees provide shade, and open spaces bring neighbours together. Parks also give birds and other small animals a place to live. Caring for a park helps make a city healthier and more welcoming.',
  words: [],
  questions: [
    ReadingQuestion(
        prompt: 'What is the passage mainly about?',
        options: [
          'Why city parks are useful',
          'How to build a house',
          'The best way to travel',
          'Different kinds of birds'
        ],
        answer: 'Why city parks are useful',
        explanation:
            'The passage gives several benefits of parks for people, wildlife, and cities.'),
  ],
);

const scanningPassage = ReadingPassage(
  title: 'Community Reading Day',
  level: 'Beginner',
  minutes: 5,
  text:
      'The City Library will hold Community Reading Day on 15 March 2026. The event begins at 10:30 a.m. in the main hall in Dhaka. Author Farah Ahmed will read a story, and visitors can join a book exchange. Admission is free. Call 555-0142 to ask for details.',
  words: [],
  questions: [
    ReadingQuestion(
        prompt: 'On what date is the event?',
        options: [
          '10 March 2026',
          '15 March 2026',
          '20 March 2026',
          '25 March 2026'
        ],
        answer: '15 March 2026',
        explanation: 'The first sentence gives the date as 15 March 2026.'),
    ReadingQuestion(
        prompt: 'Where will the event take place?',
        options: [
          'In the main hall in Dhaka',
          'At the train station',
          'In a school garden',
          'At Farah’s home'
        ],
        answer: 'In the main hall in Dhaka',
        explanation:
            'The passage says the event is in the main hall in Dhaka.'),
    ReadingQuestion(
        prompt: 'What time does it begin?',
        options: ['9:00 a.m.', '10:30 a.m.', '12:30 p.m.', '3:00 p.m.'],
        answer: '10:30 a.m.',
        explanation: 'Look for the time: the event begins at 10:30 a.m.'),
    ReadingQuestion(
        prompt: 'Who will read a story?',
        options: [
          'Farah Ahmed',
          'The librarian',
          'A school teacher',
          'A visitor'
        ],
        answer: 'Farah Ahmed',
        explanation: 'The passage names author Farah Ahmed as the reader.'),
  ],
);

const grammarPassage = ReadingPassage(
  title: 'Rina’s Week at University',
  level: 'Beginner',
  minutes: 6,
  text:
      'Rina goes to university every day. She studies computer science and enjoys reading books. Today, she is working on a project with her classmates. Yesterday, they visited the library and found an article about robots.',
  words: [],
  questions: [
    ReadingQuestion(
        prompt: 'Rina ___ to university every day.',
        options: ['go', 'goes', 'going', 'went'],
        answer: 'goes',
        explanation:
            'Rina is one person (third-person singular), so the present simple verb takes -s.'),
    ReadingQuestion(
        prompt: 'Today, she ___ on a project.',
        options: ['works', 'worked', 'is working', 'work'],
        answer: 'is working',
        explanation:
            '“Today” describes an action happening now: is + verb-ing.'),
    ReadingQuestion(
        prompt:
            'Which article completes the sentence: “They found ___ article”?',
        options: ['a', 'an', 'the', 'no article'],
        answer: 'an',
        explanation: 'Use “an” before a vowel sound, as in “article”.'),
    ReadingQuestion(
        prompt: 'When did they visit the library?',
        options: ['Yesterday', 'Every day', 'Tomorrow', 'At this moment'],
        answer: 'Yesterday',
        explanation:
            'The final sentence uses “Yesterday” and the past verb “visited”.'),
  ],
);
