import '../models/quiz_question.dart';

class _QuestionSeed {
  const _QuestionSeed(
    this.category,
    this.prompt,
    this.options,
    this.correctAnswerIndex,
    this.explanation,
  );

  final IELTSQuestionCategory category;
  final String prompt;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuizQuestion build(int number) => QuizQuestion(
        id: 'IELTS-${number.toString().padLeft(3, '0')}',
        category: category,
        prompt: prompt,
        options: options,
        correctAnswerIndex: correctAnswerIndex,
        explanation: explanation,
      );
}

const List<_QuestionSeed> _questionSeeds = [
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'In the sentence "The new tax may exacerbate inequality," what does exacerbate mean?',
      ['Measure', 'Worsen', 'Conceal', 'Prevent'],
      1,
      'Exacerbate means to make a problem or negative condition more severe.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'Which verb means to make the harmful effects of something less severe?',
      ['Mitigate', 'Provoke', 'Accelerate', 'Preserve'],
      0,
      'Mitigate means to reduce the seriousness or impact of something.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'The adjective "ubiquitous" is closest in meaning to:',
      [
        'Rare and valuable',
        'Present everywhere',
        'Difficult to identify',
        'Recently developed'
      ],
      1,
      'Ubiquitous describes something that is found or appears everywhere.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'To discern a pattern in a large data set is to:',
      [
        'Reject it without review',
        'Recognise or distinguish it',
        'Make it more complicated',
        'Record it from memory'
      ],
      1,
      'Discern means to perceive, recognise, or distinguish something.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'Which word best completes the meaning: "Her explanation is plausible, although not yet proven"?',
      ['Believable', 'Irrelevant', 'Certain', 'Biased'],
      0,
      'Plausible means seeming reasonable or likely, even when proof is incomplete.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'A stringent regulation is one that is:',
      [
        'Applied inconsistently',
        'Very strict',
        'Easy to amend',
        'Entirely voluntary'
      ],
      1,
      'Stringent rules are strict, precise, and demanding.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'The council will allocate more funds to public transport. Allocate means to:',
      [
        'Set aside for a purpose',
        'Borrow temporarily',
        'Remove from a budget',
        'Estimate inaccurately'
      ],
      0,
      'Allocate means to distribute or assign resources for a particular purpose.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'If a building deteriorates, it:',
      [
        'Becomes less sound over time',
        'Is restored to its original state',
        'Changes ownership',
        'Is measured in detail'
      ],
      0,
      'Deteriorate means to become worse in condition or quality.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'Which is closest in meaning to "prevalent"?',
      [
        'Widely occurring',
        'Recently discovered',
        'Closely monitored',
        'Poorly understood'
      ],
      0,
      'Prevalent describes something common or widespread in a particular place or group.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'An ambiguous instruction is one that:',
      [
        'Can be interpreted in more than one way',
        'Is supported by evidence',
        'Must be followed immediately',
        'Uses technical vocabulary'
      ],
      0,
      'Ambiguous language has more than one possible meaning and is therefore unclear.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'Which verb means to publicly support or approve a proposal?',
      ['Endorse', 'Undermine', 'Postpone', 'Dismiss'],
      0,
      'To endorse a proposal is to express public approval or support for it.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'A sustainable policy is designed to:',
      [
        'Continue without exhausting resources',
        'Produce immediate profit only',
        'Avoid all technological change',
        'Transfer costs to future users'
      ],
      0,
      'Sustainable practices can continue over time without depleting resources or causing unacceptable harm.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'The difference in cost was negligible. This means it was:',
      [
        'Too small to be important',
        'Impossible to calculate',
        'Larger than expected',
        'Clearly unfair'
      ],
      0,
      'Negligible means so small or unimportant that it can be disregarded.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'A coherent argument is one that is:',
      [
        'Logical and well organised',
        'Emotionally forceful but unsupported',
        'Brief and highly technical',
        'Based on conflicting claims'
      ],
      0,
      'A coherent argument is consistent, logically connected, and easy to follow.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'If residents are reluctant to relocate, they are:',
      [
        'Unwilling or hesitant to do so',
        'Unable to find a destination',
        'Required to move quickly',
        'Already settled elsewhere'
      ],
      0,
      'Reluctant means unwilling or hesitant, often because of uncertainty or concern.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'The subsequent investigation found no further evidence. Subsequent means:',
      [
        'Happening afterwards',
        'Occurring at the same time',
        'Causing the original event',
        'Unrelated to the topic'
      ],
      0,
      'Subsequent describes something that follows or comes after another event.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'Interactive maps can facilitate access to public services. Facilitate means:',
      [
        'Make easier',
        'Make less reliable',
        'Prevent entirely',
        'Make more expensive'
      ],
      0,
      'Facilitate means to make an action or process easier.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'An arbitrary decision is made:',
      [
        'Without a clear principle or reason',
        'After extensive consultation',
        'According to published criteria',
        'Only when evidence is conclusive'
      ],
      0,
      'Arbitrary describes a choice based on personal whim rather than a consistent rule.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'A resilient community is able to:',
      [
        'Recover after difficulty',
        'Avoid every possible risk',
        'Expand without planning',
        'Remain unchanged indefinitely'
      ],
      0,
      'Resilient people or systems can adapt and recover after disruption.'),
  _QuestionSeed(
      IELTSQuestionCategory.vocabulary,
      'Heavy traffic can hamper emergency services. Hamper means:',
      [
        'Hinder or obstruct',
        'Fund generously',
        'Predict accurately',
        'Replace completely'
      ],
      0,
      'Hamper means to make an activity more difficult or slow its progress.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'Choose the sentence with correct subject-verb agreement.',
      [
        'The range of options are limited.',
        'The range of options is limited.',
        'The range of options have been limited.',
        'The range of options were limited today.'
      ],
      1,
      'The subject is the singular noun "range"; the plural noun "options" is part of a prepositional phrase.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'Only after the data had been checked ___ the researchers publish their findings.',
      ['did', 'had', 'have', 'were'],
      0,
      'A negative or restrictive phrase at the beginning triggers inversion: "Only after ... did the researchers publish".'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'If the council ___ the proposal last year, the bridge would be open now.',
      ['approved', 'had approved', 'would approve', 'has approved'],
      1,
      'This mixed conditional uses past perfect in the if-clause for an unreal past condition with a present result.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The study provides ___ useful insight into urban migration.',
      ['a', 'an', 'the', 'no article'],
      3,
      'Insight is uncountable in this general meaning, so it does not take an indefinite article.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The committee recommended that the report ___ revised before publication.',
      ['is', 'was', 'be', 'being'],
      2,
      'After verbs such as recommend, formal English can use the mandative subjunctive: "that the report be revised".'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The researcher to ___ I sent the questionnaire replied promptly.',
      ['who', 'whom', 'whose', 'which'],
      1,
      'Whom is the object of the preposition "to" in formal written English.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'By the time the survey closes, we ___ responses from all regions.',
      ['receive', 'received', 'will have received', 'are receiving'],
      2,
      'The future perfect describes an action that will be complete before a specified future time.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The course aims to develop critical thinking, improve writing, and ___.',
      [
        'students speak confidently',
        'to speak with confidence',
        'speaking confident',
        'build confidence in speaking'
      ],
      3,
      'The list is parallel when each item is a verb phrase: develop, improve, and build.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'Despite ___ several warnings, the company continued to discharge waste.',
      ['receive', 'receiving', 'received', 'to receive'],
      1,
      'Despite is a preposition and is followed by a noun or gerund, not a finite clause.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      '___ by a local charity, the project was able to extend its services.',
      ['Funding', 'Funded', 'To fund', 'Having fund'],
      1,
      'The past participle "funded" forms a reduced passive clause describing the project.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'Neither the director nor the assistants ___ available for comment.',
      ['was', 'is', 'were', 'has been'],
      2,
      'With neither...nor, the verb commonly agrees with the nearer subject; "assistants" is plural.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'Rarely ___ such a rapid change in consumer behaviour.',
      [
        'we have observed',
        'have we observed',
        'we observed have',
        'observed we have'
      ],
      1,
      'Rarely at the start of a clause requires subject-auxiliary inversion.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'If the researchers had used a larger sample, the results ___ more reliable.',
      ['would be', 'will have been', 'would have been', 'were'],
      2,
      'The third conditional uses "would have" plus a past participle for an unreal past result.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The new laboratory ___ next month, according to the project manager.',
      ['will complete', 'will be completed', 'completes', 'has completed'],
      1,
      'The laboratory receives the action, so the future passive "will be completed" is required.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The proposal, ___ was revised twice, was eventually approved.',
      ['that', 'what', 'which', 'who'],
      2,
      'A non-defining relative clause after a comma takes "which"; "that" is not used here.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'There is little ___ that the policy reduced emissions.',
      ['evidence', 'evidences', 'an evidence', 'the evidences'],
      0,
      'Evidence is normally uncountable and takes no plural ending in this general sense.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'Provided that the data ___ accurate, the model should produce reliable forecasts.',
      ['remain', 'remains', 'remained', 'will remain'],
      0,
      'In a conditional clause referring to the future, use the present simple rather than "will".'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The spokesperson said that the company ___ the results the following week.',
      ['announces', 'will announce', 'would announce', 'has announced'],
      2,
      'Reported speech commonly backshifts "will" to "would" after a past reporting verb.'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'The more accessible public transport becomes, ___ people rely on private cars.',
      ['fewer', 'the fewer', 'the less', 'lesser'],
      2,
      'The correlative comparative pattern is "the more..., the less...".'),
  _QuestionSeed(
      IELTSQuestionCategory.grammar,
      'Having completed the interviews, ___.',
      [
        'the transcripts were analysed by the team',
        'the team analysed the transcripts',
        'the transcripts analysed themselves',
        'analysis of the transcripts began'
      ],
      1,
      'The understood subject of the opening participle must match the subject of the main clause: the team completed the interviews.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Choose the natural collocation: The university plans to ___ research into coastal erosion.',
      ['make', 'conduct', 'perform up', 'do out'],
      1,
      'Conduct research is the standard academic collocation.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The report warns that rising temperatures ___ a serious threat to food security.',
      ['pose', 'put', 'set', 'give'],
      0,
      'Pose a threat is the conventional collocation meaning to present a danger.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Local residents can ___ a crucial role in monitoring air quality.',
      ['play', 'act', 'do', 'make'],
      0,
      'Play a role is the natural collocation for having an influence or function.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'After several hours of debate, the delegates managed to ___ a consensus.',
      ['reach', 'arrive', 'touch', 'meet'],
      0,
      'Reach a consensus means to arrive at a shared agreement.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The evidence is too limited to ___ a firm conclusion.',
      ['draw', 'pull', 'write', 'take'],
      0,
      'Draw a conclusion is the standard expression for inferring a result from evidence.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The authors present ___ evidence for the link between sleep and memory.',
      ['compelling', 'persuading', 'convincingness', 'compelled'],
      0,
      'Compelling evidence is evidence that is convincing and persuasive.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Flights were delayed because of ___ rain throughout the region.',
      ['heavy', 'strong', 'large', 'thick'],
      0,
      'Heavy rain is the conventional collocation for intense rainfall.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Given the current forecast, a complete recovery by Friday is ___ unlikely.',
      ['highly', 'deeply', 'strongly', 'widely'],
      0,
      'Highly unlikely is a common adverb-adjective collocation.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'To qualify for the grant, applicants must ___ the deadline.',
      ['meet', 'satisfy', 'match up', 'achieve to'],
      0,
      'Meet a deadline means to complete or submit something by the required time.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The campaign aims to ___ awareness of the risks associated with air pollution.',
      ['raise', 'lift', 'grow up', 'rise'],
      0,
      'Raise awareness is the standard collocation for increasing public knowledge.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Any comparison should ___ account the different sizes of the two samples.',
      ['take into', 'make into', 'put on', 'bring to'],
      0,
      'Take into account means to consider a relevant factor.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The committee will ___ the issue of unequal access at its next meeting.',
      ['address', 'speak', 'approach to', 'answer with'],
      0,
      'Address an issue means to consider it and take action or provide a response.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The survey covers a ___ range of age groups and occupations.',
      ['broad', 'wide-rangingly', 'large amount', 'tall'],
      0,
      'A broad range is a natural collocation meaning a varied or extensive selection.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The city recorded a ___ decline in bus use after fares increased.',
      ['sharp', 'pointed', 'cutting', 'steeply'],
      0,
      'A sharp decline describes a sudden or substantial decrease.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The revised curriculum places ___ emphasis on analytical writing.',
      ['strong', 'powerful', 'hard', 'heavy'],
      0,
      'Place strong emphasis on something is the standard formal collocation.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Participants were asked to ___ close attention to the instructions.',
      ['pay', 'give', 'put', 'spend'],
      0,
      'Pay attention is the established collocation.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Regular feedback can help learners ___ progress more quickly.',
      ['make', 'do', 'create up', 'perform'],
      0,
      'Make progress means to improve or move forward in learning.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'When the supply chain failed, the team had to ___ down the causes of the delay.',
      ['break', 'cut', 'divide', 'lower'],
      0,
      'Break down a problem or process means to analyse it in detail.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'Researchers should ___ in mind that correlation does not prove causation.',
      ['bear', 'hold', 'carry', 'keep up'],
      0,
      'Bear in mind is a formal expression meaning to remember or consider.'),
  _QuestionSeed(
      IELTSQuestionCategory.collocations,
      'The decision may have ___-reaching consequences for rural communities.',
      ['far', 'long', 'wide', 'deep'],
      0,
      'Far-reaching consequences are effects that extend widely or have major influence.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The wetland was drained to create farmland. Within a decade, nearby wells became salty and several bird species disappeared." What is the most strongly supported inference?',
      [
        'Drainage had unintended ecological and water-quality effects.',
        'The farmland produced record harvests.',
        'All bird species in the region became extinct.',
        'Salt water was deliberately added to the wells.'
      ],
      0,
      'The timing and outcomes suggest that drainage contributed to environmental changes, although the passage does not quantify every effect.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "Although the pilot scheme reduced waiting times, its cost per patient was twice that of existing clinics." What concern remains unresolved?',
      [
        'Whether the shorter waits justify the higher cost.',
        'Whether patients prefer longer waiting times.',
        'Whether clinics can treat any patients.',
        'Whether the pilot reduced staffing needs.'
      ],
      0,
      'The passage reports a benefit and a cost but does not judge whether the benefit justifies the expense.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "Researchers surveyed commuters at the central station between 8 and 9 a.m. They concluded that most city residents cycled to work." Which limitation most weakens the conclusion?',
      [
        'The sample excludes many residents and travel times.',
        'The survey was conducted in a city.',
        'Commuters were asked about transport.',
        'The station was open in the morning.'
      ],
      0,
      'A single station and one hour do not represent all city residents, so the sample is biased and too narrow.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The museum extended its opening hours. Visitor numbers rose by 18%, while the proportion of visitors arriving after 5 p.m. remained unchanged." What can be inferred?',
      [
        'The increase cannot be attributed solely to late opening.',
        'Late opening caused all additional visits.',
        'The museum received fewer visitors overall.',
        'Most visitors arrived after 5 p.m.'
      ],
      0,
      'The unchanged late-arrival proportion suggests other factors may explain the total increase.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "In one trial, plants exposed to low-intensity sound grew slightly faster. The researchers cautioned that the study lasted only three weeks." Why is the caution relevant?',
      [
        'The result may not hold over longer periods.',
        'Sound exposure was not measured.',
        'The plants were not observed.',
        'The trial proved sound has no effect.'
      ],
      0,
      'A short trial cannot establish whether the small difference persists or has long-term significance.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The archive digitised its newspapers, but access to the online collection requires a paid subscription." Which statement is accurate?',
      [
        'Digitisation improved availability, but access is not unrestricted.',
        'All newspapers became free to the public.',
        'The archive stopped preserving printed copies.',
        'Subscribers can access only recent editions.'
      ],
      0,
      'The collection is online but subscription-controlled, so digitisation did not make access universal.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "A new road shortened the journey to the industrial park. However, traffic noise increased in two residential districts." What trade-off is described?',
      [
        'Faster access accompanied by greater noise for some residents.',
        'Lower noise accompanied by longer journeys.',
        'Reduced employment accompanied by less traffic.',
        'More road access accompanied by fewer vehicles.'
      ],
      0,
      'The passage contrasts improved travel time with increased noise in nearby neighbourhoods.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The report uses household income as an indicator of poverty, while noting that it does not measure access to healthcare or housing quality." What does the caveat indicate?',
      [
        'Income alone gives an incomplete picture of poverty.',
        'Income is unrelated to living conditions.',
        'Healthcare access was measured precisely.',
        'Housing quality is identical across households.'
      ],
      0,
      'The report acknowledges that its chosen indicator omits other important dimensions of deprivation.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "After the library introduced self-checkout, queues shortened. Staff were then reassigned to support visitors with research." Which outcome is explicitly stated?',
      [
        'Staff time was redirected to research support.',
        'The library reduced its total workforce.',
        'Visitors stopped borrowing books.',
        'Research services were removed.'
      ],
      0,
      'The passage directly states that staff were reassigned to assist with research.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The coastal wall prevented flooding during three moderate storms, but engineers warned that it had not been tested under a severe surge." What is the best conclusion?',
      [
        'Its performance in extreme conditions remains uncertain.',
        'It failed during every moderate storm.',
        'A severe surge is impossible in the area.',
        'The wall guarantees permanent protection.'
      ],
      0,
      'Success in moderate storms does not establish effectiveness during a more severe event.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "More graduates entered the profession this year, yet vacancies persisted in remote districts where housing is scarce." What factor may explain the continuing vacancies?',
      [
        'The location and housing conditions deter applicants.',
        'There are fewer graduates nationwide.',
        'Remote districts have no professional roles.',
        'Housing is more available in remote areas.'
      ],
      0,
      'The passage links persistent vacancies to remote location and limited housing, despite a larger graduate supply.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The survey found that 62% of respondents supported the policy. Responses came from members of an organisation that had campaigned for it." Which issue should readers consider?',
      [
        'The sample may overrepresent people already favourable to the policy.',
        'The survey included every voter.',
        'The policy had already been implemented.',
        'The percentage was below half.'
      ],
      0,
      'A group recruited from campaign supporters may not represent the wider population.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "Solar output fell during winter, but annual generation exceeded the previous year because panels were installed across a larger area." What explains the annual increase?',
      [
        'Expansion in panel area offset the seasonal decline.',
        'Winter output increased sharply.',
        'The panels were removed in summer.',
        'Annual generation was not recorded.'
      ],
      0,
      'The passage attributes the higher annual total to more installed panels despite lower winter output.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The author describes the policy as ambitious but offers no estimate of its implementation cost." What information is missing for evaluating feasibility?',
      [
        'The resources required to carry it out.',
        'The author’s opinion of the policy.',
        'Whether the policy has a title.',
        'The order in which paragraphs appear.'
      ],
      0,
      'Cost and resource requirements are essential to judging whether a policy can be implemented.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "Children who attended the after-school programme scored higher on a later test. Participation was voluntary." Why can the result not establish that the programme caused the higher scores?',
      [
        'Participants may differ from non-participants in other ways.',
        'The test was taken after the programme.',
        'Scores can never be compared.',
        'The programme took place after school.'
      ],
      0,
      'Voluntary participants may have had other advantages, so the association alone does not prove causation.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The council planted 4,000 trees, but survival rates were not recorded after the first summer." What prevents a full assessment of the project?',
      [
        'The number of trees still alive is unknown.',
        'The initial planting total is missing.',
        'The project had no location.',
        'The council did not plant any trees.'
      ],
      0,
      'Initial planting counts do not reveal long-term success without survival data.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The first edition sold poorly. A revised edition, released after a major television adaptation, became a bestseller." Which factor complicates claims about the revision?',
      [
        'The adaptation may have increased interest independently.',
        'The revised edition came first.',
        'The first edition was never published.',
        'Television adaptations reduce book sales.'
      ],
      0,
      'The adaptation is a possible confounding factor in explaining the later sales increase.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "Factory emissions declined after new filters were installed, although production also fell by 20% during the same period." What makes the effect of the filters difficult to isolate?',
      [
        'Lower production may also have reduced emissions.',
        'The filters were installed after emissions were measured.',
        'Emissions increased throughout the period.',
        'Production levels were identical.'
      ],
      0,
      'A simultaneous drop in production is another plausible cause of lower emissions.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The survey was translated into six languages, but interviews were conducted only by telephone." Which group could still be underrepresented?',
      [
        'People without reliable telephone access.',
        'People who speak one of the six languages.',
        'People who own a telephone.',
        'People living in the survey area.'
      ],
      0,
      'Translation broadens language access, but a telephone-only method can exclude people without reliable phone service.'),
  _QuestionSeed(
      IELTSQuestionCategory.contextualReading,
      'Passage: "The author argues that remote work reduces office costs but acknowledges that collaboration may become less spontaneous." What is the author’s position?',
      [
        'Remote work offers benefits alongside a potential drawback.',
        'Remote work has no measurable effects.',
        'Office costs always increase.',
        'Collaboration is impossible online.'
      ],
      0,
      'The author presents a qualified argument, recognising both a benefit and a possible disadvantage.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The findings are preliminary; ___, they should not yet inform national policy.',
      ['nevertheless', 'therefore', 'similarly', 'meanwhile'],
      1,
      'Therefore signals the logical result: preliminary findings should not yet guide national policy.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The device is inexpensive to purchase, ___ its long-term maintenance costs are substantial.',
      ['whereas', 'because', 'unless', 'so that'],
      0,
      'Whereas contrasts the low purchase price with substantial maintenance costs.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: ___ the initial expense, the insulation reduced household energy bills.',
      ['Despite', 'Because', 'Unless', 'Whereas'],
      0,
      'Despite is followed by a noun phrase and introduces a contrast with the cost-saving result.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The policy will succeed only if local authorities ___ sufficient funding.',
      ['receive', 'received', 'will receive', 'would receive'],
      0,
      'The if-clause uses present simple for a future condition.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The sample was too small to ___ a reliable estimate of national demand.',
      ['yield', 'settle', 'compose', 'restore'],
      0,
      'Yield means to produce or provide a result, such as an estimate.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: Researchers repeated the experiment ___ the original result could be verified.',
      ['so that', 'even though', 'as if', 'in case of'],
      0,
      'So that introduces the purpose of repeating the experiment.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The data were incomplete; ___, the researchers reported their conclusions cautiously.',
      ['accordingly', 'otherwise', 'by contrast', 'for instance'],
      0,
      'Accordingly means as a result and links the limitation to the cautious reporting.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The new route is faster, ___ it serves fewer neighbourhoods.',
      ['although', 'because', 'therefore', 'in order that'],
      0,
      'Although introduces a contrast between speed and coverage.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: No sooner ___ the announcement than demand for tickets doubled.',
      [
        'the venue made',
        'had the venue made',
        'the venue had made',
        'did the venue make'
      ],
      1,
      'No sooner at the beginning takes inversion and is followed by past perfect: "No sooner had...".'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The proposal was rejected, not because it lacked merit, ___ because it exceeded the budget.',
      ['but', 'and', 'or', 'nor'],
      0,
      'The paired structure "not because..., but because..." contrasts the actual reason with the rejected one.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The archive is valuable ___ it preserves records unavailable elsewhere.',
      ['inasmuch as', 'in spite of', 'as long as', 'whereas'],
      0,
      'Inasmuch as means because or to the extent that, introducing the reason for the archive’s value.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The scheme is cost-effective ___ participation remains high.',
      ['provided that', 'even if', 'in contrast', 'as though'],
      0,
      'Provided that means on the condition that and introduces a necessary condition.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The speaker cited several studies, ___ none directly examined rural communities.',
      ['yet', 'since', 'so that', 'unless'],
      0,
      'Yet introduces a contrast between citing studies and their limited relevance.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The manager asked that each applicant ___ a writing sample.',
      ['submit', 'submits', 'submitted', 'will submit'],
      0,
      'A formal request can take the mandative subjunctive, using the base form "submit".'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The results were consistent across regions, ___ the measurement methods differed slightly.',
      ['even though', 'as a result', 'in addition', 'so that'],
      0,
      'Even though introduces a concession: consistency occurred despite methodological differences.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The grant covers equipment; ___, applicants must fund their own travel.',
      ['however', 'therefore', 'for example', 'likewise'],
      0,
      'However marks the contrast between covered equipment and uncovered travel.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: Had the warning been issued earlier, fewer residents ___ the area.',
      ['would evacuate', 'would have left', 'will leave', 'had left'],
      1,
      'This inverted third conditional describes an unreal past: "Had... been issued, ... would have left".'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The company revised its guidelines ___ several employees had misunderstood the original wording.',
      ['after', 'despite', 'whereas', 'unless'],
      0,
      'After links the revision to the earlier event that prompted it.'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The more frequently a skill is practised, ___ it becomes.',
      [
        'the more automatic',
        'more automatic',
        'the most automatic',
        'as automatic'
      ],
      0,
      'The comparative correlative pattern is "the more..., the more...".'),
  _QuestionSeed(
      IELTSQuestionCategory.sentenceCompletion,
      'Complete the sentence: The report distinguishes between evidence that is merely suggestive and evidence that is ___.',
      ['conclusive', 'conclusion', 'conclusively', 'conclude'],
      0,
      'The adjective conclusive is parallel to suggestive and means decisive or final.'),
];

final List<QuizQuestion> ieltsQuestionBank = List.unmodifiable([
  for (var index = 0; index < _questionSeeds.length; index++)
    _questionSeeds[index].build(index + 1),
]);
