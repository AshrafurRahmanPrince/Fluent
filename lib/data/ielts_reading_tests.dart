import '../models/reading_models.dart';

ReadingQuestion _multipleChoice(
  String prompt,
  List<String> options,
  String answer,
  String explanation,
) => ReadingQuestion(
      prompt: prompt,
      options: options,
      answer: answer,
      explanation: explanation,
      type: IELTSReadingQuestionType.multipleChoice);

ReadingQuestion _trueFalseNotGiven(
  String prompt,
  String answer,
  String explanation,
) => ReadingQuestion(
      prompt: prompt,
      options: const ['TRUE', 'FALSE', 'NOT GIVEN'],
      answer: answer,
      explanation: explanation,
      type: IELTSReadingQuestionType.trueFalseNotGiven);

ReadingQuestion _sentenceCompletion(
  String prompt,
  String answer,
  String explanation,
) => ReadingQuestion(
      prompt: prompt,
      answer: answer,
      explanation: explanation,
      type: IELTSReadingQuestionType.sentenceCompletion);

ReadingQuestion _summaryCompletion(
  String prompt,
  String answer,
  String explanation,
) => ReadingQuestion(
      prompt: prompt,
      answer: answer,
      explanation: explanation,
      type: IELTSReadingQuestionType.summaryCompletion);

final List<IELTSReadingTest> ieltsReadingTests = [
  IELTSReadingTest(
    title: 'Academic Reading Test 1',
    category: IELTSReadingCategory.academic,
    passage: const ReadingPassage(
      title: 'How University Libraries Are Changing',
      level: 'Academic',
      minutes: 20,
      text: 'University libraries were once defined primarily by their printed collections. Today, many provide access to electronic journals, research databases and digitised archives. This change has not made physical collections obsolete. Instead, it has altered how students locate and evaluate information. A learner can search thousands of records quickly, but must still decide which sources are reliable and relevant.\n\nSome institutions have redesigned library space accordingly. Quiet reading rooms remain, while group areas support collaborative projects. Librarians increasingly teach research methods, including how to distinguish peer-reviewed studies from material published without editorial review. These services are particularly valuable to students who are unfamiliar with academic conventions.\n\nDigitisation also presents difficulties. Licensing agreements can restrict who may use a resource, and older documents may be difficult to scan accurately. Furthermore, a search engine may favour frequently cited material, making less familiar perspectives harder to find. Libraries therefore combine technology with professional guidance rather than assuming that digital access alone guarantees effective research.',
      words: [],
      questions: [],
    ),
    sections: [
      IELTSReadingSection(title: 'Questions 1-3', questions: [
        _multipleChoice(
          'What is the writer\'s main point about digital collections?',
          [
            'They have replaced the need for library staff.',
            'They have changed research practices but have not removed other library functions.',
            'They are useful only to experienced researchers.',
            'They have made printed material impossible to access.',
          ],
          'They have changed research practices but have not removed other library functions.',
          'The passage says digital access changed how information is found, while physical resources and librarian guidance remain important.',
        ),
        _trueFalseNotGiven(
          'All universities have removed their quiet reading rooms.',
          'FALSE',
          'The passage explicitly says quiet reading rooms remain in some redesigned libraries.',
        ),
        _sentenceCompletion(
          'Librarians teach students how to identify _____ studies.',
          'peer-reviewed',
          'The passage describes instruction in distinguishing peer-reviewed studies from unreviewed material.',
        ),
      ]),
      IELTSReadingSection(title: 'Questions 4-6', questions: [
        _summaryCompletion(
          'Digital searches may favour frequently cited work, so less familiar _____ can be overlooked.',
          'perspectives',
          'The final paragraph warns that search ranking can make less familiar perspectives harder to find.',
        ),
        _multipleChoice(
          'Why can digital access be restricted?',
          [
            'Licensing agreements may limit use.',
            'Students are not permitted to search databases.',
            'Librarians remove all older documents.',
            'Electronic journals cannot be stored.',
          ],
          'Licensing agreements may limit use.',
          'The passage states that licensing agreements can restrict who may use a resource.',
        ),
        _trueFalseNotGiven(
          'The passage states that digitised archives are less accurate than every printed record.',
          'NOT GIVEN',
          'It notes that older documents can be difficult to scan accurately, but makes no comparison with every printed record.',
        ),
      ]),
    ],
  ),
  IELTSReadingTest(
    title: 'Academic Reading Test 2',
    category: IELTSReadingCategory.academic,
    passage: const ReadingPassage(
      title: 'Urban Trees and City Temperatures',
      level: 'Academic',
      minutes: 20,
      text: 'Cities often remain warmer than surrounding countryside after sunset. Buildings and paved surfaces absorb solar energy during the day and release it slowly at night. This urban heat effect can increase discomfort and raise demand for air conditioning. Planting trees is frequently proposed as a remedy, although its benefits depend on where and how trees are established.\n\nA tree can shade a pavement and cool nearby air through water released from its leaves. Yet a row of trees may have little effect on a street if the canopy is too high or gaps expose the ground to direct sunlight. Species selection matters as well: trees suited to local rainfall are more likely to survive without intensive irrigation.\n\nResearchers caution against treating tree cover as a single solution. In narrow streets, dense foliage can sometimes reduce airflow, while poorly planned roots may damage underground pipes. The most effective programmes combine shade planting with reflective building materials and public cooling spaces. They also involve residents, who can identify locations where heat is most burdensome and help care for young trees.',
      words: [],
      questions: [],
    ),
    sections: [
      IELTSReadingSection(title: 'Questions 1-3', questions: [
        _multipleChoice(
          'What causes the urban heat effect described in the passage?',
          [
            'Rural areas release energy more quickly.',
            'Built surfaces store daytime solar energy and release it later.',
            'Trees prevent cities from receiving sunlight.',
            'Air conditioning heats every outdoor space.',
          ],
          'Built surfaces store daytime solar energy and release it later.',
          'The opening paragraph explains that buildings and paved surfaces absorb energy and release it slowly at night.',
        ),
        _trueFalseNotGiven(
          'Every tree species can survive in a city without irrigation.',
          'FALSE',
          'The passage says locally suitable species are more likely to survive without intensive irrigation, not every species.',
        ),
        _sentenceCompletion(
          'Water released from leaves can help cool the nearby _____.',
          'air',
          'The second paragraph says a tree cools nearby air through water released from its leaves.',
        ),
      ]),
      IELTSReadingSection(title: 'Questions 4-6', questions: [
        _summaryCompletion(
          'Tree programmes work best when combined with reflective materials and public _____ spaces.',
          'cooling',
          'The final paragraph recommends combining planting with reflective materials and public cooling spaces.',
        ),
        _multipleChoice(
          'Why might dense foliage be a problem in a narrow street?',
          [
            'It can reduce airflow.',
            'It prevents roots from growing.',
            'It increases rainfall.',
            'It makes building materials reflective.',
          ],
          'It can reduce airflow.',
          'The passage notes that dense foliage can sometimes reduce airflow in narrow streets.',
        ),
        _trueFalseNotGiven(
          'Residents were paid to water the trees in the research project.',
          'NOT GIVEN',
          'Residents are described as potential participants in care, but payment is not mentioned.',
        ),
      ]),
    ],
  ),
  IELTSReadingTest(
    title: 'Academic Reading Test 3',
    category: IELTSReadingCategory.academic,
    passage: const ReadingPassage(
      title: 'Restoring a Coastal Wetland',
      level: 'Academic',
      minutes: 20,
      text: 'Coastal wetlands support fish, birds and plant communities while also reducing the force of waves. In many regions, however, wetlands have been drained or separated from the sea by barriers built for agriculture and development. Restoration projects aim to recover ecological processes, not simply to create a landscape that looks natural.\n\nOne approach is to reopen channels that allow tides to move through marshes. The returning water carries sediment and nutrients, but the timing and volume must be monitored. If water enters too quickly, young plants may be submerged; if too little enters, the soil can remain unsuitable for wetland species. Engineers and ecologists therefore work together to adjust channel depth and placement.\n\nSuccess is measured over several years. Teams record plant diversity, water salinity and the return of indicator species. A single season of visible growth is insufficient evidence of recovery. Local communities are consulted because restored channels can affect fishing access and nearby farmland. This longer process may appear less dramatic than construction, but it allows managers to adapt the project as conditions change.',
      words: [],
      questions: [],
    ),
    sections: [
      IELTSReadingSection(title: 'Questions 1-3', questions: [
        _multipleChoice(
          'What is the central aim of wetland restoration?',
          [
            'To recreate ecological processes.',
            'To build a permanent barrier against tides.',
            'To increase farmland by draining marshes.',
            'To make every wetland look identical.',
          ],
          'To recreate ecological processes.',
          'The first paragraph distinguishes recovering ecological processes from simply making a natural-looking landscape.',
        ),
        _trueFalseNotGiven(
          'The channels are opened to allow tidal movement through marshes.',
          'TRUE',
          'This is directly stated as one restoration approach.',
        ),
        _sentenceCompletion(
          'Returning tidal water can carry sediment and _____.',
          'nutrients',
          'The second paragraph states that water carries sediment and nutrients.',
        ),
      ]),
      IELTSReadingSection(title: 'Questions 4-6', questions: [
        _summaryCompletion(
          'Researchers monitor salinity, plant diversity and indicator species over several _____.',
          'years',
          'The third paragraph says success is measured over several years using these indicators.',
        ),
        _multipleChoice(
          'Why is one season of visible plant growth insufficient?',
          [
            'It does not provide enough evidence of long-term recovery.',
            'Plants cannot grow near the sea.',
            'Salinity can only be measured in winter.',
            'Local communities do not recognise plants.',
          ],
          'It does not provide enough evidence of long-term recovery.',
          'The passage explicitly says a single season of growth is insufficient evidence of recovery.',
        ),
        _trueFalseNotGiven(
          'All local fishers supported the channel restoration.',
          'NOT GIVEN',
          'The passage says communities are consulted about access, but gives no account of their unanimous position.',
        ),
      ]),
    ],
  ),
  IELTSReadingTest(
    title: 'General Training Reading Test 1',
    category: IELTSReadingCategory.generalTraining,
    passage: const ReadingPassage(
      title: 'Notice: Riverside Community Centre',
      level: 'General Training',
      minutes: 18,
      text: 'RIVERSIDE COMMUNITY CENTRE\n\nThe centre will close for building maintenance from Monday 12 August to Wednesday 14 August. All evening classes scheduled during this period are cancelled. Members may use the North Street branch, which remains open from 8.00 am to 9.00 pm.\n\nA replacement session for the cancelled photography class will take place on Saturday 17 August in Room 4. Participants should bring their own camera. The centre cafe will remain closed until Friday 16 August, but the reception desk will be available by telephone between 9.00 am and 5.00 pm.\n\nMembership cards can be renewed online during the closure. Members who need help should email the office; replies may take up to two working days.',
      words: [],
      questions: [],
    ),
    sections: [
      IELTSReadingSection(title: 'Questions 1-3', questions: [
        _multipleChoice(
          'Why will Riverside Community Centre close?',
          [
            'For building maintenance.',
            'For a photography exhibition.',
            'Because the North Street branch is closing.',
            'Because membership has ended.',
          ],
          'For building maintenance.',
          'The notice says the centre will close for building maintenance.',
        ),
        _trueFalseNotGiven(
          'The North Street branch will remain open during the closure.',
          'TRUE',
          'The notice explicitly says that the North Street branch remains open.',
        ),
        _sentenceCompletion(
          'The replacement photography class is in Room _____.',
          '4',
          'The replacement session will take place in Room 4.',
        ),
      ]),
      IELTSReadingSection(title: 'Questions 4-6', questions: [
        _summaryCompletion(
          'The reception desk can be contacted by telephone between 9.00 am and _____ pm.',
          '5',
          'The notice lists telephone hours as 9.00 am to 5.00 pm.',
        ),
        _multipleChoice(
          'What should photography participants bring?',
          ['Their own camera', 'A membership form', 'A printed timetable', 'A laptop'],
          'Their own camera',
          'The replacement session notice asks participants to bring their own camera.',
        ),
        _trueFalseNotGiven(
          'Email replies will always arrive on the same day.',
          'FALSE',
          'Replies may take up to two working days, so same-day replies are not guaranteed.',
        ),
      ]),
    ],
  ),
  IELTSReadingTest(
    title: 'General Training Reading Test 2',
    category: IELTSReadingCategory.generalTraining,
    passage: const ReadingPassage(
      title: 'Passenger Information: CityLink Bus Passes',
      level: 'General Training',
      minutes: 18,
      text: 'CITYLINK WEEKLY BUS PASSES\n\nA weekly pass is valid for seven consecutive days from the date of first use. It can be used on all CityLink local routes, but not on express coaches or services operated by another company. Passes are available from ticket machines at major stations and from the CityLink mobile application.\n\nPassengers who buy a pass through the application must activate it before boarding. A printed pass should be shown to the driver when entering the bus. Lost paper passes cannot be replaced, although a pass bought through an account can be restored after the passenger contacts customer support.\n\nChildren under five travel free when accompanied by an adult with a valid ticket. Reduced fares are available to students with a current identification card. Refund requests must be submitted within 48 hours of purchase and are not accepted after the pass has been activated.',
      words: [],
      questions: [],
    ),
    sections: [
      IELTSReadingSection(title: 'Questions 1-3', questions: [
        _multipleChoice(
          'When does a weekly pass become valid?',
          [
            'For seven days from first use.',
            'For seven days from the date printed on the timetable.',
            'Only on the day it is purchased.',
            'For seven working days after activation.',
          ],
          'For seven days from first use.',
          'The notice defines validity as seven consecutive days from the date of first use.',
        ),
        _trueFalseNotGiven(
          'The pass is valid on express coaches.',
          'FALSE',
          'The notice excludes express coaches.',
        ),
        _sentenceCompletion(
          'App users must _____ their pass before boarding.',
          'activate',
          'Passengers who buy through the application must activate the pass before boarding.',
        ),
      ]),
      IELTSReadingSection(title: 'Questions 4-6', questions: [
        _summaryCompletion(
          'A refund request must be made within _____ hours of purchase.',
          '48',
          'Refund requests must be submitted within 48 hours.',
        ),
        _multipleChoice(
          'Who may travel free?',
          [
            'Children under five with an adult holding a valid ticket.',
            'All students with identification.',
            'Any child travelling alone.',
            'Passengers using an express coach.',
          ],
          'Children under five with an adult holding a valid ticket.',
          'The notice gives free travel only to children under five accompanied by a ticketed adult.',
        ),
        _trueFalseNotGiven(
          'A lost paper pass can be restored by customer support.',
          'FALSE',
          'The notice says lost paper passes cannot be replaced; restoration applies to account-based purchases.',
        ),
      ]),
    ],
  ),
  IELTSReadingTest(
    title: 'General Training Reading Test 3',
    category: IELTSReadingCategory.generalTraining,
    passage: const ReadingPassage(
      title: 'Letter: Evening Courses at Westfield College',
      level: 'General Training',
      minutes: 18,
      text: 'Dear prospective student,\n\nWestfield College is accepting applications for its autumn evening courses. Classes begin in the week starting 7 October and run for ten weeks. Most courses meet once a week from 6.30 pm to 8.30 pm. The digital photography course meets on Tuesday, while introductory accounting is held on Thursday.\n\nApplicants should complete the online form and upload proof of address. The application deadline is 20 September. Students who need to withdraw before the second class may receive a partial refund, provided they notify the admissions office in writing. Course materials are not included in the fee.\n\nThe college library is open until 9.00 pm on class evenings. Parking is limited, so students are encouraged to use bus route 16, which stops outside the main entrance.',
      words: [],
      questions: [],
    ),
    sections: [
      IELTSReadingSection(title: 'Questions 1-3', questions: [
        _multipleChoice(
          'How long do the evening courses run?',
          ['Ten weeks', 'Seven weeks', 'One term of twenty weeks', 'Until 20 September'],
          'Ten weeks',
          'The letter says that the courses run for ten weeks.',
        ),
        _trueFalseNotGiven(
          'Introductory accounting classes are held on Tuesday.',
          'FALSE',
          'Accounting is held on Thursday; photography is on Tuesday.',
        ),
        _sentenceCompletion(
          'Applicants must upload proof of _____.',
          'address',
          'The application instructions require proof of address.',
        ),
      ]),
      IELTSReadingSection(title: 'Questions 4-6', questions: [
        _summaryCompletion(
          'The application deadline is 20 _____.',
          'September',
          'The letter states that applications close on 20 September.',
        ),
        _multipleChoice(
          'When may a student receive a partial refund?',
          [
            'When withdrawing before the second class and notifying the office in writing.',
            'At any time during the ten-week course.',
            'When course materials have been purchased.',
            'Only after the course ends.',
          ],
          'When withdrawing before the second class and notifying the office in writing.',
          'Both conditions are specified in the withdrawal policy.',
        ),
        _trueFalseNotGiven(
          'Every student is guaranteed a parking space.',
          'FALSE',
          'Parking is limited, so a space is not guaranteed.',
        ),
      ]),
    ],
  ),
];
