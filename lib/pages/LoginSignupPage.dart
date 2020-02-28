import 'package:flutter/material.dart';
import 'package:fitness_app/backend/Authentication.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => _LoginSignupPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage = '';

  FormMode _formMode = FormMode.LOGIN;

  bool _isIos = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green, //TODO Finalize Color
      ),
      body: Column(
        children: <Widget>[
          formWidget(),
          loginButtonWidget(),
          secondaryButton(),
          errorWidget(),
          progressWidget(),
        ],
      ),
    );
  }

  Widget progressWidget() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _emailWidget(),
          _passwordWidget(),
        ],
      ),
    );
  }

  Widget _emailWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'EMAIL',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'PASSWORD',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget loginButtonWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: MaterialButton(
        elevation: 5.0,
        minWidth: 200.0,
        height: 42.0,
        color: Colors.blue,
        child: _formMode == FormMode.LOGIN
            ? Text(
                'Login',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              )
            : Text(
                'Create account',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
        onPressed: _validateAndSubmit,
      ),
    );
  }

  Widget secondaryButton() {
    return FlatButton(
      child: _formMode == FormMode.LOGIN
          ? Text(
              'Create an account',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
            )
          : Text(
              'Have an account? Sign in',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
            ),
      onPressed: _formMode == FormMode.LOGIN ? showSignupForm : showLoginForm,
    );
  }

  void showSignupForm() {
    _formKey.currentState.reset();
    _errorMessage = '';
    setState(
      () {
        _formMode = FormMode.SIGNUP;
      },
    );
  }

  void showLoginForm() {
    _formKey.currentState.reset();
    _errorMessage = '';
    setState(
      () {
        _formMode = FormMode.LOGIN;
      },
    );
  }

  Widget errorWidget() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _validateAndSubmit() async {
    setState(
      () {
        _errorMessage = '';
        _isLoading = true;
      },
    );
    if (_validateAndSave()) {
      String userId = '';
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
        } else {
          userId = await widget.auth.signUp(_email, _password);
        }
        setState(
          () {
            _isLoading = false;
          },
        );

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();
        }
      } catch (e) {
        setState(
          () {
            _isLoading = false;
            if (_isIos) {
              _errorMessage = e.details;
            } else
              _errorMessage = e.message;
          },
        );
      }
    } else {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }
}
