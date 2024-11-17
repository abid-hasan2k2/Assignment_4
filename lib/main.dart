import 'package:flutter/material.dart';

// Main function to run the app
void main() {
  runApp(MyApp());
}

// Main app widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Awesome Custom ListView',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CustomListViewPage(),
        '/expandable': (context) => ExpandableListViewPage(),
      },
    );
  }
}

// Page with Custom ListView
class CustomListViewPage extends StatelessWidget {
  // List of items (Products, Services, Places)
  final List<Item> items = List.generate(25, (index) {
    return Item(
      title: 'Item #$index',
      description: 'This is the description for item #$index. Here we describe what this item is about.',
      icon: Icons.star,
      image: NetworkImage('https://picsum.photos/200/200?random=$index'),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom ListView with 25 Items'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CustomListItem(item: items[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Expandable ListView page
          Navigator.pushNamed(context, '/expandable');
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}

// Custom item card widget for each list item
class CustomListItem extends StatelessWidget {
  final Item item;

  CustomListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: item.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(item.icon, color: Colors.indigo, size: 28),
          ],
        ),
      ),
    );
  }
}

// Item model class with data properties
class Item {
  final String title;
  final String description;
  final IconData icon;
  final ImageProvider image;

  Item({
    required this.title,
    required this.description,
    required this.icon,
    required this.image,
  });
}

// Page with Expandable ListView
class ExpandableListViewPage extends StatelessWidget {
  final List<Section> sections = [
    Section('Movies', ['Avengers: Endgame', 'The Dark Knight', 'Inception']),
    Section('Restaurants', ['Pasta House', 'Sushi Master', 'Pizza Planet']),
    Section('Travel Destinations', ['Paris', 'Tokyo', 'New York City']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore More'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        children: sections.map<Widget>((section) {
          return ExpansionTile(
            title: Text(
              section.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.expand_more, color: Colors.deepPurpleAccent),
            children: section.items.map<Widget>((item) {
              return ListTile(
                title: Text(item),
                leading: Icon(Icons.circle, color: Colors.deepPurpleAccent),
              );
            }).toList(),
            tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Custom ListView page
          Navigator.pushNamed(context, '/');
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}

// Section model to hold data for the expandable list
class Section {
  final String title;
  final List<String> items;

  Section(this.title, this.items);
}
