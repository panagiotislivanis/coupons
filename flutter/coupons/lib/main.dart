import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loyalty App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _selectedRole;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_selectedRole == 'Επιχειρηματίας') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BusinessOwnerScreen()),
      );
    } else if (_selectedRole == 'Πελάτης') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Παρακαλώ επιλέξτε ρόλο.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Σύνδεση / Εγγραφή'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Επιλέξτε Ρόλο'),
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
              items: ['Επιχειρηματίας', 'Πελάτης']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Σύνδεση'),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessOwnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Δημιουργία Προσφοράς (Επιχειρηματίας)'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Περιγραφή Προσφοράς'),
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: 'Αριθμός Απαιτούμενων Αγορών'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Λογική για αποθήκευση προσφοράς
              },
              child: Text('Αποθήκευση Προσφοράς'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerScreen extends StatelessWidget {
  final int purchases = 7; // Παράδειγμα για την κάρτα πελάτη

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Κάρτα Πελάτη'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Αγορές: $purchases/10'),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: purchases / 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
