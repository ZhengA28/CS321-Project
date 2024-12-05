import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utilities/theme_provider.dart';
import 'dart:convert'; //convert data to/from json
import 'package:http/http.dart' as http; //to recieve API requests

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(); //added password field
  String? _errorMessage; //display errors

  /// Login User
  void _loginUser() async{
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      try {
        //send POST request 'login_user'
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/login/'), //Change if needed
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': username, 'password': password}),
        );

        if (response.statusCode == 200) { //successfully sent login info to backend
        final data = jsonDecode(response.body);
        print('Login successful: ${data['message']}'); //change to logging later
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
          ); //navigate to other pages #loggedin
        } else { //login failure
        final data = jsonDecode((response.body));
        setState(() {
          _errorMessage = data['error']; // display retrieved API error
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['error']}')),
        );
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occured. Please try again';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.teal[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Removed profile picture section

                SizedBox(height: 20),

                // Username Field
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                //Passsword Field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock), //lock icon
                  ),
                  obscureText: true, //hide password
                  validator: (value) {
                    if (value == null || value.isEmpty) { 
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                //error : django auth will handle password validity
                if (_errorMessage != null)
                  Text( 
                    _errorMessage!, // throw error from API request
                    style: TextStyle(color: Colors.red),
                  ),
                
                SizedBox(height: 40),

                // Save Button
                ElevatedButton(
                  onPressed: _loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.grey[800] : Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? Colors.white : Colors.black, // Text color based on theme
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}