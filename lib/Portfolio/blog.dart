import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BlogPage(),
  ));
}

class BlogPage extends StatelessWidget {
  final List<BlogData> blogs = [
    BlogData(
      title: "History of Flutter",
      description:
          "Flutter is an open-source UI software development kit created by Google.",
      content: [
        "Welcome to my Blog!",
        "Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase. Flutter was first announced in 2015 at the Dart developer summit. It was initially known as 'Sky' and could run on the Android operating system.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Benefits of Cross-Platform Development",
      description:
          "Cross-platform development allows developers to build applications that can run on multiple operating systems using a single codebase.",
      content: [
        "Cross-platform development allows developers to build applications that can run on multiple operating systems using a single codebase. This approach offers several advantages over traditional native development.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Introduction to Dart Programming",
      description:
          "Dart is an open-source, general-purpose programming language developed by Google.",
      content: [
        "Dart is an open-source, general-purpose programming language developed by Google. It is designed for building web, server, and mobile applications.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Building Responsive UI with Flutter",
      description:
          "Flutter is renowned for its ability to build highly responsive user interfaces.",
      content: [
        "Flutter is renowned for its ability to build highly responsive user interfaces. The framework's reactive programming model allows developers to create dynamic and fluid interfaces that respond to user interactions seamlessly.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Exploring Flutter Plugins",
      description:
          "Flutter plugins are essential tools that extend the framework's capabilities by providing access to native platform features and services.",
      content: [
        "Flutter plugins are essential tools that extend the framework's capabilities by providing access to native platform features and services.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "State Management in Flutter",
      description:
          "State management is a crucial aspect of Flutter development.",
      content: [
        "State management is a crucial aspect of Flutter development. It refers to the way the state of an application is managed and updated.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Networking in Flutter",
      description:
          "Learn how to make network requests in Flutter applications.",
      content: [
        "Learn how to make network requests in Flutter applications. Flutter provides several ways to make HTTP requests and handle responses.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Flutter for Web Development",
      description: "Flutter's capabilities extend beyond mobile development.",
      content: [
        "Flutter's capabilities extend beyond mobile development. It can also be used to build web applications with a single codebase.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Testing Flutter Applications",
      description: "Testing is an essential part of the development process.",
      content: [
        "Testing is an essential part of the development process. Flutter provides tools and frameworks to write unit, widget, and integration tests.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Animations in Flutter",
      description:
          "Learn how to create smooth and engaging animations in Flutter.",
      content: [
        "Learn how to create smooth and engaging animations in Flutter. Flutter's animation framework is flexible and powerful.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Understanding Flutter's Widget Tree",
      description:
          "Flutter's widget tree is a powerful concept that helps manage UI.",
      content: [
        "Flutter's widget tree is a powerful concept that helps manage UI. It allows for a hierarchical arrangement of UI elements.",
        // Additional content truncated for brevity
      ],
    ),
    BlogData(
      title: "Flutter for Desktop Development",
      description: "Flutter can also be used to build desktop applications.",
      content: [
        "Flutter can also be used to build desktop applications. Learn how to configure and build for Windows, macOS, and Linux.",
        // Additional content truncated for brevity
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blog",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            return blogEntry(context, blogs[index]);
          },
        ),
      ),
    );
  }

  Widget blogEntry(BuildContext context, BlogData blog) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlueAccent, width: 2),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlogDetailPage(blog: blog)),
                );
              },
              child: Text(
                blog.title,
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 30.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              blog.description,
              style: TextStyle(
                fontFamily: 'Sniglet',
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogDetailPage extends StatelessWidget {
  final BlogData blog;

  BlogDetailPage({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: blog.content
                .map((paragraph) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        paragraph,
                        style: TextStyle(
                          fontFamily: 'Sniglet',
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class BlogData {
  final String title;
  final String description;
  final List<String> content;

  BlogData({
    required this.title,
    required this.description,
    required this.content,
  });
}
