import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'To do app';

    return MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.pink),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('To Do List'),
          ),
          body: const TodoList(
            todos: [Todo(title: 'Go shopping'), Todo(title: 'return car')],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Add TODO',
            child: const Icon(Icons.add),
          ),
        ));
  }
}

class Todo {
  const Todo({required this.title});

  final String title;
}

typedef TodoCompleteCallback = Function(Todo todo, bool isDone);

class TodoItem extends StatelessWidget {
  TodoItem(
      {Key? key,
      required this.todo,
      required this.isDone,
      required this.onUpdateTodo})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final bool isDone;
  final TodoCompleteCallback onUpdateTodo;

  Color _getColor(BuildContext context) {
    return isDone ? Colors.black : Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          onUpdateTodo(todo, isDone);
        },
        leading: CircleAvatar(
          child: isDone ? const Icon(Icons.done) : const Icon(Icons.circle),
        ),
        title: Text(todo.title));
  }
}

class TodoList extends StatefulWidget {
  const TodoList({required this.todos, Key? key}) : super(key: key);

  final List<Todo> todos;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _todoList = <TodoItem>{};

  void _handleUpdateTodos(TodoItem todo, bool isDone) {
    setState(() {
      if (!isDone) {
        _todoList.add(todo);
      } else {
        _todoList.remove(todo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.todos.map((Todo todo) {
        return TodoItem(
          todo: todo,
          isDone: false,
          onUpdateTodo: (Todo todo, bool isDone) {},
        );
      }).toList(),
    );
  }
}
