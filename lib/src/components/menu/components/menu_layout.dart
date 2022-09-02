part of '../menu.dart';

/// 处理button分配
class _TMenuLayout<T> extends StatelessWidget {
  const _TMenuLayout({
    Key? key,
    required this.props,
  }) : super(key: key);

  /// 布局属性
  final _TMenuItemLayoutProps<T> props;

  @override
  Widget build(BuildContext context) {
    var menuProps = props.currentProps;
    var level = props.level;
    if (menuProps is TMenuItemProps<T>) {
      return _TMenuItem<T>(
        props: props,
      );
    } else if (menuProps is TMenuGroupProps<T>) {
      assert(level == 1);
      return _TMenuGroup<T>(
        props: props,
      );
    } else if (menuProps is TSubMenuProps<T>) {
      return _TSubMenu<T>(
        props: props,
      );
    }
    return Container();
  }
}
