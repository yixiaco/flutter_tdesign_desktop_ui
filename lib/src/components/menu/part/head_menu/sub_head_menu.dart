part of '../../head_menu.dart';

/// 次级菜单
class _TSubHeadMenu<T> extends StatelessWidget {
  const _TSubHeadMenu({
    Key? key,
    required this.props,
  }) : super(key: key);

  /// 布局属性
  final _THeadMenuItemLayoutProps<T> props;

  bool get isPopup => props.expandType == TMenuExpandType.popup;

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}