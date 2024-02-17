<p align="center">
  <a href="https://tdesign.tencent.com/" target="_blank">
    <img alt="TDesign Logo" width="200" src="https://tdesign.gtimg.com/site/TDesign.png">
  </a>
</p>

<p align="center">
  <a href="https://github.com/yixiaco/flutter_tdesign_desktop_ui/blob/master/LICENSE">
    <img src="https://img.shields.io/npm/l/tdesign-vue-next.svg?sanitize=true" alt="License">
  </a>
  <a href="https://pub.dev/packages/flutter_tdesign_desktop_ui">
    <img src="https://img.shields.io/badge/pub-v0.0.1-sanitize" alt="Version">
  </a>
</p>

TDesign 适配桌面端的组件库，适合在 Flutter 3.x 技术栈项目中使用。

### 🎉 特性

- 适配桌面端交互
- 基于 Flutter 3.x
- 支持暗黑模式及其他主题定制

### 安装

```yaml
dependencies:
  flutter_tdesign_desktop_ui: ^0.1.0
```

### 基础使用

```dart
void main() {
  // 初始化之前如果访问二进制文件，需要先初始化
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return TTheme(
      child: MaterialApp(
        title: 'TDesign Desktop UI Demo',
        locale: Locale('zh_CN'),
        supportedLocales: GlobalTDesignLocalizations.delegate.supportedLocales,
        localizationsDelegates: const [
          GlobalTDesignLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        home: const MyHomePage(title: 'TDesign Desktop UI Demo Home Page'),
      ),
    );
  }
}
```

### 开源协议

TDesign 遵循 [MIT 协议](https://github.com/yixiaco/flutter_tdesign_desktop_ui/blob/master/LICENSE) 。
