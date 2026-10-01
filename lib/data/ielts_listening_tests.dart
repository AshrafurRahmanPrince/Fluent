import '../models/listening_models.dart';

const ieltsListeningTests = <IELTSListeningTest>[
  IELTSListeningTest(
    title: 'IELTS Listening Test 1',
    sections: [
      IELTSListeningSection(
        title: 'Section 1: Community Garden Registration',
        audioScript:
            'Good morning. I am calling about the Riverside Community Garden. The first volunteer meeting is on Saturday the fourteenth of June. Please arrive at half past eight and meet us at the north gate. You should bring a pair of gardening gloves, although the centre can lend you basic tools. Each family plot measures two metres by three metres. If you need to change your registration, contact Maya at 01632 440 218 before Thursday.',
        questions: [
          IELTSListeningQuestion(
            prompt: 'The first volunteer meeting is on Saturday the ____ of June.',
            answer: '14th',
            acceptableAnswers: ['14', 'fourteenth'],
            explanation: 'The speaker says the meeting is on Saturday the fourteenth of June.',
          ),
          IELTSListeningQuestion(
            prompt: 'Volunteers should arrive at ____.',
            answer: '8:30',
            acceptableAnswers: ['8.30', 'half past eight'],
            explanation: 'The arrival time is given as half past eight.',
          ),
          IELTSListeningQuestion(
            prompt: 'The group will meet at the ____ gate.',
            answer: 'north',
            explanation: 'The caller asks volunteers to meet at the north gate.',
          ),
          IELTSListeningQuestion(
            prompt: 'Participants should bring gardening ____.',
            answer: 'gloves',
            explanation: 'The caller asks participants to bring a pair of gardening gloves.',
          ),
          IELTSListeningQuestion(
            prompt: 'Each family plot measures two metres by ____ metres.',
            answer: 'three',
            acceptableAnswers: ['3'],
            explanation: 'The plot size is two metres by three metres.',
          ),
        ],
      ),
      IELTSListeningSection(
        title: 'Section 2: University Library Tour',
        audioScript:
            'Welcome to Westbridge University Library. New students can collect their access card from the help desk beside the main entrance. The silent study area is on the third floor, while group rooms are on the second floor and should be booked online. The computer room closes at seven in the evening from Monday to Friday. During the first week of term, library tours begin every hour from ten o’clock. Please remember that food is permitted only in the ground-floor cafe.',
        questions: [
          IELTSListeningQuestion(
            prompt: 'Students collect their access card from the ____ desk.',
            answer: 'help',
            explanation: 'The help desk is beside the main entrance.',
          ),
          IELTSListeningQuestion(
            prompt: 'The silent study area is on the ____ floor.',
            answer: 'third',
            acceptableAnswers: ['3rd', '3'],
            explanation: 'The silent study area is located on the third floor.',
          ),
          IELTSListeningQuestion(
            prompt: 'Group rooms must be booked ____.',
            answer: 'online',
            explanation: 'The speaker says group rooms should be booked online.',
          ),
          IELTSListeningQuestion(
            prompt: 'The computer room closes at ____ pm on weekdays.',
            answer: '7',
            acceptableAnswers: ['seven', '7:00', '7.00'],
            explanation: 'It closes at seven in the evening from Monday to Friday.',
          ),
          IELTSListeningQuestion(
            prompt: 'Food is permitted only in the ground-floor ____.',
            answer: 'cafe',
            acceptableAnswers: ['café'],
            explanation: 'Food is allowed only in the cafe on the ground floor.',
          ),
        ],
      ),
    ],
  ),
];