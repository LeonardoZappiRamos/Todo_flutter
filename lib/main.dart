import 'package:flutter/material.dart';

main() => runApp(Todoapp());

class Todoapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ListScren(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListScren extends StatefulWidget {
  State<StatefulWidget> createState() {
    return new TodoList();
  }
}

class TodoList extends State<ListScren> {
  //List<Tarefa> tarefas = List<Tarefa>();
  final tarefas = [];
  TextEditingController listControle = new TextEditingController();

  void addTarefa(String name) {
    setState(() {
      tarefas.add(name);
    });
    listControle.clear();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("To Do List"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              onSubmitted: addTarefa,
              controller: listControle,
              enabled: true,
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (comtent, indice) {
                    final tarefa = tarefas[indice];
                    return Dismissible(
                      key: Key(tarefa),
                      onDismissed: (direction) {
                        setState(() {
                          tarefas.removeAt(indice);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$tarefa dismissed')));
                      },
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment(-0.9, 0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      child: ListTile(title: Text('$tarefa')),
                    );
                  }))
        ],
      ),
    );
  }
}
