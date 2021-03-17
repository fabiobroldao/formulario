import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Formulario extends StatefulWidget {
  final List<Map<String, String>>? pessoas;
  final String? nome;
  final String? email;
  final String? cpf;
  final String? cep;
  final String? rua;
  final String? numero;
  final String? bairro;
  final String? cidade;
  final String? uf;
  final String? pais;
  Formulario(
      {this.pessoas,
      this.nome,
      this.email,
      this.cpf,
      this.cep,
      this.rua,
      this.numero,
      this.bairro,
      this.cidade,
      this.uf,
      this.pais});

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  var formKey = GlobalKey<FormState>();

  String? nome;
  String? email;
  String? cpf;
  String? cep;
  String? rua;
  String? numero;
  String? bairro;
  String? cidade;
  String? uf;
  String? pais;

  void validaForm() {
    if (!formKey.currentState!.validate()) {
      showSnackBar(
          'O formulário não foi corretamente preenchido! Revise os campos obrigatórios...');
    } else {
      showInfo();
    }
    formKey.currentState?.save();
  }

  void showInfo() async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Dados cadastrados com sucesso!'),
          contentPadding: EdgeInsets.all(20),
          children: [
            Text('''
Nome Completo:  $nome
E-mail:         $email
CPF:            $cpf
CEP:            $cep
Rua:            $rua
Número:         $numero
Bairro:         $bairro
Cidade:         $cidade
UF:             $uf
Pais:           $pais
            '''),
          ],
        );
      },
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulário de Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildInput(
                      label: 'Nome Completo',
                      valorInicial: widget.nome,
                      textinput: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Não pode ser em branco.';
                        }
                        return null;
                      },
                      onSaved: (value) => nome = value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildInput(
                      label: 'Email',
                      valorInicial: widget.email,
                      textinput: TextInputType.emailAddress,
                      validator: (value) {
                        if (!EmailValidator.validate(value!)) {
                          return 'Precisa ser um e-mail válido';
                        }

                        return null;
                      },
                      onSaved: (value) => email = value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildInput(
                      label: 'CPF',
                      valorInicial: widget.cpf,
                      textinput: TextInputType.number,
                      inputFormater: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                      validator: (value) {
                        if (!UtilBrasilFields.isCPFValido(value!)) {
                          return 'CPF Inválido';
                        }
                        return null;
                      },
                      onSaved: (value) => cpf = value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: buildInput(
                            label: 'CEP',
                            valorInicial: widget.cep,
                            textinput: TextInputType.number,
                            inputFormater: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'O CEP deve ser informado';
                              }

                              return null;
                            },
                            onSaved: (value) => cep = value,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextButton.icon(
                            icon: Icon(Icons.search),
                            label: Text('Buscar CEP'),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            child: buildInput(
                              label: 'Rua',
                              valorInicial: widget.rua,
                              textinput: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Não pode ser em branco.';
                                }
                                return null;
                              },
                              onSaved: (value) => rua = value,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: buildInput(
                              label: 'Número',
                              valorInicial: widget.numero,
                              textinput: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Não pode ser em branco.';
                                }
                                return null;
                              },
                              onSaved: (value) => numero = value,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: buildInput(
                            label: 'Bairro',
                            valorInicial: widget.bairro,
                            textinput: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Não pode ser em branco.';
                              }
                              return null;
                            },
                            onSaved: (value) => bairro = value,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: buildInput(
                              label: 'Cidade',
                              valorInicial: widget.cidade,
                              textinput: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Não pode ser em branco.';
                                }
                                return null;
                              },
                              onSaved: (value) => cidade = value,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: buildInput(
                            label: 'UF',
                            valorInicial: widget.uf,
                            textinput: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Não pode ser em branco.';
                              }
                              return null;
                            },
                            onSaved: (value) => uf = value,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: buildInput(
                              label: 'Pais',
                              valorInicial: widget.pais,
                              textinput: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Não pode ser em branco.';
                                }
                                return null;
                              },
                              onSaved: (value) => pais = value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => validaForm(),
                      child: Text(
                        'Cadastrar',
                      ),
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              BorderSide(width: 1, color: Colors.red)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 16)))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput({
    required String label,
    TextEditingController? controller,
    bool obscureText = false,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    required TextInputType textinput,
    inputFormater,
    String? valorInicial,
  }) {
    return TextFormField(
      initialValue: valorInicial,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormater,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        counterStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      cursorWidth: 4,
      cursorRadius: Radius.circular(10),
      keyboardType: textinput,
    );
  }
}
