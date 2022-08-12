import 'package:cost_trip/auth/db_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_exceptions.dart';

enum AuthMode { Signup, Login }

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  final Map<String, String> _authData = {'email': '', 'senha': ''};
  final _controllerText = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  void _showErrorDialog(String erro) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Ocorreu um erro!'),
              content: Text(erro),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fechar'),
                ),
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    _form.currentState!.save();
    DbAuth _auth = Provider.of(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await _auth.login(
            _authData["email"].toString(), _authData["senha"].toString());
      } else {
        await _auth.signUp(
            _authData["email"].toString(), _authData["senha"].toString());
      }
    } on AuthExceptions catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog("Ocorreu um erro inesperado");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: _authMode == AuthMode.Login ? 300 : 380,
        width: 300.0,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _authData['email'] = value!,
                validator: (value) {
                  if (value!.isEmpty || !value.contains("@")) {
                    return "Informe um e-mail válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                controller: _controllerText,
                onSaved: (value) => _authData['senha'] = value!,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return "Informe uma senha válida";
                  }
                  return null;
                },
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Confirmação de senha'),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _controllerText.text) {
                            return "Senhas incompatíveis";
                          }
                          return null;
                        }
                      : null,
                ),
              Spacer(),
              if (_isLoading)
                CircularProgressIndicator()
              else
                FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  //textColor: Theme.of(context).primaryTextTheme.button,
                  child: Text(
                      _authMode == AuthMode.Login ? 'LOGIN' : 'REGISTRAR-SE'),
                  onPressed: _submit,
                ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                    _authMode == AuthMode.Login ? 'REGISTRAR-SE' : 'LOGIN'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
