import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String _nameError = '';
  String _lastNameError = '';
  String _phoneError = '';

  void _validateForm() {
    setState(() {
      _nameError = _validateName(_nameController.text);
      _lastNameError = _validateName(_lastNameController.text);
      _phoneError = _validatePhone(_phoneController.text);
    });

    if (_formKey.currentState!.validate() &&
        _nameError == 'correct' &&
        _lastNameError == 'correct' &&
        _phoneError == 'correct') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Result'),
            content: Text('Pass'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Result'),
            content: Text('Not pass'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'must input';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'incorrect';
    }
    return 'correct';
  }

  String _validatePhone(String value) {
    if (value.isEmpty) {
      return 'must input';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'incorrect';
    }
    return 'correct';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  errorText: _nameError == 'must input' || _nameError == 'incorrect' ? _nameError : null,
                ),
              ),
              Text(_nameError == 'correct' ? 'correct' : ''),
              SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  errorText: _lastNameError == 'must input' || _lastNameError == 'incorrect' ? _lastNameError : null,
                ),
              ),
              Text(_lastNameError == 'correct' ? 'correct' : ''),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  errorText: _addressController.text.isEmpty ? 'must input' : null,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'ex.0901234567',
                  errorText: _phoneError == 'must input' || _phoneError == 'incorrect' ? _phoneError : null,
                ),
              ),
              Text(_phoneError == 'correct' ? 'correct' : ''),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailController.text.isEmpty ? 'must input' : null,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _validateForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}