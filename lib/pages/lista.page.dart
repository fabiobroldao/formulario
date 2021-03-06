import 'package:flutter/material.dart';
import 'package:formulario/pages/formulario.page.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final List pessoas = <Map<String, String>>[
    {
      'id': '1',
      'nome': 'Edson',
      'email': 'edson@gmail.com',
      'cpf': '000.000.000-00',
      'cep': '00000-000',
      'rua': 'Rua A',
      'numero': '1000',
      'bairro': 'Tijuca',
      'cidade': 'Rio de Janeiro',
      'uf': 'RJ',
      'pais': 'Brasil',
      'bgimg': 'https://robohash.org/1.png',
    },
    {
      'id': '2',
      'nome': 'Gabriel',
      'email': 'gabriel@gmail.com',
      'cpf': '999.000.000-00',
      'cep': '9999-000',
      'rua': 'Rua HH',
      'numero': '10',
      'bairro': 'Chui',
      'cidade': 'Jaguarao',
      'uf': 'RS',
      'pais': 'Brasil',
      'bgimg': 'https://robohash.org/2.png',
    },
    {
      'id': '3',
      'nome': 'Fabio',
      'email': 'fabio@gmail.com',
      'cpf': '001.001.001-00',
      'cep': '00100-010',
      'rua': 'Rua WW',
      'numero': '99',
      'bairro': 'ABCD',
      'cidade': 'EFGHIJKL',
      'uf': 'BZ',
      'pais': 'Brasil',
      'bgimg': 'https://robohash.org/3.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.separated(
      itemCount: pessoas.length,
      itemBuilder: (ctx, index) {
        final pessoa = pessoas[index];
        return Dismissible(
          key: ValueKey(pessoa['id']),
          background: Container(
            color: Colors.red,
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Deletando...',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.archive,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Arquivando...',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          onDismissed: (direction) {
            print('Pessoa deletada!');
          },
          confirmDismiss: (direction) async {
            return true;
          },
          child: ListTile(
            title: Text(pessoas[index]['nome'].toString()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pessoas[index]['email'].toString()),
                Text(pessoas[index]['cpf'].toString()),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(pessoas[index]['bgimg'].toString()),
            ),
            onTap: () {
              Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (_) => Formulario(
                        nome: pessoas[index]['nome'].toString(),
                        email: pessoas[index]['email'].toString(),
                        cpf: pessoas[index]['cpf'].toString(),
                        cep: pessoas[index]['cep'].toString(),
                        rua: pessoas[index]['rua'].toString(),
                        numero: pessoas[index]['numero'].toString(),
                        bairro: pessoas[index]['bairro'].toString(),
                        cidade: pessoas[index]['cidade'].toString(),
                        uf: pessoas[index]['uf'].toString(),
                        pais: pessoas[index]['pais'].toString(),
                        bgimg: pessoas[index]['bgimg'].toString(),
                      )));
            },
            selected: false,
            enabled: true,
            isThreeLine: false,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
