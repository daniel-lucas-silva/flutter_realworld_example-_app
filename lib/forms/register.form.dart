import 'package:flutter/material.dart';
import 'package:realworld/blocs/auth.bloc.dart';
import 'package:realworld/components.dart';
import 'package:realworld/utils.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _RegisterModelView _modelView = _RegisterModelView();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode _usernameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  bool _formWasEdited = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onWillPop: () async {
        final FormState form = _formKey.currentState;
        if (form == null || !_formWasEdited || form.validate()) return true;
        return await rwExit(context, "title", "bio");
      },
      key: _formKey,
      onChanged: () {
        _formWasEdited = true;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _usernameField(),
          RwDivider(),
          _emailField(),
          RwDivider(),
          _passwordField(),
          _submitButton(),
        ],
      ),
    );
  }

  _usernameField() {
    return RwInput(
      hint: 'Your username',
      label: 'Username',
      focusNode: _usernameFocus,
      prefixIcon: Icon(Icons.person_outline),
      onEditingComplete: () {
        _usernameFocus.unfocus();
        FocusScope.of(context).requestFocus(_emailFocus);
      },
      validator: (val) {
        _formWasEdited = true;
        return val.isEmpty ? 'Please, type your username' : null;
      },
      onSaved: (val) => _modelView.username = val,
    );
  }

  _emailField() {
    return RwInput(
      hint: 'Your email',
      label: 'Email',
      focusNode: _emailFocus,
      prefixIcon: Icon(Icons.mail_outline),
      onEditingComplete: () {
        _emailFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      validator: (val) {
        _formWasEdited = true;
        return val.isEmpty ? 'Please, type your email' : null;
      },
      onSaved: (val) => _modelView.email = val,
    );
  }

  _passwordField() {
    return RwInput(
      hint: 'Your password',
      label: 'Password',
      obscureText: true,
      focusNode: _passwordFocus,
      prefixIcon: Icon(Icons.lock_outline),
      onEditingComplete: () {
        _passwordFocus.unfocus();
        _onSubmit();
      },
      validator: (val) {
        _formWasEdited = true;
        return val.isEmpty ? 'Please, type your password' : null;
      },
      onSaved: (val) => _modelView.password = val,
    );
  }

  _submitButton() {
    return StreamBuilder(
      stream: authBloc.loading,
      initialData: false,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: RwButton(
            onPressed: _onSubmit,
            title: "Sign In",
            loading: snapshot.data,
          ),
        );
      },
    );
  }

  _onSubmit() async {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please, complete the form."),
        ),
      );
    } else {
      form.save();
      authBloc.register(_modelView.toMap()).then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}

class _RegisterModelView {
  String username;
  String email;
  String password;

  toMap() {
    return {
      "user": {
        "username": this.username,
        "email": this.email,
        "password": this.password,
      }
    };
  }
}
