import 'package:flutter/material.dart';
import 'tarefa.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'TodoList App', home:  ListaScreen());
  }
}

class ListaScreen extends StatefulWidget {
  const ListaScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return  ListaScreenState();
  }
}

class ListaScreenState extends State<ListaScreen> {
  List<Tarefa> tarefas = [];
  TextEditingController controller =  TextEditingController();

  void adicionaTarefa(String nome) {
    setState(() {
      tarefas.add(Tarefa(nome));
    });

    controller.clear();
  }

  Widget getItem(Tarefa tarefa) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: tarefa.concluida,
          onChanged: (value) {
            setState(() {
              tarefa.concluida = value!;
            });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tarefa.nome,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(tarefa.data.toIso8601String()) // Intl
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Tarefas")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: controller, onSubmitted: adicionaTarefa)),
          Expanded(
              child: ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (_, indice) {
              return getItem(tarefas[indice]);
            },
          ))
        ],
      ),
    );
  }
}
