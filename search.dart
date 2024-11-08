import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Fetch and Search Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PostListScreen(),
    );
  }
}

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<dynamic> _posts = [];
  List<dynamic> _filteredPosts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _searchController.addListener(() {
      _filterPosts();
    });
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        _posts = json.decode(response.body);
        _filteredPosts = _posts; // Initially show all posts
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  void _filterPosts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPosts = _posts.where((post) {
        return post['title'].toLowerCase().contains(query) || post['body'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredPosts[index]['title']),
                  subtitle: Text(_filteredPosts[index]['body']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}