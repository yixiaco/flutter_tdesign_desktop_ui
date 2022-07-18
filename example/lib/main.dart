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
    return TTheme(
      data: TThemeData.light(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
                span: const TColSpan.span(12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      TextButton(onPressed: () {}, child: const Text('TextButton')),
                      OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
                      ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
                    ],
                  ),
                ),
              ),
              TCol(
                span: const TColSpan.span(12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      TButton(onPressed: () {}, enabled: true, child: const Text('填充按钮')),
                      TButton(onPressed: () {}, enabled: true, variant: TButtonVariant.outline, child: const Text('描边按钮')),
                      TButton(onPressed: () {}, enabled: true, variant: TButtonVariant.dashed, child: const Text('虚框按钮')),
                      TButton(onPressed: () {}, enabled: true, variant: TButtonVariant.text, child: const Text('文字按钮')),
                    ],
                  ),
                ),
              ),
              TCol(
                span: const TColSpan.span(12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.primary,
                        child: const Text('填充按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.danger,
                        child: const Text('填充按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.warning,
                        child: const Text('填充按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.success,
                        child: const Text('填充按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.danger,
                        variant: TButtonVariant.outline,
                        child: const Text('描边按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.warning,
                        variant: TButtonVariant.dashed,
                        child: const Text('虚框按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.success,
                        variant: TButtonVariant.text,
                        child: const Text('文字按钮'),
                      ),
                    ],
                  ),
                ),
              ),
              TCol(
                span: const TColSpan.span(12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      TButton(
                        onPressed: () {},
                        enabled: false,
                        themeStyle: TButtonThemeStyle.primary,
                        child: const Text('填充按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: false,
                        themeStyle: TButtonThemeStyle.danger,
                        variant: TButtonVariant.outline,
                        child: const Text('描边按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: false,
                        themeStyle: TButtonThemeStyle.warning,
                        variant: TButtonVariant.dashed,
                        child: const Text('虚框按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: false,
                        themeStyle: TButtonThemeStyle.success,
                        variant: TButtonVariant.text,
                        child: const Text('文字按钮'),
                      ),
                    ],
                  ),
                ),
              ),
              TCol(
                span: const TColSpan.span(12),
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.primary,
                        ghost: true,
                        child: const Text('幽灵按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.danger,
                        variant: TButtonVariant.outline,
                        ghost: true,
                        child: const Text('幽灵按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        themeStyle: TButtonThemeStyle.warning,
                        variant: TButtonVariant.dashed,
                        ghost: true,
                        child: const Text('幽灵按钮'),
                      ),
                      TButton(
                        onPressed: () {},
                        enabled: true,
                        variant: TButtonVariant.text,
                        ghost: true,
                        child: const Text('幽灵按钮'),
                      ),
                    ],
                  ),
                ),
              ),
              TCol(
                span: const TColSpan.span(3),
                offset: const TColSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data2'),
                ),
              ),
              TCol(
                span: const TColSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data3'),
                ),
              ),
              TCol(
                span: const TColSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data4'),
                ),
              ),
              TCol(
                span: const TColSpan.span(3),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text('data5'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
