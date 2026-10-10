import '../generated/protocol.dart';

/// A hand-picked starter library across every topic, ingested at first boot
/// so a new user's feed is rich from the first scroll. IDs verified against
/// the Project Gutenberg catalogue.
class SeedBook {
  final int id;
  final String title;
  final String author;
  final List<Topic> topics;
  final String? handle;

  const SeedBook(this.id, this.title, this.author, this.topics, {this.handle});
}

const seedBooks = <SeedBook>[
  // Medicine & health
  SeedBook(12439, 'Notes on Nursing', 'Florence Nightingale', [
    Topic.medicine,
  ], handle: 'NotesOnNursing'),
  SeedBook(
    72583,
    'The Genuine Works of Hippocrates, Vol. 1',
    'Hippocrates',
    [Topic.medicine, Topic.history],
    handle: 'Hippocrates',
  ),
  SeedBook(
    46727,
    'An Epitome of the History of Medicine',
    'Roswell Park',
    [Topic.medicine, Topic.history],
    handle: 'HistoryOfMedicine',
  ),
  SeedBook(77842, 'Microbe Hunters', 'Paul de Kruif', [
    Topic.medicine,
    Topic.science,
    Topic.biography,
  ]),
  SeedBook(60956, 'The Life of Pasteur', 'René Vallery-Radot', [
    Topic.medicine,
    Topic.biography,
  ], handle: 'LifeOfPasteur'),
  SeedBook(
    17921,
    'Manual of Surgery, Vol. 1: General Surgery',
    'Alexis Thomson & Alexander Miles',
    [Topic.medicine],
    handle: 'ManualOfSurgery',
  ),
  SeedBook(10800, 'The Anatomy of Melancholy', 'Robert Burton', [
    Topic.psychology,
    Topic.medicine,
    Topic.literature,
  ]),
  // Law
  SeedBook(
    30802,
    'Commentaries on the Laws of England, Book the First',
    'William Blackstone',
    [Topic.law, Topic.history],
    handle: 'Blackstone',
  ),
  SeedBook(2449, 'The Common Law', 'Oliver Wendell Holmes Jr.', [Topic.law]),
  SeedBook(
    5983,
    'The Institutes of Justinian',
    'Justinian I',
    [Topic.law, Topic.history],
    handle: 'InstitutesOfJustinian',
  ),
  SeedBook(
    1404,
    'The Federalist Papers',
    'Hamilton, Madison & Jay',
    [Topic.law, Topic.politics],
    handle: 'FederalistPapers',
  ),
  SeedBook(7370, 'Second Treatise of Government', 'John Locke', [
    Topic.politics,
    Topic.law,
    Topic.philosophy,
  ], handle: 'SecondTreatise'),
  SeedBook(34901, 'On Liberty', 'John Stuart Mill', [
    Topic.philosophy,
    Topic.politics,
    Topic.law,
  ]),
  // Science, nature & mathematics
  SeedBook(1228, 'On the Origin of Species', 'Charles Darwin', [
    Topic.science,
    Topic.nature,
  ], handle: 'OriginOfSpecies'),
  SeedBook(944, 'The Voyage of the Beagle', 'Charles Darwin', [
    Topic.science,
    Topic.nature,
  ], handle: 'VoyageOfTheBeagle'),
  SeedBook(2300, 'The Descent of Man', 'Charles Darwin', [
    Topic.science,
  ], handle: 'DescentOfMan'),
  SeedBook(
    30155,
    'Relativity: The Special and General Theory',
    'Albert Einstein',
    [Topic.science, Topic.mathematics],
    handle: 'Relativity',
  ),
  SeedBook(33504, 'Opticks', 'Isaac Newton', [Topic.science]),
  SeedBook(30775, 'Elements of Chemistry', 'Antoine Lavoisier', [
    Topic.science,
  ], handle: 'ElementsOfChemistry'),
  SeedBook(67000, "Fabre's Book of Insects", 'Jean-Henri Fabre', [
    Topic.nature,
    Topic.science,
  ], handle: 'FabreInsects'),
  SeedBook(205, 'Walden', 'Henry David Thoreau', [
    Topic.nature,
    Topic.philosophy,
    Topic.literature,
  ]),
  SeedBook(
    16713,
    'Amusements in Mathematics',
    'Henry Ernest Dudeney',
    [Topic.mathematics, Topic.education],
    handle: 'MathAmusements',
  ),
  SeedBook(
    16449,
    'The Number Concept: Its Origin and Development',
    'Levi Leonard Conant',
    [Topic.mathematics, Topic.history],
    handle: 'NumberConcept',
  ),
  SeedBook(97, 'Flatland', 'Edwin A. Abbott', [
    Topic.mathematics,
    Topic.literature,
  ]),
  // Philosophy
  SeedBook(1497, 'The Republic', 'Plato', [
    Topic.philosophy,
    Topic.politics,
  ], handle: 'PlatosRepublic'),
  SeedBook(2680, 'Meditations', 'Marcus Aurelius', [
    Topic.philosophy,
    Topic.selfImprovement,
  ]),
  SeedBook(45109, 'The Enchiridion', 'Epictetus', [
    Topic.philosophy,
    Topic.selfImprovement,
  ]),
  SeedBook(8438, 'The Nicomachean Ethics', 'Aristotle', [
    Topic.philosophy,
  ], handle: 'NicomacheanEthics'),
  SeedBook(4363, 'Beyond Good and Evil', 'Friedrich Nietzsche', [
    Topic.philosophy,
  ]),
  SeedBook(59, 'Discourse on the Method', 'René Descartes', [
    Topic.philosophy,
    Topic.science,
  ], handle: 'DiscourseOnMethod'),
  SeedBook(5827, 'The Problems of Philosophy', 'Bertrand Russell', [
    Topic.philosophy,
  ]),
  SeedBook(11224, 'Utilitarianism', 'John Stuart Mill', [Topic.philosophy]),
  SeedBook(14328, 'The Consolation of Philosophy', 'Boethius', [
    Topic.philosophy,
    Topic.religion,
  ]),
  // Psychology & self-improvement
  SeedBook(
    57628,
    'The Principles of Psychology, Vol. 1',
    'William James',
    [Topic.psychology],
    handle: 'PrinciplesOfPsychology',
  ),
  SeedBook(
    66048,
    'The Interpretation of Dreams',
    'Sigmund Freud',
    [Topic.psychology],
    handle: 'InterpretationOfDreams',
  ),
  SeedBook(2529, 'The Analysis of Mind', 'Bertrand Russell', [
    Topic.psychology,
    Topic.philosophy,
  ]),
  SeedBook(
    621,
    'The Varieties of Religious Experience',
    'William James',
    [Topic.psychology, Topic.religion],
    handle: 'VarietiesOfReligion',
  ),
  SeedBook(4507, 'As a Man Thinketh', 'James Allen', [
    Topic.selfImprovement,
    Topic.psychology,
  ]),
  SeedBook(
    16317,
    'The Art of Public Speaking',
    'J. Berg Esenwein & Dale Carnegie',
    [Topic.selfImprovement, Topic.education],
  ),
  SeedBook(2944, 'Essays: First Series', 'Ralph Waldo Emerson', [
    Topic.selfImprovement,
    Topic.philosophy,
  ], handle: 'EmersonEssays'),
  // Economics, politics & history
  SeedBook(3300, 'The Wealth of Nations', 'Adam Smith', [
    Topic.economics,
  ], handle: 'WealthOfNations'),
  SeedBook(833, 'The Theory of the Leisure Class', 'Thorstein Veblen', [
    Topic.economics,
  ], handle: 'LeisureClass'),
  SeedBook(
    33310,
    'On the Principles of Political Economy and Taxation',
    'David Ricardo',
    [Topic.economics],
    handle: 'RicardoEconomics',
  ),
  SeedBook(61, 'The Communist Manifesto', 'Marx & Engels', [
    Topic.politics,
    Topic.economics,
  ]),
  SeedBook(3207, 'Leviathan', 'Thomas Hobbes', [
    Topic.politics,
    Topic.philosophy,
  ]),
  SeedBook(1232, 'The Prince', 'Niccolò Machiavelli', [
    Topic.politics,
  ], handle: 'ThePrince'),
  SeedBook(
    815,
    'Democracy in America, Vol. 1',
    'Alexis de Tocqueville',
    [Topic.politics, Topic.history],
    handle: 'DemocracyInAmerica',
  ),
  SeedBook(147, 'Common Sense', 'Thomas Paine', [
    Topic.politics,
    Topic.history,
  ]),
  SeedBook(
    7142,
    'The History of the Peloponnesian War',
    'Thucydides',
    [Topic.history],
    handle: 'PeloponnesianWar',
  ),
  SeedBook(
    731,
    'The Decline and Fall of the Roman Empire, Vol. 1',
    'Edward Gibbon',
    [Topic.history],
    handle: 'DeclineAndFall',
  ),
  // Biography
  SeedBook(
    148,
    'The Autobiography of Benjamin Franklin',
    'Benjamin Franklin',
    [Topic.biography, Topic.selfImprovement],
    handle: 'BenFranklin',
  ),
  SeedBook(
    23,
    'Narrative of the Life of Frederick Douglass',
    'Frederick Douglass',
    [Topic.biography, Topic.history],
    handle: 'FrederickDouglass',
  ),
  SeedBook(2376, 'Up from Slavery', 'Booker T. Washington', [
    Topic.biography,
    Topic.education,
  ]),
  SeedBook(
    820,
    'Edison: His Life and Inventions',
    'Frank Lewis Dyer & T. C. Martin',
    [Topic.technology, Topic.biography],
    handle: 'EdisonInventions',
  ),
  // Education & arts
  SeedBook(852, 'Democracy and Education', 'John Dewey', [
    Topic.education,
    Topic.philosophy,
  ]),
  SeedBook(37134, 'The Elements of Style', 'William Strunk Jr.', [
    Topic.education,
    Topic.literature,
  ]),
  SeedBook(
    5321,
    'Concerning the Spiritual in Art',
    'Wassily Kandinsky',
    [Topic.arts],
    handle: 'SpiritualInArt',
  ),
  // Religion & wisdom traditions
  SeedBook(216, 'Tao Te Ching', 'Laozi', [
    Topic.religion,
    Topic.philosophy,
  ], handle: 'TaoTeChing'),
  SeedBook(3330, 'The Analects', 'Confucius', [
    Topic.religion,
    Topic.philosophy,
  ], handle: 'Analects'),
  SeedBook(2388, 'The Bhagavad Gita', 'trans. Edwin Arnold', [
    Topic.religion,
    Topic.poetry,
  ], handle: 'BhagavadGita'),
  SeedBook(
    3296,
    'The Confessions of St. Augustine',
    'Augustine of Hippo',
    [Topic.religion, Topic.biography],
    handle: 'Confessions',
  ),
  // Literature & poetry
  SeedBook(1342, 'Pride and Prejudice', 'Jane Austen', [Topic.literature]),
  SeedBook(84, 'Frankenstein', 'Mary Shelley', [
    Topic.literature,
    Topic.science,
  ]),
  SeedBook(2701, 'Moby-Dick', 'Herman Melville', [
    Topic.literature,
  ], handle: 'MobyDick'),
  SeedBook(2554, 'Crime and Punishment', 'Fyodor Dostoyevsky', [
    Topic.literature,
    Topic.psychology,
  ]),
  SeedBook(
    1661,
    'The Adventures of Sherlock Holmes',
    'Arthur Conan Doyle',
    [Topic.literature],
    handle: 'SherlockHolmes',
  ),
  SeedBook(345, 'Dracula', 'Bram Stoker', [Topic.literature]),
  SeedBook(174, 'The Picture of Dorian Gray', 'Oscar Wilde', [
    Topic.literature,
    Topic.arts,
  ], handle: 'DorianGray'),
  SeedBook(5200, 'Metamorphosis', 'Franz Kafka', [Topic.literature]),
  SeedBook(35, 'The Time Machine', 'H. G. Wells', [
    Topic.literature,
    Topic.science,
  ]),
  SeedBook(
    11,
    "Alice's Adventures in Wonderland",
    'Lewis Carroll',
    [Topic.literature],
    handle: 'AliceInWonderland',
  ),
  SeedBook(1260, 'Jane Eyre', 'Charlotte Brontë', [Topic.literature]),
  SeedBook(1400, 'Great Expectations', 'Charles Dickens', [Topic.literature]),
  SeedBook(1322, 'Leaves of Grass', 'Walt Whitman', [Topic.poetry]),
  SeedBook(1041, "Shakespeare's Sonnets", 'William Shakespeare', [
    Topic.poetry,
  ], handle: 'ShakespeareSonnets'),
  SeedBook(20, 'Paradise Lost', 'John Milton', [Topic.poetry, Topic.religion]),
  SeedBook(1727, 'The Odyssey', 'Homer', [
    Topic.poetry,
    Topic.literature,
  ], handle: 'TheOdyssey'),
  SeedBook(1004, 'The Divine Comedy', 'Dante Alighieri', [
    Topic.poetry,
    Topic.religion,
  ], handle: 'DivineComedy'),
];
