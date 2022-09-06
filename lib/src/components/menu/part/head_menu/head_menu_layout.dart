part of '../../head_menu.dart';

/// 处理顶部导航button分配
class _THeadMenuLayout<T> extends StatelessWidget {
  const _THeadMenuLayout({
    Key? key,
    required this.props,
  }) : super(key: key);

  /// 布局属性
  final _THeadMenuItemLayoutProps<T> props;

  @override
  Widget build(BuildContext context) {
    var menuProps = props.currentProps;
    assert(menuProps is TMenuItemProps<T> || menuProps is TSubMenuProps<T>);
    if (menuProps is TMenuItemProps<T>) {
      return _THeadMenuItem<T>(
        props: props,
      );
    } else {
      return _TSubHeadMenu<T>(
        props: props,
      );
    }
  }
}
