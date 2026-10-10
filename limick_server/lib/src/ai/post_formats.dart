import 'dart:math';

import '../generated/protocol.dart';

/// The social formats posts are written in. Each format is a voice people
/// already scroll for on social apps, pointed at a real passage.
///
/// Examples deliberately use books that are not in the starter library, so
/// the model copies the voice, not the facts.
class PostFormat {
  final String id;
  final PostKind kind;
  final String guide;
  final String example;

  /// More examples in the same voice; one is picked per request so the
  /// model doesn't clone a single template.
  final List<String> more;
  const PostFormat(
    this.id,
    this.kind,
    this.guide,
    this.example, [
    this.more = const [],
  ]);

  String pickExample(Random random) {
    final all = [example, ...more];
    return all[random.nextInt(all.length)];
  }
}

const postFormats = <PostFormat>[
  PostFormat(
    'hotTake',
    PostKind.insight,
    'A bold one-line claim drawn from the passage, then one or two short lines of why. Confident, a little cheeky.',
    'hot take: Sun Tzu would have been terrible at group projects.\n\nthe man literally said the best battle is the one you never fight. imagine him in a 9am standup.',
    [
      'unpopular opinion: Frankenstein is a parenting book. the creature literally just wanted his dad to call him back.',
    ],
  ),
  PostFormat(
    'storytime',
    PostKind.insight,
    'A tiny story retold from the passage in present tense, like a viral storytime post. 3 to 5 short sentences, vivid detail, ends on a hook that makes people want the next part.',
    "it's 1719. a guy is shipwrecked alone on an island.\n\nhe salvages bread, rum and three bibles from the wreck.\n\nthen he finds a single human footprint in the sand. just one. no others.\n\nhe doesn't sleep that night.",
    [
      '1850s Paris. a chemist notices his wine keeps going sour.\n\neveryone blames bad luck. he blames something too small to see.\n\nhe puts it under a microscope and the whole of medicine quietly changes direction.',
    ],
  ),
  PostFormat(
    'pov',
    PostKind.insight,
    'Starts with "POV:" and drops the reader into the scene or the era described in the passage. Second person, sensory, short lines.',
    'POV: it\'s 1665, you\'re a London doctor, and your entire medical kit is a beaked mask full of herbs and pure optimism.',
    [
      'POV: you\'re a juror in 1700s England and the punishment for stealing a handkerchief is genuinely insane',
    ],
  ),
  PostFormat(
    'til',
    PostKind.insight,
    'Starts with "TIL" and states the single most surprising fact or idea in the passage, then one line on why it still matters.',
    'TIL Benjamin Rush thought you could treat yellow fever by draining a patient\'s blood. he was one of the most respected doctors in America.\n\nconfidence is not evidence.',
    [
      'TIL the word "salary" might come from the salt Roman soldiers were paid with. imagine your payslip being seasoning',
    ],
  ),
  PostFormat(
    'nobodyTalksAbout',
    PostKind.insight,
    'Starts with "nobody talks about how" or "can we talk about how" and points at an overlooked, surprising detail in the passage.',
    'nobody talks about how Sherwood Anderson wrote an entire book about lonely people in one small town and it reads like a group chat that nobody replies to.',
    [
      'can we talk about how Gulliver\'s Travels is just a guy going on four holidays and hating every single one of them',
    ],
  ),
  PostFormat(
    'thenVsNow',
    PostKind.insight,
    'Two short blocks: what the book says (with its year), then a funny or striking modern mirror with a real punchline. Never write "we still" or "still argue"; the second block must be a specific, everyday scene.',
    'Seneca, 65 AD: "we suffer more in imagination than in reality."\n\nme, 2026: rehearsing an argument in the shower that will never happen.',
    [
      'Thoreau, 1854: moves to the woods to live simply\n\nme: buys a \$40 candle called "forest" and calls it self-care',
    ],
  ),
  PostFormat(
    'relatable',
    PostKind.insight,
    'Meme-style text: name a specific moment or line from the passage, then pair it with an everyday modern feeling. The reader must learn what actually happens in the book. Lowercase is fine. One emoji at most.',
    'Odysseus taking ten years to get home after one work trip is the most relatable thing in ancient literature 😭',
    [
      'not Hamlet spending five acts overthinking one decision. sir this is a group chat',
    ],
  ),
  PostFormat(
    'reaction',
    PostKind.quote,
    'Quote-post energy: the quote carries the post; body is a short, casual, genuine reaction (under 120 characters), lowercase fine.',
    'the way Thoreau just casually ended every overthinker in one sentence',
    ['ok I need this on a mug'],
  ),
  PostFormat(
    'vocab',
    PostKind.word,
    'Word post with personality: body opens with something like "new word unlocked:" or "adding this to my vocabulary immediately:" and gives a modern sentence using the word.',
    'new word unlocked: "lugubrious" (looking sad and dismal). use it on your friend who just got left on read.',
    [
      'adding "petrichor" to my vocabulary immediately. the smell of rain on dry ground. finally a word for my favourite thing',
    ],
  ),
  PostFormat(
    'cliffhanger',
    PostKind.thread,
    'Thread. body is a hook with tension that ends with 🧵; parts walk through the passage step by step, each part ending so the next one is needed.',
    'a 1906 book about Chicago meatpacking got the US to pass food safety laws in the same year. here\'s what it described 🧵',
    [
      'there\'s a 1720s pamphlet that suggested a solution to poverty so horrifying people still argue about it. it was satire. mostly. 🧵',
    ],
  ),
  PostFormat(
    'listicle',
    PostKind.thread,
    'Thread. body is a hooky promise in the poster\'s voice that ends with a number and a colon (e.g. "Machiavelli would be a terrifying LinkedIn influencer. 4 receipts:"). Never use the phrase "still hold up". Each part is one numbered, punchy point from the passage.',
    'Machiavelli would be a terrifying LinkedIn influencer. 4 receipts:',
    [
      'Florence Nightingale had zero lab equipment and still clocked all of this. 3 things:',
    ],
  ),
  PostFormat(
    'poll',
    PostKind.quiz,
    'A quiz that reads like an engagement poll: a playful question ("be honest, would you have guessed this?") answerable from the passage, with fun but plausible options.',
    'be honest: what did Victorian doctors blame for most diseases?',
    ['quick one: in 1800s London, what were people told was making them sick?'],
  ),
  PostFormat(
    'ragebait',
    PostKind.debate,
    'A blunt, divisive claim that the passage itself makes (quote the author\'s or a character\'s real position and say whose it is), framed so people want to argue in the replies. If the passage makes no arguable claim, turn its central dilemma into the question instead. Never attack a group of people, never promote a harmful or bigoted view; if the text holds one, frame it critically.',
    'Rousseau thinks civilization made us worse people and we should have stayed in the forest. some days he has a point.',
    [
      'Hobbes says without government life is "nasty, brutish, and short". you\'ve seen a group chat with no admin. was he wrong?',
    ],
  ),
  PostFormat(
    'hotDebate',
    PostKind.debate,
    'A spicy either/or question built on the passage\'s central claim, ending with "agree or disagree?".',
    'Epicurus says the secret to happiness is wanting less, not having more. agree or disagree?',
    [
      'Aristotle says you become brave by doing brave things, not by feeling brave first. agree or disagree?',
    ],
  ),
];

/// Who is posting this batch. A voice makes posts feel written by someone,
/// not generated by something.
const _personas = <Topic, List<String>>{
  Topic.medicine: [
    'a med student who reads old medical books for fun and is a bit dramatic about it',
  ],
  Topic.law: [
    'a law student who treats every legal text like courtroom gossip',
  ],
  Topic.history: [
    'a history nerd who tells stories like they are spilling tea',
  ],
  Topic.biography: [
    'a history nerd who tells stories like they are spilling tea',
  ],
  Topic.philosophy: [
    'a philosophy major with very dry humour',
    'a sleep-deprived student who just discovered philosophy at 2am',
  ],
  Topic.psychology: [
    'a psychology student who keeps diagnosing their friends (affectionately)',
  ],
  Topic.science: [
    'a science teacher who gets genuinely excited and a bit loud about it',
  ],
  Topic.nature: ['a nature lover who notices everything'],
  Topic.mathematics: ['a maths nerd who finds puzzles irresistible'],
  Topic.technology: ['an engineer who loves the history of inventions'],
  Topic.economics: [
    'an economics grad who half-jokingly thinks markets explain everything',
  ],
  Topic.politics: ['a politics student who loves a good argument'],
  Topic.literature: [
    'a bookish twenty-something live-tweeting the classics',
    'a reader who reacts to novels like reality TV',
  ],
  Topic.poetry: ['a soft but funny poetry fan'],
  Topic.religion: [
    'a thoughtful reader of old wisdom texts, curious not preachy',
  ],
  Topic.selfImprovement: ['a self-help skeptic who still finds the real gems'],
  Topic.arts: ['an art student with strong opinions'],
  Topic.education: ['a teacher who has seen it all'],
};

String pickPersona(Book book, Random random) {
  final options =
      _personas[book.primaryTopic] ??
      const ['a curious reader who loves sharing what they read'];
  return options[random.nextInt(options.length)];
}

final _byId = {for (final f in postFormats) f.id: f};
PostFormat? formatById(String? id) => id == null ? null : _byId[id];

/// Formats that suit each topic best. Others can still appear.
const _topicFormats = <Topic, List<String>>{
  Topic.literature: [
    'storytime',
    'pov',
    'relatable',
    'cliffhanger',
    'reaction',
  ],
  Topic.poetry: ['reaction', 'relatable', 'pov', 'vocab'],
  Topic.history: ['storytime', 'pov', 'thenVsNow', 'cliffhanger', 'til'],
  Topic.biography: ['storytime', 'til', 'pov', 'cliffhanger'],
  Topic.medicine: ['til', 'pov', 'storytime', 'nobodyTalksAbout', 'poll'],
  Topic.science: [
    'til',
    'nobodyTalksAbout',
    'thenVsNow',
    'cliffhanger',
    'poll',
  ],
  Topic.nature: ['til', 'storytime', 'pov', 'nobodyTalksAbout'],
  Topic.mathematics: ['til', 'poll', 'nobodyTalksAbout', 'hotTake'],
  Topic.technology: ['til', 'thenVsNow', 'cliffhanger', 'storytime'],
  Topic.philosophy: [
    'hotTake',
    'ragebait',
    'relatable',
    'thenVsNow',
    'hotDebate',
  ],
  Topic.psychology: ['relatable', 'til', 'hotTake', 'nobodyTalksAbout'],
  Topic.economics: [
    'ragebait',
    'hotTake',
    'relatable',
    'storytime',
    'pov',
    'poll',
  ],
  Topic.politics: ['ragebait', 'hotDebate', 'storytime', 'hotTake'],
  Topic.law: ['storytime', 'til', 'hotDebate', 'pov', 'nobodyTalksAbout'],
  Topic.religion: ['reaction', 'hotTake', 'storytime', 'hotDebate'],
  Topic.selfImprovement: ['relatable', 'hotTake', 'listicle', 'reaction'],
  Topic.arts: ['hotTake', 'reaction', 'nobodyTalksAbout'],
  Topic.education: ['hotTake', 'til', 'listicle', 'hotDebate'],
};

/// Picks three different formats for one request: usually one interactive
/// post (poll or debate), one story or take, and one quote, word or thread.
List<PostFormat> pickFormats(Book book, Random random) {
  final preferred = _topicFormats[book.primaryTopic] ?? const [];
  PostFormat pick(List<PostKind> kinds, {bool preferTopic = true}) {
    final options = postFormats.where((f) => kinds.contains(f.kind)).toList();
    final favoured = options.where((f) => preferred.contains(f.id)).toList();
    final pool =
        preferTopic && favoured.isNotEmpty && random.nextDouble() < 0.75
        ? favoured
        : options;
    return pool[random.nextInt(pool.length)];
  }

  final picks = <PostFormat>[];
  void add(PostFormat f) {
    if (picks.every((p) => p.kind != f.kind)) picks.add(f);
  }

  if (random.nextDouble() < 0.7) add(pick([PostKind.quiz, PostKind.debate]));
  add(pick([PostKind.insight]));
  add(pick([PostKind.quote, PostKind.word, PostKind.thread]));
  while (picks.length < 3) {
    add(pick(PostKind.values, preferTopic: false));
  }
  return picks;
}

const postSystemPrompt = '''
You write posts for Limick: a social feed that feels like scrolling X or TikTok, except every post comes from a real public-domain book. People open it on a study break. If a post reads like a textbook, they leave. Each post must stop the scroll in its first line, teach one real thing from the passage, and make them want the next post or the book itself.

How real posts sound:
- First line is the hook. Short lines. Line breaks for rhythm. No preamble, no summary voice.
- Write like one specific person typing on their phone: a real reaction, an opinion, a joke, a bit of drama. Fragments are fine. Lowercase is fine.
- Specific beats general: names, numbers, dates, vivid details from the passage.
- Vary the endings. Most posts just end; don't finish every post with a question.
- Slang and internet phrases are seasoning: at most one per post, and only if it fits the voice.
- Keep it short: most posts under 220 characters; storytime and threads can be longer.

Things that instantly sound like AI, never do them:
- em dashes (use a comma, a full stop or a line break), semicolons, perfectly balanced "not X, but Y" sentences
- "honestly?", "mind blown", "let that sink in", "here's the thing", "buckle up", "game-changer", "delve", "tapestry", "timeless", "in a world where", "that moment when"
- an emoji on every post (at most one emoji, and most posts need none)
- hashtags, "In this passage", "This book", "The author argues"

Rules that are never broken:
- Everything must be true to the passage. Only add widely known context (who the author was, when they wrote). Never invent quotes, numbers, events or opinions.
- evidence: for every post, copy character for character the one or two sentences of the passage that prove the post is true. If you can't find such a sentence, write a different post that you can prove.
- Keep characters and authors apart: what a character says or does is not automatically the author's opinion. Say "Satan says..." not "Milton thinks...".
- Every post teaches something real: a named moment, an idea, a fact or a word from the passage. A joke is the wrapper, never the whole post. No vague "when you're like..." posts without the actual detail from the book.
- Quizzes test the idea or a memorable moment, never trivia like counts of children, dates of minor events or names of minor people. The answer must be stated in the passage.
- Technical passages: skip the mechanics, give the human stakes (why it mattered, what it changed).
- quote fields are copied character for character from the passage.
- word must appear in the passage exactly as written.
- Bait is fine, cruelty is not: no slurs, no attacks on groups or real living people, nothing sexual, no medical or legal advice. If the passage holds an outdated or prejudiced view, you may point it out critically but never endorse it.
- historical is true when the passage's medical, legal or scientific claims are outdated and must not be read as current advice.

Fields by kind (use empty strings, empty arrays and -1 for fields a kind does not use):
- insight: body is the whole post. quote may hold a short exact excerpt that backs it up, or be empty.
- quote: quote is 1 to 3 consecutive sentences copied exactly (40-300 chars), the most striking line. body is the reaction.
- word: word, definition (plain English, max 120 chars), partOfSpeech, quote (the exact sentence containing the word), body.
- thread: body is the opener; parts holds 2 to 4 follow-ups (max 240 chars each).
- quiz: body is the question; options holds 3 or 4 distinct answers; answerIndex is the 0-based correct one; explanation (max 200 chars) gives the answer in a fun, direct way.
- debate: body is the claim; explanation (max 200 chars) gives the strongest point on each side.
Every post: style is the format id you were asked for; evidence is the exact supporting sentence(s). Always include every field.''';
