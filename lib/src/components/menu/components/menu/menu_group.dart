part of '../../menu.dart';

/// 菜单分组
class _TMenuGroup<T> extends StatelessWidget {
  const _TMenuGroup({
    super.key,
    required this.props,
  });

  /// 布局属性
  final _TMenuItemLayoutProps<T> props;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var layoutProps = props;
    var menuProps = layoutProps.currentProps as TMenuGroupProps<T>;
    var collapsed = layoutProps.collapsed;
    var itemHeight = 48.0;
    var textColor = layoutProps.theme.isLight ? colorScheme.fontGray3 : colorScheme.fontWhite3;
    var dividerColor = layoutProps.theme.isLight ? colorScheme.gray3 : colorScheme.gray10;

    // 子菜单项
    List<Widget> children = List.generate(menuProps.children.length, (index) {
      var props = menuProps.children[index];
      return _TMenuLayout<T>(
        props: this.props.copyWith(
              parent: this.props,
              level: this.props.level + 1,
              index: index,
              currentProps: props,
              menus: menuProps.children,
            ),
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!collapsed)
          DefaultTextStyle.merge(
            style: TextStyle(
              color: textColor,
              fontSize: theme.fontData.fontSizeBodySmall,
            ),
            child: Container(
              height: itemHeight,
              padding: const EdgeInsets.only(top: 20, right: 16, bottom: 8, left: 16),
              child: menuProps.title,
            ),
          ),
        if (collapsed)
          Container(
            height: itemHeight,
            alignment: Alignment.center,
            child: TDivider(
              layout: Axis.horizontal,
              thickness: 1,
              space: 20,
              color: dividerColor,
            ),
          ),
        ...children,
      ],
    );
  }
}
