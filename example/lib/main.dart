import 'package:example/components/space/space_example.dart';
import 'package:example/state/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = ref.watch(themeProvider);

    return TTheme(
      data: theme,
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

class MyHomePage extends StatefulHookConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var theme = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light ? Colors.white : Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TLayout(
        aside: TAside(color: Colors.blueAccent.withOpacity(0.5), child: const Text('Aside')),
        header: THeader(
          child: Row(
            children: [
              TButton(onPressed: () => ref.read(themeProvider.notifier).toggle(), child: Text(theme.brightness == Brightness.light ? '亮' : '暗')),
            ],
          ),
        ),
        footer: const TFooter(child: Text('Footer')),
        content: const TContent(
          child: SpaceExample(),
        ),
      ),
    );
  }
}
