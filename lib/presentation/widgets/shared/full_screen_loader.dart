import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    const messages = <String>[
      'Cargando Peliculas',
      'Comprando Cotufas',
      'Cargando Populares',
      'Ya va....',
      'Como que está tardando mucho...',
    ];
    return Stream.periodic(Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Espere por favor'),
        SizedBox(
          height: 10,
        ),
        CircularProgressIndicator(
          strokeWidth: 2,
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Cargando');
              return Text(snapshot.data ?? 'Cargando');
            })
      ],
    ));
  }
}
