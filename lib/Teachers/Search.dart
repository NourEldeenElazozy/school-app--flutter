import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> _searchResults = [];

  TextEditingController _searchController = TextEditingController();

  Future<void> searchUser(String username) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('username', isEqualTo: username)
          .get();

      setState(() {
        _searchResults = snapshot.docs.map((doc) => doc.data()).toList();
      });

      if (_searchResults.isEmpty) {
        print('No matching user found.');
      } else {
        _searchResults.forEach((result) {
          print('Found user: $result');
        });
      }
    } catch (e) {
      print('Error searching for user: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('البحث'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  searchUser(value);
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter username',
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) => Card(
                  child: InkWell(
                    onTap: () {
                      print('Card tapped');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _searchResults[index]['username'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              Icon(Icons.person),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _searchResults[index]['studentName'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الفصل: ${_searchResults[index]['section']['label']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                'العمر: ${_searchResults[index]['age']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'اسم الأب: ${_searchResults[index]['parentName']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                'رقم الهاتف: ${_searchResults[index]['0921234567']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
