import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TIconExample extends StatelessWidget {
  const TIconExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var backgroundColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return const Color.fromRGBO(0, 0, 0, 0.05);
      }
    });
    var iconColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return colorScheme.textColorPrimary;
      }
      return colorScheme.textColorPlaceholder;
    });

    return Container(
      color: theme.isLight ? Colors.white : const Color(0xff242424),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
        ),
        itemBuilder: (context, index) {
          return TMaterialStateButton(
            builder: (context, states) {
              var entry = TIcons.allIcons.entries.elementAt(index);
              var icon = entry.value;

              var component = MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TMaterialStateButton(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: entry.key));
                          },
                          builder: (context, states) {
                            return Icon(
                              TIcons.fileCopy,
                              size: 16,
                              color: iconColor.resolve(states),
                            );
                          },
                        ),
                        const TDivider(layout: Axis.vertical, margin: EdgeInsets.symmetric(horizontal: 8)),
                        TMaterialStateButton(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: 'Icon(TIcons.${entry.key})'));
                          },
                          builder: (context, states) {
                            return Icon(
                              TIcons.fileIcon,
                              size: 16,
                              color: iconColor.resolve(states),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(entry.key, style: const TextStyle(fontSize: 12)),
                );
              });

              return Container(
                height: 100,
                decoration: BoxDecoration(
                  color: backgroundColor.resolve(states),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: colorScheme.textColorPrimary,
                      size: 20,
                    ),
                    component.resolve(states),
                  ],
                ),
              );
            },
          );
        },
        itemCount: TIcons.allIcons.length,
      ),
    );
  }
}
