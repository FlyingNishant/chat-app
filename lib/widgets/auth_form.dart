import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
  ) submitFn;
  const AuthForm({Key? key, required this.submitFn}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();

  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  bool _isLogin = true;

  // Map<String, String> _userData = {
  //   'email': '',
  //   'username': '',
  //   'password': '',
  // };

  void onSave() {
    if (!_form.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _form.currentState!.save();
    widget.submitFn(
      _userEmail.trim(),
      _userPassword.trim(),
      _userName.trim(),
      _isLogin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'please enter an email address';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _userEmail = newValue!;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.emailAddress,
                    validator: _isLogin
                        ? null
                        : (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'please enter at least 4 characters';
                            }
                            return null;
                          },
                    onSaved: (newValue) {
                      _userName = newValue!;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'please enter a valid password';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _userPassword = newValue!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: onSave,
                  child: Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create a new account'
                      : 'Already have an account'),
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
