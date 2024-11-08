import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validation Example',
      home: ValidationFormScreen(),
    );
  }
}

class ValidationFormScreen extends StatefulWidget {
  @override
  _ValidationFormScreenState createState() => _ValidationFormScreenState();
}

class _ValidationFormScreenState extends State<ValidationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for each TextFormField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Validation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'Please enter a valid name.';
                  }
                  return null;
                },
              ),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              // CNIC Field
              TextFormField(
                controller: _cnicController,
                decoration: InputDecoration(labelText: 'CNIC'),
                validator: (value) {
                  if (value == null || value.length != 13 || !RegExp(r'^\d{13}$').hasMatch(value)) {
                    return 'CNIC must be exactly 13 digits.';
                  }
                  return null;
                },
              ),
              // Contact Number Field
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                validator: (value) {
                  if (value == null || !RegExp(r'^\d{10,12}$').hasMatch(value)) {
                    return 'Contact number must be between 10 to 12 digits.';
                  }
                  return null;
                },
              ),
              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address cannot be empty.';
                  }
                  return null;
                },
              ),
              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8 || 
                      !RegExp(r'^(?=.[A-Za-z])(?=.\d)(?=.[@$!%?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
                    return 'Password must be at least 8 characters long and include letters, numbers, and symbols.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                    // Process data here
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources.
    _nameController.dispose();
    _emailController.dispose();
    _cnicController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}