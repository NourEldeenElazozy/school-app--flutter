import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_mobile/Utiils/text_font_family.dart';

class AppStyles {
  static TextStyle textFieldStyle = TextStyle(
    fontFamily: TextFontFamily.KHALED_FONT,
    fontSize: 14,
    color: Colors.black54,
  );
}

class StudentRegistrationScreen extends StatefulWidget {
  @override
  _StudentRegistrationScreenState createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _parentController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  String? _selectedSectionId;
  String? _selectedSectionName;
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _parentController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registration'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'اسم الطالب'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجي إدخال اسم الطالب';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'العمر'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجي إدخال العمر ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'الهاتف'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجي إدخال رقم هاتف ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'المدينة'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجي إدخال مدينة الطالب';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _parentController,
                  decoration: InputDecoration(labelText: "اسم ولي امر"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجي إدخال اسم ولي امر الطالب';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجي إدخال الرقم السري';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: "اسم المستخدم"),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return "يرجي إدخال اسم المستخدم بشكل صحيح";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: AppStyles.textFieldStyle,
                  controller: _idController,
                  decoration: InputDecoration(labelText: "الرقم الوطني"),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 12) {
                      return "يرجي إدخال الرقم الوطني بشكل صحيح";
                    }
                    return null;
                  },
                ),
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('sections')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading...');
                      }

                      // استخراج البيانات من الاستجابة
                      final sections = snapshot.data!.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return {
                          'name': data['name'],
                          'id': doc.id,
                        };
                      }).toList();

                      return Column(
                        children: [
                          DropdownButton<String>(
                            value: _selectedSectionId,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSectionId = newValue;
                                _selectedSectionName = sections.firstWhere((section) => section['id'] == _selectedSectionId)['name'];
                              });
                              print('Selected value: $newValue');
                            },
                            items: sections.map((section) {
                              return DropdownMenuItem<String>(
                                value: section['id'],
                                child: Text(section['name']),
                              );
                            }).toList(),
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24.0,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            isExpanded: true,
                            hint: Text(
                              'Select a section',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Selected section: ${_selectedSectionId != null ? sections.firstWhere((section) => section['id'] == _selectedSectionId)['name'] : "None"}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text(
                    'متابعه',
                    style: AppStyles.textFieldStyle,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final student = {
                        'studentName': _nameController.text,
                        'age': int.parse(_ageController.text),
                        'phone': _phoneController.text,
                        'city': _cityController.text,
                        'parentName': _parentController.text,
                        'idNumber': _idController.text,
                        'password': _passwordController.text,
                        'username': _usernameController.text,
                        'section': {
                          'label': _selectedSectionName,
                          'value': _selectedSectionId,
                        },
                        'status': false,
                      };

                      await FirebaseFirestore.instance
                          .collection('students')
                          .add(student);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
