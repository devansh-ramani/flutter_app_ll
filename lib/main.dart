import 'package:flutter/material.dart';

void main() {
  runApp(ProgrammingLearningApp());
}

class ProgrammingLearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeMaster',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        secondaryHeaderColor: Colors.amber,
        fontFamily: 'Montserrat',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        secondaryHeaderColor: Colors.amber,
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
      routes: {
        '/language': (context) => LanguageDetailPage(),
        '/lesson': (context) => LessonPage(),
        '/quiz': (context) => QuizPage(),
        '/profile': (context) => ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    DashboardPage(),
    ExplorePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CodeMaster'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CourseSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notifications coming soon!')),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final List<ProgrammingLanguage> languages = [
    ProgrammingLanguage(
      name: "C++",
      icon: Icons.code,
      color: Colors.blue,
      topics: cppTopics,
    ),
    ProgrammingLanguage(
      name: "Java",
      icon: Icons.coffee,
      color: Colors.red,
      topics: javaTopics,
    ),
    ProgrammingLanguage(
      name: "Python",
      icon: Icons.auto_awesome,
      color: Colors.green,
      topics: pythonTopics,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Programmer!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'What would you like to learn today?',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: languages.map((language) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/language',
                            arguments: language,
                          );
                        },
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.only(right: 15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: language.color.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                language.icon,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 15),
                              Text(
                                language.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue Learning',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                ContinueLearningCard(
                  title: 'Python Basics',
                  progress: 0.7,
                  language: 'Python',
                  color: Colors.green,
                ),
                SizedBox(height: 25),
                Text(
                  'Popular Topics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    TopicCard(
                      title: 'Data Structures',
                      icon: Icons.category,
                      color: Colors.orangeAccent,
                    ),
                    TopicCard(
                      title: 'Algorithms',
                      icon: Icons.account_tree,
                      color: Colors.purpleAccent,
                    ),
                    TopicCard(
                      title: 'Object-Oriented',
                      icon: Icons.bubble_chart,
                      color: Colors.blueAccent,
                    ),
                    TopicCard(
                      title: 'Web Development',
                      icon: Icons.web,
                      color: Colors.teal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContinueLearningCard extends StatelessWidget {
  final String title;
  final double progress;
  final String language;
  final Color color;

  const ContinueLearningCard({
    required this.title,
    required this.progress,
    required this.language,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  language,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(progress * 100).toInt()}% Complete',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/lesson');
                },
                icon: Icon(Icons.play_circle_outline),
                label: Text('Continue'),
                style: TextButton.styleFrom(
                  foregroundColor: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const TopicCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening $title topics')),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore Topics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ExploreCategorySelector(),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ExploreTopicCard(
                title: 'Topic ${index + 1}',
                subtitle: 'Learn about important programming concepts',
                difficulty: index % 3 == 0
                    ? 'Beginner'
                    : index % 3 == 1
                        ? 'Intermediate'
                        : 'Advanced',
                lessons: (index + 2) * 2,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ExploreCategorySelector extends StatefulWidget {
  @override
  _ExploreCategorySelectorState createState() => _ExploreCategorySelectorState();
}

class _ExploreCategorySelectorState extends State<ExploreCategorySelector> {
  int _selectedIndex = 0;
  final List<String> categories = ['All', 'C++', 'Java', 'Python', 'Projects'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: _selectedIndex == index
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExploreTopicCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String difficulty;
  final int lessons;

  const ExploreTopicCard({
    required this.title,
    required this.subtitle,
    required this.difficulty,
    required this.lessons,
  });

  Color _getDifficultyColor() {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(subtitle),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      color: _getDifficultyColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '$lessons lessons',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 16),
          onPressed: () {
            Navigator.pushNamed(context, '/lesson');
          },
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              'DR',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Devansh Ramani',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Beginner Programmer',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatCard(
                value: '7',
                label: 'Days Streak',
                icon: Icons.local_fire_department,
                color: Colors.orange,
              ),
              StatCard(
                value: '240',
                label: 'XP Points',
                icon: Icons.star,
                color: Colors.amber,
              ),
              StatCard(
                value: '12',
                label: 'Completed',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ],
          ),
          SizedBox(height: 25),
          Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ProfileMenuItem(
                  title: 'Achievements',
                  icon: Icons.emoji_events,
                  onTap: () {},
                ),
                Divider(height: 1),
                ProfileMenuItem(
                  title: 'Learning History',
                  icon: Icons.history,
                  onTap: () {},
                ),
                Divider(height: 1),
                ProfileMenuItem(
                  title: 'Saved Lessons',
                  icon: Icons.bookmark,
                  onTap: () {},
                ),
                Divider(height: 1),
                ProfileMenuItem(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              // Sign out logic would go here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout functionality to be implemented')),
              );
            },
            child: Text('Log Out'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

class CourseSearchDelegate extends SearchDelegate<String> {
  final List<String> searchResults = [
    'C++ Basics',
    'Python for Beginners',
    'Java OOP Concepts',
    'Data Structures in C++',
    'Python Web Frameworks',
    'Java Collections',
    'Algorithms',
    'Design Patterns',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = searchResults
        .where((result) => result.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = searchResults
        .where((result) => result.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.book),
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class ProgrammingLanguage {
  final String name;
  final IconData icon;
  final Color color;
  final List<Topic> topics;

  ProgrammingLanguage({
    required this.name,
    required this.icon,
    required this.color,
    required this.topics,
  });
}

class Topic {
  final String title;
  final String description;
  final List<Lesson> lessons;
  final String difficulty;

  Topic({
    required this.title,
    required this.description,
    required this.lessons,
    required this.difficulty,
  });
}

class Lesson {
  final String title;
  final String content;
  final List<String> codeExamples;
  final List<Quiz> quizzes;

  Lesson({
    required this.title,
    required this.content,
    required this.codeExamples,
    required this.quizzes,
  });
}

class Quiz {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  Quiz({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

// C++ curriculum
final List<Topic> cppTopics = [
  Topic(
    title: 'C++ Basics',
    description: 'Learn the fundamentals of C++ programming',
    difficulty: 'Beginner',
    lessons: [
      Lesson(
        title: 'Introduction to C++',
        content: 'C++ is a powerful general-purpose programming language. It can be used to develop operating systems, browsers, games, and so on.',
        codeExamples: [
          '#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "Hello World!";\n    return 0;\n}'
        ],
        quizzes: [
          Quiz(
            question: 'What is the correct syntax to output "Hello World" in C++?',
            options: [
              'System.out.println("Hello World");',
              'cout << "Hello World";',
              'print("Hello World");',
              'Console.WriteLine("Hello World");'
            ],
            correctOptionIndex: 1,
          ),
        ],
      ),
      Lesson(
        title: 'Variables and Data Types',
        content: 'Learn about different data types like int, float, char, etc. and how to use variables.',
        codeExamples: [
          'int age = 25;\ndouble salary = 50000.50;\nchar grade = \'A\';\nbool isEmployed = true;'
        ],
        quizzes: [],
      ),
      Lesson(
        title: 'Control Structures',
        content: 'Learn about if-else statements, loops, and switch cases.',
        codeExamples: [
          'if (age >= 18) {\n    cout << "Adult";\n} else {\n    cout << "Minor";\n}'
        ],
        quizzes: [],
      ),
    ],
  ),
  Topic(
    title: 'Object-Oriented Programming in C++',
    description: 'Learn about classes, objects, inheritance, and polymorphism in C++',
    difficulty: 'Intermediate',
    lessons: [
      Lesson(
        title: 'Classes and Objects',
        content: 'Learn how to create and use classes and objects in C++.',
        codeExamples: [
          'class Person {\nprivate:\n    string name;\n    int age;\npublic:\n    void setName(string n) {\n        name = n;\n    }\n};'
        ],
        quizzes: [],
      ),
    ],
  ),
];

// Java curriculum
final List<Topic> javaTopics = [
  Topic(
    title: 'Java Basics',
    description: 'Learn the fundamentals of Java programming',
    difficulty: 'Beginner',
    lessons: [
      Lesson(
        title: 'Introduction to Java',
        content: 'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
        codeExamples: [
          'public class HelloWorld {\n    public static void main(String[] args) {\n        System.out.println("Hello, World!");\n    }\n}'
        ],
        quizzes: [],
      ),
      Lesson(
        title: 'Variables and Data Types',
        content: 'Learn about primitive data types and reference data types in Java.',
        codeExamples: [
          'int age = 25;\ndouble salary = 50000.50;\nchar grade = \'A\';\nboolean isEmployed = true;'
        ],
        quizzes: [],
      ),
    ],
  ),
  Topic(
    title: 'Java OOP Concepts',
    description: 'Learn about object-oriented programming in Java',
    difficulty: 'Intermediate',
    lessons: [
      Lesson(
        title: 'Classes and Objects',
        content: 'Understanding classes and objects is fundamental to Java programming.',
        codeExamples: [
          'public class Car {\n    private String model;\n    private String color;\n    \n    public void setModel(String model) {\n        this.model = model;\n    }\n}'
        ],
        quizzes: [],
      ),
    ],
  ),
];

// Python curriculum
final List<Topic> pythonTopics = [
  Topic(
    title: 'Python Basics',
    description: 'Learn the fundamentals of Python programming',
    difficulty: 'Beginner',
    lessons: [
      Lesson(
        title: 'Introduction to Python',
        content: 'Python is an interpreted, high-level, general-purpose programming language.',
        codeExamples: [
          'print("Hello, World!")'
        ],
        quizzes: [],
      ),
      Lesson(
        title: 'Variables and Data Types',
        content: 'Learn about integers, floats, strings, lists, tuples, and dictionaries in Python.',
        codeExamples: [
          'age = 25\nsalary = 50000.50\nname = "John"\nfruits = ["apple", "banana", "cherry"]\nstudent = {"name": "John", "age": 25}'
        ],
        quizzes: [],
      ),
    ],
  ),
  Topic(
    title: 'Python Advanced Concepts',
    description: 'Learn advanced Python programming concepts',
    difficulty: 'Advanced',
    lessons: [
      Lesson(
        title: 'List Comprehensions',
        content: 'List comprehensions provide a concise way to create lists based on existing lists.',
        codeExamples: [
          'squares = [x**2 for x in range(10)]'
        ],
        quizzes: [],
      ),
    ],
  ),
];

class LanguageDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgrammingLanguage language = ModalRoute.of(context)!.settings.arguments as ProgrammingLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(language.name),
        backgroundColor: language.color,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: language.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    language.icon,
                    size: 60,
                    color: language.color,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          getLanguageDescription(language.name),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Learning Path',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: language.topics.length,
              itemBuilder: (context, index) {
                final topic = language.topics[index];
                return TopicListItem(
                  topic: topic,
                  index: index,
                  color: language.color,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/lesson',
                      arguments: {'topic': topic, 'language': language},
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getLanguageDescription(String name) {
    switch (name) {
      case 'C++':
        return 'A powerful general-purpose programming language used for system development, game engines, and high-performance applications.';
      case 'Java':
        return 'A class-based, object-oriented programming language designed for portability and cross-platform development.';
      case 'Python':
        return 'An interpreted high-level general-purpose programming language known for its readability and versatility.';
      default:
        return 'A programming language for software development.';
    }
  }
}

class TopicListItem extends StatelessWidget {
  final Topic topic;
  final int index;
  final Color color;
  final VoidCallback onTap;

  const TopicListItem({
    required this.topic,
    required this.index,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    topic.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: getDifficultyColor(topic.difficulty).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          topic.difficulty,
                          style: TextStyle(
                            color: getDifficultyColor(topic.difficulty),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${topic.lessons.length} lessons',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}

class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int _currentLessonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    
    if (args == null) {
      // Default dummy lesson
      return Scaffold(
        appBar: AppBar(title: Text('Lesson')),
        body: Center(child: Text('No lesson data available')),
      );
    }
    
    final Topic topic = args['topic'] as Topic;
    final ProgrammingLanguage language = args['language'] as ProgrammingLanguage;
    final Lesson currentLesson = topic.lessons[_currentLessonIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
        backgroundColor: language.color,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            color: language.color.withOpacity(0.1),
            child: Row(
              children: [
                Text(
                  'Lesson ${_currentLessonIndex + 1}/${topic.lessons.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: language.color,
                  ),
                ),
                Spacer(),
                TextButton.icon(
                  onPressed: _currentLessonIndex > 0
                      ? () {
                          setState(() {
                            _currentLessonIndex--;
                          });
                        }
                      : null,
                  icon: Icon(Icons.arrow_back),
                  label: Text('Previous'),
                  style: TextButton.styleFrom(
                    foregroundColor: language.color,
                  ),
                ),
                SizedBox(width: 10),
                TextButton.icon(
                  onPressed: _currentLessonIndex < topic.lessons.length - 1
                      ? () {
                          setState(() {
                            _currentLessonIndex++;
                          });
                        }
                      : null,
                  icon: Icon(Icons.arrow_forward),
                  label: Text('Next'),
                  style: TextButton.styleFrom(
                    foregroundColor: language.color,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentLesson.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    currentLesson.content,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  if (currentLesson.codeExamples.isNotEmpty) ...[
                    Text(
                      'Code Example',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...currentLesson.codeExamples.map((code) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            code,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.green[300],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  SizedBox(height: 30),
                  if (currentLesson.quizzes.isNotEmpty) ...[
                    Text(
                      'Quiz',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...currentLesson.quizzes.map((quiz) {
                      return QuizWidget(quiz: quiz);
                    }).toList(),
                  ],
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _currentLessonIndex < topic.lessons.length - 1
                          ? () {
                              setState(() {
                                _currentLessonIndex++;
                              });
                            }
                          : () {
                              Navigator.pushNamed(context, '/quiz', arguments: {
                                'topic': topic,
                                'language': language,
                              });
                            },
                      child: Text(
                        _currentLessonIndex < topic.lessons.length - 1
                            ? 'Next Lesson'
                            : 'Take Final Quiz',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: language.color,
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizWidget extends StatefulWidget {
  final Quiz quiz;

  const QuizWidget({required this.quiz});

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int? selectedOptionIndex;
  bool hasSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.quiz.question,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          ...List.generate(widget.quiz.options.length, (index) {
            final isCorrect = index == widget.quiz.correctOptionIndex;
            final isSelected = selectedOptionIndex == index;
            
            Color? backgroundColor;
            if (hasSubmitted) {
              if (isCorrect) {
                backgroundColor = Colors.green.withOpacity(0.2);
              } else if (isSelected && !isCorrect) {
                backgroundColor = Colors.red.withOpacity(0.2);
              }
            } else if (isSelected) {
              backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
            }
            
            return GestureDetector(
              onTap: hasSubmitted
                  ? null
                  : () {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                    },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(widget.quiz.options[index]),
                    ),
                    if (hasSubmitted && isCorrect)
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    else if (hasSubmitted && isSelected && !isCorrect)
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 15),
          if (!hasSubmitted)
            Center(
              child: ElevatedButton(
                onPressed: selectedOptionIndex != null
                    ? () {
                        setState(() {
                          hasSubmitted = true;
                        });
                      }
                    : null,
                child: Text('Submit Answer'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 45),
                ),
              ),
            ),
          if (hasSubmitted)
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: selectedOptionIndex == widget.quiz.correctOptionIndex
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    selectedOptionIndex == widget.quiz.correctOptionIndex
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: selectedOptionIndex == widget.quiz.correctOptionIndex
                        ? Colors.green
                        : Colors.red,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selectedOptionIndex == widget.quiz.correctOptionIndex
                          ? 'Correct! Well done.'
                          : 'Incorrect. The correct answer is ${String.fromCharCode(65 + widget.quiz.correctOptionIndex)}.',
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  List<int> userAnswers = [];
  bool quizCompleted = false;

  final List<Quiz> quizQuestions = [
    Quiz(
      question: 'Which programming language is known for its simplicity and readability?',
      options: ['C++', 'Java', 'Python', 'JavaScript'],
      correctOptionIndex: 2,
    ),
    Quiz(
      question: 'Which language is primarily used for Android development?',
      options: ['Swift', 'Java', 'C#', 'PHP'],
      correctOptionIndex: 1,
    ),
    Quiz(
      question: 'What does OOP stand for?',
      options: [
        'Object Oriented Programming',
        'Organized Object Programming',
        'Original Object Protocol',
        'Observed Object Paradigm'
      ],
      correctOptionIndex: 0,
    ),
    Quiz(
      question: 'Which data structure uses LIFO (Last In First Out)?',
      options: ['Queue', 'Stack', 'Array', 'Linked List'],
      correctOptionIndex: 1,
    ),
    Quiz(
      question: 'Which operator is used for pointer declaration in C++?',
      options: ['&', '*', '#', '@'],
      correctOptionIndex: 1,
    ),
  ];

  void answerQuestion(int answerIndex) {
    if (quizCompleted) return;

    setState(() {
      userAnswers.add(answerIndex);
      if (answerIndex == quizQuestions[currentQuestionIndex].correctOptionIndex) {
        correctAnswers++;
      }

      if (currentQuestionIndex < quizQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        quizCompleted = true;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      correctAnswers = 0;
      userAnswers = [];
      quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: quizCompleted
            ? buildQuizResults()
            : buildQuizQuestion(),
      ),
    );
  }

  Widget buildQuizQuestion() {
    final quiz = quizQuestions[currentQuestionIndex];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearProgressIndicator(
          value: (currentQuestionIndex + 1) / quizQuestions.length,
          backgroundColor: Colors.grey.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          minHeight: 10,
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 10),
        Text(
          'Question ${currentQuestionIndex + 1}/${quizQuestions.length}',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          quiz.question,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Expanded(
          child: ListView.builder(
            itemCount: quiz.options.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () => answerQuestion(index),
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + index),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          quiz.options[index],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildQuizResults() {
    final score = (correctAnswers / quizQuestions.length) * 100;
    final Color resultColor = score >= 70 ? Colors.green : (score >= 40 ? Colors.orange : Colors.red);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: resultColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$correctAnswers/${quizQuestions.length}',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Quiz Completed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'You answered $correctAnswers out of ${quizQuestions.length} questions correctly.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            getResultMessage(score),
            style: TextStyle(
              fontSize: 18,
              color: resultColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: restartQuiz,
            child: Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back to Lessons'),
          ),
        ],
      ),
    );
  }

  String getResultMessage(double score) {
    if (score >= 90) return 'Excellent! You mastered this topic!';
    if (score >= 70) return 'Good job! You\'re doing well!';
    if (score >= 50) return 'Not bad, but you need more practice.';
    return 'Keep studying and try again later.';
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _soundEffects = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SettingsSwitchItem(
            title: 'Dark Mode',
            subtitle: 'Enable dark theme for the app',
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
              // In a real app, you would apply the theme change here
            },
            icon: Icons.dark_mode,
          ),
          Divider(),
          SettingsSwitchItem(
            title: 'Notifications',
            subtitle: 'Enable push notifications',
            value: _notifications,
            onChanged: (value) {
              setState(() {
                _notifications = value;
              });
            },
            icon: Icons.notifications,
          ),
          Divider(),
          SettingsSwitchItem(
            title: 'Sound Effects',
            subtitle: 'Play sounds for actions',
            value: _soundEffects,
            onChanged: (value) {
              setState(() {
                _soundEffects = value;
              });
            },
            icon: Icons.volume_up,
          ),
          Divider(),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text('Clear Data'),
            subtitle: Text('Reset all progress and start over'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Clear Data'),
                  content: Text('Are you sure you want to reset all your progress? This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data cleared successfully')),
                        );
                      },
                      child: Text('Clear', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.help_outline,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text('Help & Support'),
            subtitle: Text('Get assistance with the app'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text('About'),
            subtitle: Text('Version 1.0.0'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class SettingsSwitchItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  const SettingsSwitchItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }
}