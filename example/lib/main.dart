import 'package:example/components/button/button_example.dart';
import 'package:example/components/menu/menu_example.dart';
import 'package:example/state/semantics_state.dart';
import 'package:example/state/size_state.dart';
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
    var size = ref.watch(sizeProvider);

    return TTheme(
      data: theme.copyWith(size: size),
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
    var semantics = ref.watch(semanticsProvider);
    var size = ref.watch(sizeProvider);

    Widget child = Scaffold(
      backgroundColor: theme.brightness == Brightness.light ? const Color(0xFFEEEEEE) : Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TLayout(
        aside: TAside(color: Colors.blueAccent.withOpacity(0.5), child: const Text('Aside')),
        header: THeader(
          child: TSingleChildScrollView(
            scrollDirection: Axis.horizontal,
            primary: false,
            child: TSpace(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('主题：'),
                    TButton(
                      onPressed: () => ref.read(themeProvider.notifier).toggle(),
                      child: Text(theme.brightness == Brightness.light ? '亮' : '暗'),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('语义：'),
                    TButton(
                      onPressed: () => ref.read(semanticsProvider.notifier).update((state) => !state),
                      child: Text(semantics ? '显示语义' : '隐藏语义'),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('布局大小：'),
                    TRadioGroup<TComponentSize>(
                      variant: TRadioVariant.defaultFilled,
                      options: [
                        TRadioOption<TComponentSize>(label: const Text('小'), value: TComponentSize.small),
                        TRadioOption<TComponentSize>(label: const Text('中'), value: TComponentSize.medium),
                        TRadioOption<TComponentSize>(label: const Text('大'), value: TComponentSize.large),
                      ],
                      value: size,
                      onChange: (value) => ref.read(sizeProvider.notifier).state = value!,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        footer: const TFooter(child: Text('Footer')),
        content: const TContent(
          child: ButtonExample(),
        ),
      ),
    );
    if (semantics) {
      return SemanticsDebugger(
        child: child,
      );
    }
    return child;
  }
}
