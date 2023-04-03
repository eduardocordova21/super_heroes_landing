import 'package:flutter/material.dart';

class MyException extends StatelessWidget {
  late AsyncSnapshot<dynamic> snapshot;
  late BuildContext contextWidgetToReload;

  MyException({Key? key, required this.snapshot, required this.contextWidgetToReload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Problema encontrado: "),
          Text(snapshot.error.toString()),
          ElevatedButton(
            onPressed: () => {(contextWidgetToReload as Element).reassemble()},
            child: const Text("Recarregar"),
          )
        ],
      ),
    );
    ;
  }
}
