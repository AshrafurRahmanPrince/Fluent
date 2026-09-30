import 'package:fluento/models/speaking_models.dart';

const pronunciationWords = <PronunciationWord>[
  PronunciationWord('Hello', '/həˈloʊ/', 'A friendly greeting.',
      'Hello, it is nice to meet you.', 'Beginner'),
  PronunciationWord('Water', '/ˈwɔː.t̬ɚ/', 'A clear liquid that people drink.',
      'Could I have a glass of water?', 'Beginner'),
  PronunciationWord('Morning', '/ˈmɔːr.nɪŋ/', 'The early part of the day.',
      'I go for a walk every morning.', 'Beginner'),
  PronunciationWord('Family', '/ˈfæm.əl.i/', 'People related to one another.',
      'My family eats dinner together.', 'Beginner'),
  PronunciationWord('School', '/skuːl/', 'A place where people learn.',
      'The school library closes at five.', 'Beginner'),
  PronunciationWord(
      'Comfortable',
      '/ˈkʌm.fɚ.t̬ə.bəl/',
      'Feeling relaxed or at ease.',
      'This chair is very comfortable.',
      'Intermediate'),
  PronunciationWord('Vegetable', '/ˈvedʒ.tə.bəl/', 'A plant eaten as food.',
      'We grow fresh vegetables in the garden.', 'Intermediate'),
  PronunciationWord(
      'Interesting',
      '/ˈɪn.trə.stɪŋ/',
      'Attracting attention or curiosity.',
      'The museum has an interesting exhibit.',
      'Intermediate'),
  PronunciationWord(
      'Important',
      '/ɪmˈpɔːr.tənt/',
      'Having great value or influence.',
      'It is important to get enough sleep.',
      'Intermediate'),
  PronunciationWord(
      'Different',
      '/ˈdɪf.ɚ.ənt/',
      'Not the same as something else.',
      'We have different opinions about the film.',
      'Intermediate'),
  PronunciationWord(
      'Entrepreneur',
      '/ˌɑːn.trə.prəˈnɝː/',
      'A person who starts a business.',
      'The entrepreneur opened a local bakery.',
      'Advanced'),
  PronunciationWord(
      'Opportunity',
      '/ˌɑː.pɚˈtuː.nə.t̬i/',
      'A suitable chance to do something.',
      'The internship was a great opportunity.',
      'Advanced'),
  PronunciationWord(
      'Communication',
      '/kəˌmjuː.nəˈkeɪ.ʃən/',
      'The exchange of information or ideas.',
      'Clear communication helps teams work well.',
      'Advanced'),
  PronunciationWord(
      'Environment',
      '/ɪnˈvaɪ.rən.mənt/',
      'The natural world or surroundings.',
      'We can all help protect the environment.',
      'Advanced'),
  PronunciationWord(
      'Pronunciation',
      '/prəˌnʌn.siˈeɪ.ʃən/',
      'The way a word is spoken.',
      'Listening carefully can improve pronunciation.',
      'Advanced'),
];

const repeatSentences = <RepeatSentence>[
  RepeatSentence('Good morning!', 'Beginner'),
  RepeatSentence('My name is John.', 'Beginner'),
  RepeatSentence('I like reading books.', 'Beginner'),
  RepeatSentence('Where are you from?', 'Beginner'),
  RepeatSentence('Nice to meet you.', 'Beginner'),
  RepeatSentence('I usually go to university by bus.', 'Intermediate'),
  RepeatSentence('I have been learning English for two years.', 'Intermediate'),
  RepeatSentence('Could you please explain that again?', 'Intermediate'),
  RepeatSentence('I am planning to visit another country.', 'Intermediate'),
  RepeatSentence('I would like to improve my speaking skills.', 'Intermediate'),
  RepeatSentence(
      'If I had more time, I would practice English every day.', 'Advanced'),
  RepeatSentence(
      'Although the task was difficult, I managed to complete it.', 'Advanced'),
  RepeatSentence('I believe effective communication is essential for success.',
      'Advanced'),
  RepeatSentence(
      'Learning a language requires patience and consistent practice.',
      'Advanced'),
  RepeatSentence(
      'I would appreciate it if you could give me some feedback.', 'Advanced'),
];

const conversationScenarios = <ConversationScenario>[
  ConversationScenario(
      title: 'At a restaurant',
      turns: [
        DialogueTurn('Waiter', 'Good evening. Are you ready to order?'),
        DialogueTurn('You', 'Yes. I would like a chicken sandwich, please.'),
        DialogueTurn('Waiter', 'Would you like anything to drink?'),
        DialogueTurn('You', 'A glass of orange juice, please.')
      ],
      prompt: 'The waiter asks, “Would you like anything else?”',
      responses: [
        'No, that is all. Thank you.',
        'I went there yesterday.',
        'My name is Sara.'
      ],
      correctResponse: 'No, that is all. Thank you.'),
  ConversationScenario(
      title: 'At a university',
      turns: [
        DialogueTurn('Classmate', 'Are you in Professor Lee’s biology class?'),
        DialogueTurn('You', 'Yes. I am studying environmental science.'),
        DialogueTurn('Classmate', 'Where is your next lecture?'),
        DialogueTurn('You', 'It is in the science building, room 204.')
      ],
      prompt: 'Your classmate asks, “Would you like to study together later?”',
      responses: [
        'Sure. How about the library at three?',
        'I would like a receipt.',
        'The train leaves at noon.'
      ],
      correctResponse: 'Sure. How about the library at three?'),
  ConversationScenario(
      title: 'Meeting a new friend',
      turns: [
        DialogueTurn('Maya', 'Hello, I am Maya. Is this your first week here?'),
        DialogueTurn('You', 'Yes, I just moved to the city.'),
        DialogueTurn('Maya', 'What do you enjoy doing in your free time?'),
        DialogueTurn('You', 'I enjoy cycling and trying new cafés.')
      ],
      prompt: 'Maya says, “It was lovely talking with you.”',
      responses: [
        'Likewise. I hope we meet again.',
        'I need a larger size.',
        'Turn left at the bridge.'
      ],
      correctResponse: 'Likewise. I hope we meet again.'),
  ConversationScenario(
      title: 'At a shopping mall',
      turns: [
        DialogueTurn('Assistant', 'Can I help you find anything?'),
        DialogueTurn('You', 'I am looking for a blue jacket.'),
        DialogueTurn('Assistant', 'What size do you usually wear?'),
        DialogueTurn('You', 'Medium. May I try this one on?')
      ],
      prompt: 'The assistant says, “The fitting rooms are over there.”',
      responses: [
        'Thank you. I will try it on.',
        'I have a connecting flight.',
        'Could you repeat your name?'
      ],
      correctResponse: 'Thank you. I will try it on.'),
  ConversationScenario(
      title: 'Asking for directions',
      turns: [
        DialogueTurn('You', 'Excuse me, how do I get to the museum?'),
        DialogueTurn('Local', 'Walk straight for two blocks.'),
        DialogueTurn('You', 'Should I turn at the traffic lights?'),
        DialogueTurn('Local', 'Yes. It is beside the park.')
      ],
      prompt: 'You want to check the distance. What do you ask?',
      responses: [
        'Is it within walking distance?',
        'Would you like another coffee?',
        'When does your lecture begin?'
      ],
      correctResponse: 'Is it within walking distance?'),
  ConversationScenario(
      title: 'At an airport',
      turns: [
        DialogueTurn('Agent', 'May I see your passport and ticket?'),
        DialogueTurn('You', 'Of course. Here they are.'),
        DialogueTurn('Agent', 'Are you checking any bags?'),
        DialogueTurn('You', 'Yes, just one suitcase.')
      ],
      prompt: 'The agent says, “Your gate is B12.”',
      responses: [
        'Thank you. When does boarding begin?',
        'I would like the blue one.',
        'My appointment is Tuesday.'
      ],
      correctResponse: 'Thank you. When does boarding begin?'),
  ConversationScenario(
      title: 'Talking on the phone',
      turns: [
        DialogueTurn('Receptionist', 'Greenwood Clinic. How may I help?'),
        DialogueTurn('You', 'I am calling about my appointment.'),
        DialogueTurn('Receptionist', 'Could you tell me your name?'),
        DialogueTurn('You', 'It is Amina Rahman.')
      ],
      prompt: 'The receptionist cannot hear you clearly.',
      responses: [
        'Could you hear me now?',
        'I would like a table for two.',
        'The station is across the street.'
      ],
      correctResponse: 'Could you hear me now?'),
  ConversationScenario(
      title: 'Ordering coffee',
      turns: [
        DialogueTurn('Barista', 'What can I get for you today?'),
        DialogueTurn('You', 'A small latte, please.'),
        DialogueTurn('Barista', 'Would you like it hot or iced?'),
        DialogueTurn('You', 'Hot, please, with oat milk.')
      ],
      prompt: 'The barista asks, “Anything else?”',
      responses: [
        'No, that will be all. Thank you.',
        'I am studying engineering.',
        'Go past the post office.'
      ],
      correctResponse: 'No, that will be all. Thank you.'),
  ConversationScenario(
      title: 'Talking with a teacher',
      turns: [
        DialogueTurn('Teacher', 'How is your research project going?'),
        DialogueTurn(
            'You', 'I finished the outline and started the first section.'),
        DialogueTurn('Teacher', 'Do you have questions about your sources?'),
        DialogueTurn('You', 'Could you recommend a reliable journal?')
      ],
      prompt: 'Your teacher offers to review your draft.',
      responses: [
        'That would be very helpful. Thank you.',
        'I would like to pay by card.',
        'My room is on the third floor.'
      ],
      correctResponse: 'That would be very helpful. Thank you.'),
  ConversationScenario(
      title: 'Making an appointment',
      turns: [
        DialogueTurn('Receptionist', 'What day would you prefer?'),
        DialogueTurn('You', 'Do you have anything available on Thursday?'),
        DialogueTurn('Receptionist', 'We have an opening at 10:30 a.m.'),
        DialogueTurn('You', 'That time works well for me.')
      ],
      prompt: 'The receptionist asks you to confirm your phone number.',
      responses: [
        'It is 555 0184. Thank you.',
        'I would like a window seat.',
        'The soup was delicious.'
      ],
      correctResponse: 'It is 555 0184. Thank you.'),
];

const speakingTopics = <SpeakingTopic>[
  SpeakingTopic('My Family', 'Beginner', [
    'relative',
    'supportive',
    'tradition'
  ], [
    'There are ... people in my family.',
    'We enjoy ... together.'
  ], [
    'Who do you live with?',
    'What do you enjoy doing together?',
    'Which family tradition matters to you?'
  ]),
  SpeakingTopic('My University', 'Beginner', [
    'campus',
    'lecture',
    'classmate'
  ], [
    'I study ... at ...',
    'My favorite place on campus is ...'
  ], [
    'What are you studying?',
    'What is your campus like?',
    'Which class do you enjoy most?'
  ]),
  SpeakingTopic('My Best Friend', 'Beginner', [
    'thoughtful',
    'honest',
    'encourage'
  ], [
    'My best friend is ...',
    'I appreciate this person because ...'
  ], [
    'How did you meet?',
    'What qualities do you admire?',
    'What do you like doing together?'
  ]),
  SpeakingTopic(
      'My Favorite Food',
      'Beginner',
      ['ingredient', 'flavor', 'recipe'],
      ['My favorite dish is ...', 'It tastes ... and is made with ...'],
      ['What is the dish?', 'Who prepares it?', 'When do you like to eat it?']),
  SpeakingTopic('My Daily Routine', 'Beginner', [
    'usually',
    'schedule',
    'relax'
  ], [
    'On a typical day, I ...',
    'After I finish ..., I ...'
  ], [
    'What time do you wake up?',
    'What do you do in the afternoon?',
    'How do you relax in the evening?'
  ]),
  SpeakingTopic('My Hobby', 'Beginner', [
    'practice',
    'creative',
    'improve'
  ], [
    'In my free time, I enjoy ...',
    'I started because ...'
  ], [
    'How often do you do it?',
    'What do you need for it?',
    'What have you learned?'
  ]),
  SpeakingTopic('My Favorite Movie', 'Beginner', [
    'character',
    'storyline',
    'entertaining'
  ], [
    'A movie I enjoy is ...',
    'The story is about ...'
  ], [
    'Who is your favorite character?',
    'What makes the story memorable?',
    'Would you recommend it?'
  ]),
  SpeakingTopic('My Future Career', 'Intermediate', [
    'qualification',
    'industry',
    'long-term goal'
  ], [
    'I am interested in a career in ...',
    'My long-term goal is ...'
  ], [
    'What career would you like?',
    'Which skills will you need?',
    'What steps can you take now?'
  ]),
  SpeakingTopic('Technology in Daily Life', 'Intermediate', [
    'device',
    'convenient',
    'screen time'
  ], [
    'Technology helps me ...',
    'One drawback is ...'
  ], [
    'Which device do you use most?',
    'How does it save time?',
    'When is it useful to take a break?'
  ]),
  SpeakingTopic('Social Media', 'Intermediate', [
    'connect',
    'platform',
    'privacy'
  ], [
    'Social media makes it easier to ...',
    'People should be careful about ...'
  ], [
    'Which platform do you use?',
    'How does it connect people?',
    'Which privacy habits are important?'
  ]),
  SpeakingTopic('Traveling', 'Intermediate', [
    'destination',
    'local customs',
    'itinerary'
  ], [
    'A place I would like to visit is ...',
    'When I travel, I prefer ...'
  ], [
    'Where would you like to go?',
    'What would you see there?',
    'How can travelers respect local customs?'
  ]),
  SpeakingTopic('Online Education', 'Intermediate', [
    'flexible',
    'independent',
    'participate'
  ], [
    'Online classes are useful because ...',
    'Students learn best when ...'
  ], [
    'What is one advantage?',
    'What can make it challenging?',
    'How can students stay engaged?'
  ]),
  SpeakingTopic('Healthy Lifestyle', 'Intermediate', [
    'balanced',
    'well-being',
    'habit'
  ], [
    'A healthy habit I have is ...',
    'I would like to improve my ...'
  ], [
    'What does a balanced day include?',
    'How does exercise affect your mood?',
    'Which habit is easiest to maintain?'
  ]),
  SpeakingTopic('Learning Languages', 'Intermediate', [
    'fluency',
    'consistent',
    'feedback'
  ], [
    'I am learning ... because ...',
    'Useful practice for me is ...'
  ], [
    'What motivates you?',
    'Which skill is most challenging?',
    'How can you practice outside class?'
  ]),
  SpeakingTopic('Artificial Intelligence', 'Advanced', [
    'algorithm',
    'automate',
    'responsible use'
  ], [
    'AI can be useful when ...',
    'A concern worth considering is ...'
  ], [
    'Where do you encounter AI?',
    'Which tasks need human judgment?',
    'How can organizations use AI responsibly?'
  ]),
  SpeakingTopic('The Future of Education', 'Advanced', [
    'curriculum',
    'accessible',
    'lifelong learning'
  ], [
    'Education may change by ...',
    'Schools should prepare learners to ...'
  ], [
    'Which skills will students need?',
    'How could technology improve access?',
    'What should a modern curriculum prioritize?'
  ]),
  SpeakingTopic('Technology and Society', 'Advanced', [
    'innovation',
    'inequality',
    'accountability'
  ], [
    'Technology influences society by ...',
    'Benefits are greatest when ...'
  ], [
    'How has technology changed relationships?',
    'Who may be excluded from innovations?',
    'How should companies be accountable?'
  ]),
  SpeakingTopic('Climate Change', 'Advanced', [
    'emissions',
    'adaptation',
    'renewable energy'
  ], [
    'One effect of climate change is ...',
    'Communities can respond by ...'
  ], [
    'Which local effects have you noticed?',
    'How can governments reduce emissions?',
    'How can communities adapt?'
  ]),
  SpeakingTopic('Entrepreneurship', 'Advanced', [
    'business model',
    'investment',
    'resilience'
  ], [
    'A successful business solves ...',
    'An entrepreneur needs to be ...'
  ], [
    'What problem would you like to solve?',
    'How could you test your idea?',
    'What risks should a founder prepare for?'
  ]),
  SpeakingTopic('The Future of Work', 'Advanced', [
    'remote work',
    'automation',
    'adaptability'
  ], [
    'Workplaces are changing because ...',
    'Workers can prepare by ...'
  ], [
    'Which jobs may change most?',
    'What makes remote teamwork effective?',
    'How can workers keep skills current?'
  ]),
];

const speakingQuestions = <SpeakingQuestion>[
  SpeakingQuestion(
      'What is your name?',
      'Beginner',
      ['first name', 'prefer', 'introduce'],
      'My name is Lina, but my friends usually call me Lee.'),
  SpeakingQuestion(
      'Where are you from?',
      'Beginner',
      ['hometown', 'country', 'grow up'],
      'I am from Chattogram, a coastal city in Bangladesh.'),
  SpeakingQuestion(
      'What do you study?',
      'Beginner',
      ['major', 'course', 'student'],
      'I study computer science and am especially interested in design.'),
  SpeakingQuestion(
      'What is your favorite food?',
      'Beginner',
      ['dish', 'spicy', 'ingredient'],
      'My favorite food is vegetable biryani because it is full of flavor.'),
  SpeakingQuestion(
      'What do you do in your free time?',
      'Beginner',
      ['usually', 'enjoy', 'free time'],
      'I usually read or take a walk with a friend.'),
  SpeakingQuestion(
      'Who do you admire in your family?',
      'Beginner',
      ['admire', 'patient', 'teach'],
      'I admire my older sister because she is patient and encouraging.'),
  SpeakingQuestion(
      'What kind of music do you enjoy?',
      'Beginner',
      ['listen to', 'rhythm', 'relax'],
      'I enjoy acoustic music because it helps me relax while I study.'),
  SpeakingQuestion(
      'What is a place you like in your town?',
      'Beginner',
      ['quiet', 'nearby', 'visit'],
      'I like the public park near my home because it is quiet in the morning.'),
  SpeakingQuestion(
      'What time do you usually start your day?',
      'Beginner',
      ['wake up', 'routine', 'early'],
      'I wake up at seven and have breakfast before class.'),
  SpeakingQuestion(
      'Which season do you prefer?',
      'Beginner',
      ['weather', 'prefer', 'comfortable'],
      'I prefer winter because the weather is cool and comfortable.'),
  SpeakingQuestion(
      'Why are you learning English?',
      'Intermediate',
      ['communicate', 'career', 'confident'],
      'I am learning English to communicate confidently with people from different countries.'),
  SpeakingQuestion(
      'What did you do last weekend?',
      'Intermediate',
      ['visited', 'spent time', 'relaxing'],
      'I visited my cousins and spent Sunday afternoon reading at home.'),
  SpeakingQuestion(
      'What is your biggest goal this year?',
      'Intermediate',
      ['achieve', 'consistent', 'goal'],
      'My biggest goal is to finish my course by studying consistently.'),
  SpeakingQuestion(
      'Where would you like to travel?',
      'Intermediate',
      ['destination', 'culture', 'explore'],
      'I would like to visit Japan to explore its cities and culture.'),
  SpeakingQuestion(
      'What kind of career do you want?',
      'Intermediate',
      ['field', 'strength', 'develop'],
      'I would like a career in software design where I can solve practical problems.'),
  SpeakingQuestion(
      'How do you manage a busy schedule?',
      'Intermediate',
      ['prioritize', 'calendar', 'break'],
      'I prioritize urgent tasks, plan them in a calendar, and schedule breaks.'),
  SpeakingQuestion(
      'What skill would you like to improve?',
      'Intermediate',
      ['feedback', 'practice', 'progress'],
      'I would like to improve public speaking by practicing and asking for feedback.'),
  SpeakingQuestion(
      'What makes a good teacher?',
      'Intermediate',
      ['patient', 'explain', 'encourage'],
      'A good teacher explains ideas clearly and encourages questions.'),
  SpeakingQuestion(
      'How do you stay healthy?',
      'Intermediate',
      ['balanced', 'exercise', 'regularly'],
      'I try to eat balanced meals and exercise regularly.'),
  SpeakingQuestion(
      'What is something new you learned recently?',
      'Intermediate',
      ['recently', 'discover', 'useful'],
      'I recently learned to make a simple budget, which has been useful.'),
  SpeakingQuestion(
      'What are the advantages of artificial intelligence?',
      'Advanced',
      ['efficiency', 'analyze', 'human judgment'],
      'AI can analyze information quickly, although important decisions still need human judgment.'),
  SpeakingQuestion(
      'How can technology improve education?',
      'Advanced',
      ['accessible', 'personalized', 'reliable'],
      'Technology can make lessons more accessible and let learners work at their own pace.'),
  SpeakingQuestion(
      'What makes a good leader?',
      'Advanced',
      ['accountable', 'listen', 'direction'],
      'A good leader listens carefully, gives clear direction, and takes responsibility.'),
  SpeakingQuestion(
      'How can people become better communicators?',
      'Advanced',
      ['clarify', 'perspective', 'feedback'],
      'People can listen actively, clarify ideas, and welcome constructive feedback.'),
  SpeakingQuestion(
      'What are the biggest challenges young people face today?',
      'Advanced',
      ['pressure', 'opportunity', 'well-being'],
      'Many young people face pressure to succeed while protecting their well-being.'),
  SpeakingQuestion(
      'Should cities invest more in public transportation?',
      'Advanced',
      ['commute', 'emissions', 'investment'],
      'Reliable public transportation can ease commutes and reduce traffic emissions.'),
  SpeakingQuestion(
      'How can communities encourage lifelong learning?',
      'Advanced',
      ['workshop', 'affordable', 'curiosity'],
      'Communities can offer affordable workshops and accessible libraries.'),
  SpeakingQuestion(
      'What responsibilities come with sharing information online?',
      'Advanced',
      ['verify', 'source', 'privacy'],
      'People should verify sources before sharing information and respect privacy.'),
  SpeakingQuestion(
      'How should workplaces support employee well-being?',
      'Advanced',
      ['reasonable', 'flexible', 'supportive'],
      'Workplaces can set reasonable expectations and offer flexibility and support.'),
  SpeakingQuestion(
      'Can tourism benefit local communities?',
      'Advanced',
      ['local business', 'preserve', 'impact'],
      'Tourism can support local businesses when visitors respect culture and nature.'),
];

const commonPhrases = <CommonPhrase>[
  CommonPhrase(
      'Greetings',
      'Good morning. How are you?',
      'A polite greeting used earlier in the day.',
      'When greeting someone in the morning.', [
    DialogueTurn('A', 'Good morning. How are you?'),
    DialogueTurn('B', 'I am well, thank you. And you?')
  ]),
  CommonPhrase(
      'Greetings',
      'It is nice to see you again.',
      'A warm greeting for someone you already know.',
      'When meeting a familiar person again.', [
    DialogueTurn('A', 'It is nice to see you again.'),
    DialogueTurn('B', 'You too. How have you been?')
  ]),
  CommonPhrase(
      'Greetings',
      'How have you been?',
      'A friendly question about someone’s recent life.',
      'When catching up with someone.', [
    DialogueTurn('A', 'How have you been?'),
    DialogueTurn('B', 'Pretty well. I started a new course.')
  ]),
  CommonPhrase(
      'Greetings',
      'I hope you are doing well.',
      'A polite expression of goodwill.',
      'At the beginning of a friendly or work message.', [
    DialogueTurn('A', 'I hope you are doing well.'),
    DialogueTurn('B', 'Thank you. I hope you are too.')
  ]),
  CommonPhrase(
      'Greetings',
      'Have a lovely day.',
      'A friendly wish for the rest of the day.',
      'When ending a short conversation.', [
    DialogueTurn('A', 'Thanks for your help.'),
    DialogueTurn('B', 'You are welcome. Have a lovely day.')
  ]),
  CommonPhrase(
      'Introductions',
      'My name is ...',
      'A simple way to tell someone your name.',
      'When introducing yourself for the first time.', [
    DialogueTurn('A', 'My name is Farah.'),
    DialogueTurn('B', 'It is a pleasure to meet you.')
  ]),
  CommonPhrase(
      'Introductions',
      'What should I call you?',
      'A polite question about a preferred name.',
      'When learning how someone likes to be addressed.', [
    DialogueTurn('A', 'What should I call you?'),
    DialogueTurn('B', 'Please call me Sam.')
  ]),
  CommonPhrase(
      'Introductions',
      'Where are you from?',
      'A question about someone’s hometown or country.',
      'When getting to know a new person.', [
    DialogueTurn('A', 'Where are you from?'),
    DialogueTurn('B', 'I grew up in Sylhet.')
  ]),
  CommonPhrase(
      'Introductions',
      'What do you do?',
      'A common question about someone’s work or studies.',
      'In a casual introduction or networking conversation.', [
    DialogueTurn('A', 'What do you do?'),
    DialogueTurn('B', 'I am studying architecture.')
  ]),
  CommonPhrase(
      'Introductions',
      'Let me introduce you to Mina.',
      'A phrase used to connect two people.',
      'When helping people meet each other.', [
    DialogueTurn('A', 'Let me introduce you to Mina.'),
    DialogueTurn('B', 'It is nice to meet you, Mina.')
  ]),
  CommonPhrase(
      'Daily Conversation',
      'What are you up to today?',
      'A casual question about someone’s plans.',
      'When chatting with a friend or classmate.', [
    DialogueTurn('A', 'What are you up to today?'),
    DialogueTurn('B', 'I am going to the library after class.')
  ]),
  CommonPhrase('Daily Conversation', 'That sounds like a good idea.',
      'A positive response to a suggestion.', 'When you agree with a plan.', [
    DialogueTurn('A', 'Shall we review together?'),
    DialogueTurn('B', 'That sounds like a good idea.')
  ]),
  CommonPhrase(
      'Daily Conversation',
      'Could you say that again?',
      'A polite request for repetition.',
      'When you did not hear or understand something.', [
    DialogueTurn('A', 'The room has changed to 214.'),
    DialogueTurn('B', 'Could you say that again?')
  ]),
  CommonPhrase(
      'Daily Conversation',
      'I see what you mean.',
      'A way to show you understand someone’s point.',
      'When responding to an explanation or opinion.', [
    DialogueTurn('A', 'The earlier bus is less crowded.'),
    DialogueTurn('B', 'I see what you mean.')
  ]),
  CommonPhrase(
      'Daily Conversation',
      'Give me a moment to think.',
      'A request for time before answering.',
      'When you need to consider a question.', [
    DialogueTurn('A', 'Which project should we choose?'),
    DialogueTurn('B', 'Give me a moment to think.')
  ]),
  CommonPhrase(
      'Asking for Help',
      'Could you help me, please?',
      'A polite way to ask someone for assistance.',
      'When you need help with a task or problem.', [
    DialogueTurn('A', 'Could you help me, please?'),
    DialogueTurn('B', 'Of course. What do you need?')
  ]),
  CommonPhrase(
      'Asking for Help',
      'Would you mind showing me how?',
      'A polite request for someone to demonstrate something.',
      'When learning how to use or do something.', [
    DialogueTurn('A', 'Would you mind showing me how?'),
    DialogueTurn('B', 'Not at all. Start by opening this menu.')
  ]),
  CommonPhrase(
      'Asking for Help',
      'I am having trouble with this form.',
      'A clear way to explain a difficulty.',
      'When you need to describe a problem.', [
    DialogueTurn('A', 'I am having trouble with this form.'),
    DialogueTurn('B', 'Let me take a look.')
  ]),
  CommonPhrase(
      'Asking for Help',
      'Could you point me in the right direction?',
      'A request for advice or guidance.',
      'When you are unsure where to go or what to do.', [
    DialogueTurn('A', 'Could you point me in the right direction?'),
    DialogueTurn('B', 'The information desk is just ahead.')
  ]),
  CommonPhrase(
      'Asking for Help',
      'Thank you for taking the time.',
      'A sincere way to thank someone for their help.',
      'After someone gives you attention or assistance.', [
    DialogueTurn('A', 'Thank you for taking the time.'),
    DialogueTurn('B', 'You are very welcome.')
  ]),
  CommonPhrase(
      'Shopping',
      'How much does this cost?',
      'A question asking for an item’s price.',
      'When you want to know how much something costs.', [
    DialogueTurn('A', 'How much does this cost?'),
    DialogueTurn('B', 'It is twenty dollars.')
  ]),
  CommonPhrase(
      'Shopping',
      'Do you have this in a different size?',
      'A request for another size of the same item.',
      'When clothing does not fit.', [
    DialogueTurn('A', 'Do you have this in a different size?'),
    DialogueTurn('B', 'I can check for a small.')
  ]),
  CommonPhrase(
      'Shopping',
      'May I try this on?',
      'A request to use a fitting room.',
      'Before trying on clothing in a shop.', [
    DialogueTurn('A', 'May I try this on?'),
    DialogueTurn('B', 'Certainly. The fitting rooms are behind you.')
  ]),
  CommonPhrase(
      'Shopping',
      'I am just looking, thank you.',
      'A polite way to decline help for now.',
      'When browsing without needing assistance.', [
    DialogueTurn('A', 'Can I help you find anything?'),
    DialogueTurn('B', 'I am just looking, thank you.')
  ]),
  CommonPhrase('Shopping', 'Could I have a receipt, please?',
      'A request for proof of purchase.', 'After paying for an item.', [
    DialogueTurn('A', 'Could I have a receipt, please?'),
    DialogueTurn('B', 'Certainly. Here you are.')
  ]),
  CommonPhrase(
      'Travel',
      'Which platform does the train leave from?',
      'A question about where to board a train.',
      'At a station before departure.', [
    DialogueTurn('A', 'Which platform does the train leave from?'),
    DialogueTurn('B', 'It leaves from platform four.')
  ]),
  CommonPhrase(
      'Travel',
      'Could you call me a taxi?',
      'A request for someone to arrange transport.',
      'At a hotel or reception desk.', [
    DialogueTurn('A', 'Could you call me a taxi?'),
    DialogueTurn('B', 'Certainly. It should arrive in ten minutes.')
  ]),
  CommonPhrase(
      'Travel',
      'Is this seat taken?',
      'A polite question about an unoccupied seat.',
      'Before sitting beside another traveler.', [
    DialogueTurn('A', 'Is this seat taken?'),
    DialogueTurn('B', 'No, please go ahead.')
  ]),
  CommonPhrase(
      'Travel',
      'I have a reservation under Rahman.',
      'A way to identify a booking by name.',
      'When checking into a hotel or confirming a booking.', [
    DialogueTurn('A', 'I have a reservation under Rahman.'),
    DialogueTurn('B', 'Welcome. May I see your identification?')
  ]),
  CommonPhrase('Travel', 'How long does the journey take?',
      'A question about travel duration.', 'When planning a route or trip.', [
    DialogueTurn('A', 'How long does the journey take?'),
    DialogueTurn('B', 'About forty minutes by bus.')
  ]),
  CommonPhrase(
      'Restaurant',
      'Could we see the menu, please?',
      'A polite request for the food and drink list.',
      'After sitting down at a restaurant.', [
    DialogueTurn('A', 'Could we see the menu, please?'),
    DialogueTurn('B', 'Of course. Here are two menus.')
  ]),
  CommonPhrase(
      'Restaurant',
      'What would you recommend?',
      'A question asking for a suggestion.',
      'When choosing food at a restaurant.', [
    DialogueTurn('A', 'What would you recommend?'),
    DialogueTurn('B', 'The grilled fish is popular.')
  ]),
  CommonPhrase(
      'Restaurant',
      'Could I have this without onions?',
      'A request to leave an ingredient out.',
      'When ordering with a preference or dietary need.', [
    DialogueTurn('A', 'Could I have this without onions?'),
    DialogueTurn('B', 'Certainly. I will let the kitchen know.')
  ]),
  CommonPhrase(
      'Restaurant',
      'Could we have the bill, please?',
      'A polite request to pay after a meal.',
      'When you are ready to leave a restaurant.', [
    DialogueTurn('A', 'Could we have the bill, please?'),
    DialogueTurn('B', 'Certainly. I will bring it over.')
  ]),
  CommonPhrase(
      'Restaurant',
      'Everything was delicious.',
      'A compliment about a meal.',
      'When thanking restaurant staff after eating.', [
    DialogueTurn('A', 'Everything was delicious.'),
    DialogueTurn('B', 'I am glad you enjoyed it.')
  ]),
  CommonPhrase(
      'University',
      'When is the assignment due?',
      'A question about a submission deadline.',
      'When checking when coursework must be submitted.', [
    DialogueTurn('A', 'When is the assignment due?'),
    DialogueTurn('B', 'Please submit it by Friday afternoon.')
  ]),
  CommonPhrase(
      'University',
      'Could I borrow your notes?',
      'A request to look at another student’s notes.',
      'When you missed information in a lecture.', [
    DialogueTurn('A', 'Could I borrow your notes?'),
    DialogueTurn('B', 'Sure. I can send you a copy tonight.')
  ]),
  CommonPhrase(
      'University',
      'I am working on a group project.',
      'A way to explain a collaborative assignment.',
      'When discussing current coursework.', [
    DialogueTurn('A', 'Why are you meeting after class?'),
    DialogueTurn('B', 'I am working on a group project.')
  ]),
  CommonPhrase(
      'University',
      'Which room is the lecture in?',
      'A question about a class location.',
      'When you need to find a lecture room.', [
    DialogueTurn('A', 'Which room is the lecture in?'),
    DialogueTurn('B', 'It is in room 108 today.')
  ]),
  CommonPhrase(
      'University',
      'I would like to ask about office hours.',
      'A polite request to meet an instructor.',
      'When arranging a discussion about coursework.', [
    DialogueTurn('A', 'I would like to ask about office hours.'),
    DialogueTurn('B', 'I am available Wednesday afternoon.')
  ]),
  CommonPhrase(
      'Telephone',
      'May I speak with Ms. Karim?',
      'A polite way to ask for someone on the phone.',
      'When calling an office or workplace.', [
    DialogueTurn('A', 'May I speak with Ms. Karim?'),
    DialogueTurn('B', 'I will see if she is available.')
  ]),
  CommonPhrase(
      'Telephone',
      'Could you hold for a moment?',
      'A request for a caller to wait briefly.',
      'When you need to pause a phone conversation.', [
    DialogueTurn('A', 'Could you hold for a moment?'),
    DialogueTurn('B', 'Of course. I can wait.')
  ]),
  CommonPhrase(
      'Telephone',
      'The line is breaking up.',
      'A way to explain that a call is unclear.',
      'When the phone connection is poor.', [
    DialogueTurn('A', 'The line is breaking up.'),
    DialogueTurn('B', 'I will call you from a quieter place.')
  ]),
  CommonPhrase(
      'Telephone',
      'Could you leave a message?',
      'A request to record information for someone.',
      'When the person being called is unavailable.', [
    DialogueTurn('A', 'Could you leave a message?'),
    DialogueTurn('B', 'Please ask her to call this afternoon.')
  ]),
  CommonPhrase(
      'Telephone',
      'I will call you back shortly.',
      'A promise to return a call soon.',
      'When you cannot talk at that moment.', [
    DialogueTurn('A', 'Can you talk now?'),
    DialogueTurn('B', 'I am in a meeting. I will call back shortly.')
  ]),
  CommonPhrase(
      'Work',
      'Could you clarify the deadline?',
      'A request to explain when work must be finished.',
      'When a work schedule is unclear.', [
    DialogueTurn('A', 'Could you clarify the deadline?'),
    DialogueTurn('B', 'Please send the draft Thursday morning.')
  ]),
  CommonPhrase(
      'Work',
      'I will follow up by email.',
      'A promise to send more information in writing.',
      'After a meeting or discussion.', [
    DialogueTurn('A', 'Can you share the updated figures?'),
    DialogueTurn('B', 'Yes, I will follow up by email.')
  ]),
  CommonPhrase(
      'Work',
      'Let us set up a meeting.',
      'A suggestion to arrange a discussion.',
      'When a topic needs dedicated conversation.', [
    DialogueTurn('A', 'We should review the new plan.'),
    DialogueTurn('B', 'Agreed. Let us set up a meeting.')
  ]),
  CommonPhrase(
      'Work',
      'I appreciate your feedback.',
      'A polite way to thank someone for comments.',
      'After receiving suggestions about your work.', [
    DialogueTurn('A', 'I appreciate your feedback.'),
    DialogueTurn('B', 'You are welcome. The revision is clearer.')
  ]),
  CommonPhrase(
      'Work',
      'Could you share the latest version?',
      'A request for the most recent file or update.',
      'When collaborating on a document or project.', [
    DialogueTurn('A', 'Could you share the latest version?'),
    DialogueTurn('B', 'I just sent it to the team.')
  ]),
  CommonPhrase(
      'Social Conversation',
      'What do you enjoy doing on weekends?',
      'A friendly question about someone’s interests.',
      'When making casual conversation.', [
    DialogueTurn('A', 'What do you enjoy doing on weekends?'),
    DialogueTurn('B', 'I like visiting the farmers’ market.')
  ]),
  CommonPhrase(
      'Social Conversation',
      'That is interesting. Tell me more.',
      'An invitation to continue a story.',
      'When you want to show interest in a conversation.', [
    DialogueTurn('A', 'I have started learning pottery.'),
    DialogueTurn('B', 'That is interesting. Tell me more.')
  ]),
  CommonPhrase(
      'Social Conversation',
      'Would you like to join us?',
      'A friendly invitation to take part in an activity.',
      'When inviting someone to join a group.', [
    DialogueTurn('A', 'Would you like to join us for lunch?'),
    DialogueTurn('B', 'That sounds lovely. Thank you.')
  ]),
  CommonPhrase(
      'Social Conversation',
      'I had a great time.',
      'A warm way to say you enjoyed an event.',
      'When saying goodbye after spending time together.', [
    DialogueTurn('A', 'I had a great time this evening.'),
    DialogueTurn('B', 'Let us do it again soon.')
  ]),
  CommonPhrase(
      'Social Conversation',
      'Let us keep in touch.',
      'A suggestion to stay in contact.',
      'When parting from someone you want to see again.', [
    DialogueTurn('A', 'Let us keep in touch.'),
    DialogueTurn('B', 'Absolutely. I will send you a message.')
  ]),
];

const speakingLessonContent = <String, SpeakingLessonContent>{
  'Introducing Yourself': SpeakingLessonContent(
    objectives: [
      'Introduce yourself in complete sentences.',
      'Share your age, country, and university naturally.',
      'Describe a hobby and one personal goal.'
    ],
    vocabulary: [
      'first name',
      'years old',
      'originally from',
      'university',
      'hobby',
      'goal'
    ],
    usefulPhrases: [
      'My name is ...',
      'I am ... years old.',
      'I am originally from ...',
      'I study ... at ...',
      'In my free time, I enjoy ...'
    ],
    conversation: [
      DialogueTurn('A', 'Could you tell me a little about yourself?'),
      DialogueTurn('B', 'My name is Nabila, and I am 20 years old.'),
      DialogueTurn('A', 'Where are you from, and what do you study?'),
      DialogueTurn('B',
          'I am from Dhaka, and I study business at North City University.'),
      DialogueTurn('A', 'What do you enjoy outside class?'),
      DialogueTurn('B',
          'I enjoy photography, and I hope to start my own business one day.')
    ],
    practicePrompt:
        'Introduce yourself in four sentences. Include your name, studies, a hobby, and a goal.',
    exerciseQuestion: 'Which introduction shares a hobby naturally?',
    exerciseOptions: [
      'In my free time, I enjoy sketching.',
      'I am name twenty.',
      'My university hobby is country.'
    ],
    correctOption: 'In my free time, I enjoy sketching.',
    finalChallenge:
        'Give a 30-second introduction to a new classmate without reading the phrases.',
  ),
  'Talking About Family': SpeakingLessonContent(
    objectives: [
      'Name family members and explain relationships.',
      'Use adjectives to describe people respectfully.',
      'Talk about a shared family activity.'
    ],
    vocabulary: [
      'older sibling',
      'cousin',
      'supportive',
      'patient',
      'close-knit',
      'gather'
    ],
    usefulPhrases: [
      'I live with ...',
      'We are a close-knit family.',
      'She is ... and ...',
      'We enjoy spending time ...',
      'I look up to ... because ...'
    ],
    conversation: [
      DialogueTurn('A', 'Do you have a large family?'),
      DialogueTurn('B',
          'My family is small. I live with my parents and younger brother.'),
      DialogueTurn('A', 'What is your brother like?'),
      DialogueTurn(
          'B', 'He is curious and funny; he is always asking questions.'),
      DialogueTurn('A', 'What do you do together?'),
      DialogueTurn('B', 'We cook dinner on Fridays and talk about our week.')
    ],
    practicePrompt:
        'Describe two family members and one activity you enjoy doing together.',
    exerciseQuestion:
        'Choose the sentence that explains a relationship clearly.',
    exerciseOptions: [
      'My cousin is my aunt’s daughter.',
      'My family is yesterday.',
      'We are enjoy together.'
    ],
    correctOption: 'My cousin is my aunt’s daughter.',
    finalChallenge:
        'Speak for 45 seconds about a family member you admire and explain why.',
  ),
  'Daily Routine': SpeakingLessonContent(
    objectives: [
      'Sequence activities using time expressions.',
      'Use the present simple to describe habits.',
      'Connect routine steps with then, after, and before.'
    ],
    vocabulary: [
      'wake up',
      'have breakfast',
      'commute',
      'attend',
      'exercise',
      'wind down'
    ],
    usefulPhrases: [
      'I usually wake up at ...',
      'Before I leave, I ...',
      'After class, I ...',
      'In the evening, I ...',
      'I go to bed around ...'
    ],
    conversation: [
      DialogueTurn('A', 'What does a normal weekday look like?'),
      DialogueTurn(
          'B', 'I wake up at six thirty and have breakfast before leaving.'),
      DialogueTurn('A', 'How do you get to university?'),
      DialogueTurn('B', 'I take the bus and arrive before my first lecture.'),
      DialogueTurn('A', 'What do you do in the evening?'),
      DialogueTurn('B', 'I study, exercise, and relax before bed.')
    ],
    practicePrompt:
        'Describe your day from waking up to sleeping. Use three time expressions.',
    exerciseQuestion:
        'Complete the sentence: “After breakfast, I ___ to work.”',
    exerciseOptions: ['go', 'going', 'goes'],
    correctOption: 'go',
    finalChallenge:
        'Explain your weekday routine using “first,” “then,” and “finally.”',
  ),
  'Shopping Conversation': SpeakingLessonContent(
    objectives: [
      'Ask about price, size, and color politely.',
      'Request to try on an item and describe its fit.',
      'Complete a purchase and choose a payment method.'
    ],
    vocabulary: [
      'price tag',
      'medium',
      'fitting room',
      'exchange',
      'cash',
      'card'
    ],
    usefulPhrases: [
      'How much is this?',
      'Do you have this in medium?',
      'May I try it on?',
      'It fits well.',
      'Can I pay by card?'
    ],
    conversation: [
      DialogueTurn('Assistant', 'Can I help you find anything?'),
      DialogueTurn('Customer', 'I am looking for a green jacket.'),
      DialogueTurn('Assistant',
          'This one is available in medium. Would you like to try it on?'),
      DialogueTurn('Customer', 'Yes, please. Where is the fitting room?'),
      DialogueTurn('Assistant',
          'It is around the corner. The jacket costs forty dollars.'),
      DialogueTurn('Customer', 'It fits well. I will pay by card.')
    ],
    practicePrompt:
        'Ask for a different size, try on an item, and explain how you will pay.',
    exerciseQuestion: 'Which is a polite way to ask for another size?',
    exerciseOptions: [
      'Do you have this in a larger size?',
      'Give me large now.',
      'You have large?'
    ],
    correctOption: 'Do you have this in a larger size?',
    finalChallenge:
        'Role-play a shop visit from asking for a product to completing payment.',
  ),
  'Travel Conversation': SpeakingLessonContent(
    objectives: [
      'Ask for directions and transportation details.',
      'Check in to a hotel and confirm a reservation.',
      'Ask useful questions at an airport or ticket desk.'
    ],
    vocabulary: [
      'departure',
      'platform',
      'reservation',
      'luggage',
      'transfer',
      'landmark'
    ],
    usefulPhrases: [
      'I have a reservation under ...',
      'Which platform does it leave from?',
      'How do I get to ...?',
      'Is breakfast included?',
      'When does boarding begin?'
    ],
    conversation: [
      DialogueTurn('Traveler', 'I have a reservation under Ahmed.'),
      DialogueTurn('Receptionist', 'Welcome. May I see your passport?'),
      DialogueTurn('Traveler', 'Certainly. Is breakfast included?'),
      DialogueTurn('Receptionist', 'Yes, it is served from seven until ten.'),
      DialogueTurn('Traveler', 'Where is the nearest station?'),
      DialogueTurn(
          'Receptionist', 'Walk two blocks and turn right at the bank.')
    ],
    practicePrompt:
        'Check into a hotel and ask for directions to the nearest station.',
    exerciseQuestion:
        'You cannot find your departure gate. What should you ask?',
    exerciseOptions: [
      'Could you tell me how to get to gate B12?',
      'Where is my hotel breakfast?',
      'Can I try a different color?'
    ],
    correctOption: 'Could you tell me how to get to gate B12?',
    finalChallenge:
        'Ask for a ticket, confirm the departure point, and find your destination.',
  ),
  'Job/Interview Conversation': SpeakingLessonContent(
    objectives: [
      'Give a concise professional self-introduction.',
      'Connect education and experience to a role.',
      'Describe strengths and career goals with examples.'
    ],
    vocabulary: [
      'qualification',
      'experience',
      'strength',
      'collaborate',
      'achievement',
      'career goal'
    ],
    usefulPhrases: [
      'I recently graduated in ...',
      'My experience includes ...',
      'One of my strengths is ...',
      'I am proud of ...',
      'I hope to develop ...'
    ],
    conversation: [
      DialogueTurn('Interviewer', 'Could you tell me about yourself?'),
      DialogueTurn('Candidate',
          'I graduated in marketing and interned with a local retailer.'),
      DialogueTurn(
          'Interviewer', 'What strength would you bring to this position?'),
      DialogueTurn('Candidate',
          'I am organized and turn customer feedback into practical ideas.'),
      DialogueTurn('Interviewer', 'What are your career goals?'),
      DialogueTurn('Candidate',
          'I hope to become a project lead and learn more about digital strategy.')
    ],
    practicePrompt:
        'Answer “Tell me about yourself” with your education, one skill, and a relevant achievement.',
    exerciseQuestion: 'Which answer supports a strength with a useful detail?',
    exerciseOptions: [
      'I am organized; I use a weekly plan to keep projects on schedule.',
      'I am best. Hire me now.',
      'I have many things and want a job.'
    ],
    correctOption:
        'I am organized; I use a weekly plan to keep projects on schedule.',
    finalChallenge:
        'Answer “Why are you interested in this role?” and connect a skill to a career goal.',
  ),
};
