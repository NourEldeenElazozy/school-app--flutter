import 'package:flutter/material.dart';

class StudentGradesScreen extends StatelessWidget {
  final String studentName;
  final List<Map<String, dynamic>> grades;

  StudentGradesScreen({required this.studentName, required this.grades});

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var grade in grades) {
      total += int.parse(grade['grade'].toString());
    }

    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          title: Text('درجات الطالب $studentName'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'المواد:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: grades.length,
                  itemBuilder: (BuildContext context, int index) {
                    String subject = grades[index]['subject'];
                    int grade = grades[index]['grade'];
                    int one = grades[index]['one'];
                    int two = grades[index]['two'];
                    double percentage = total > 0 ? (grade / total) * 100 : 0;
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '$subject',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              ' الجزئي $one ',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                            ' النهائي$two ',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'الإجمالي $grade ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),

            ],
          ),
        ),
      ),
    );
  }
}
