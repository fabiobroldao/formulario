import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

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
  final String? bgimg;
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
      this.pais,
      this.bgimg});

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

  File? _image;
  final picker = ImagePicker();
  final cepController = TextEditingController();
  final ruaController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final ufController = TextEditingController();

  Map<String, dynamic> resultAddress = {};

  bool isLoadingCep = false;

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

  _imgFromCamera() async {
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    final image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  getAddress() async {
    setState(() {
      isLoadingCep = true;
    });
    var cep2 = cepController.text.replaceAll('.', '');
    try {
      var response = await Dio().get('https://viacep.com.br/ws/$cep2/json/');

      setState(() {
        isLoadingCep = false;
        resultAddress = response.data as Map<String, dynamic>;

        cepController.text = resultAddress['cep'];
        ruaController.text = resultAddress['logradouro'];
        bairroController.text = resultAddress['bairro'];
        cidadeController.text = resultAddress['localidade'];
        ufController.text = resultAddress['uf'];
      });
    } catch (e) {
      if (e is DioError) {
        setState(() {
          isLoadingCep = false;
        });
      } else {
        setState(() {
          isLoadingCep = false;
          showSnackBar(
              'O CEP informado não foi localizado! Para continuar com o cadastro, preencha os demais campos manualmente');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    cepController.text = widget.cep!;
    ruaController.text = widget.rua!;
    bairroController.text = widget.bairro!;
    cidadeController.text = widget.cidade!;
    ufController.text = widget.uf!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulário de Cadastro'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: (_image != null)
                      ? Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.network('${widget.bgimg}'),
                )),
          ),
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
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
                                  controller: cepController,
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
                                child: TextButton(
                                  child: isLoadingCep
                                      ? CircularProgressIndicator()
                                      : TextButton.icon(
                                          icon: Icon(Icons.search),
                                          label: Text('Buscar CEP'),
                                          style: TextButton.styleFrom(
                                            primary: Colors.black,
                                          ),
                                          onPressed: isLoadingCep
                                              ? null
                                              : () {
                                                  if (cepController
                                                          .text.length <
                                                      10) return;

                                                  getAddress();
                                                },
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
                                    controller: ruaController,
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
                                  controller: bairroController,
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
                                    controller: cidadeController,
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
                                  controller: ufController,
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
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              child: TextButton(
                  onPressed: () => validaForm(),
                  child: Text('Alterar'),
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(width: 1, color: Colors.red)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 16)))),
            ),
          ),
        ],
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
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 12),
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
