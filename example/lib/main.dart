import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TLayout(
        aside: TAside(color: Colors.blueAccent.withOpacity(0.5), child: const Text('Aside')),
        header: const THeader(child: Text('Header')),
        footer: const TFooter(child: Text('Footer')),
        content: TContent(
          child: TRow(
            gutter: const TGutter.only(xs: 5, sm: 10, md: 15, lg: 20),
            runGutter: const TGutter.all(10),
            children: [
              TCol(
                span: const TSpan.span(3),
                child: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.blue,
                  child: const Text('data'),
                ),
              ),
              TCol(
                span: const TSpan.span(3),
                offset: const TSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data'),
                ),
              ),
              TCol(
                span: const TSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data'),
                ),
              ),
              TCol(
                span: const TSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data'),
                ),
              ),
              TCol(
                span: const TSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
