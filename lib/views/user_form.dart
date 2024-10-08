import 'package:misale/models/user.dart';
import 'package:misale/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id!;
    _formData['name'] = user.name!;
    _formData['email'] = user.email!;
    _formData['avatarUrl'] = user.avatarUrl!;
  }

  @override
  @protected
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)?.settings.arguments as User?;
    if (user != null) {
      _loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            //VALIDAÇÃO CAMPO NOME
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState?.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: 'Nome'),
                  //VALIDADOR CAMPO NOME
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe um novme válido.';
                    }

                    if (value.trim().length < 3) {
                      return 'Informe um nome com no mínimo três letras.';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  onSaved: (value) => _formData['email'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'Url do Avatar'),
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                ),
              ],
            )),
      ),
    );
  }
}
