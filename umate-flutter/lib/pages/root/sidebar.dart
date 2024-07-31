import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:umate/collections/assets.gen.dart';
import 'package:umate/collections/side_bar_title.dart';
import 'package:umate/controllers/brightness_value.dart';
import 'package:umate/controllers/sidebarx_controller.dart';
import 'package:umate/extensions/constrains.dart';
import 'package:umate/utils/platform.dart';
import 'package:window_manager/window_manager.dart';

class Sidebar extends HookConsumerWidget {
  final Widget child;

  const Sidebar({
    required this.child,
    super.key,
  });
  static Widget brandLogo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Assets.bitdances.image(height: 50),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerState = GoRouterState.of(context);
    final mediaQuery = MediaQuery.of(context);

    final downloadCount = 0;

    final sidebarTileList = useMemoized(
      () => getSideBarTitleList(),
      [],
    );

    final selectedIndex = sidebarTileList.indexWhere(
      (e) => routerState.namedLocation(e.name) == routerState.matchedLocation,
    );

    final controller = useSidebarXController(
      selectedIndex: selectedIndex,
      extended: mediaQuery.lgAndUp,
    );

    final theme = Theme.of(context);
    final bg = theme.colorScheme.surfaceVariant;

    final bgColor = useBrightnessValue(
      Color.lerp(bg, Colors.white, 0.7),
      Color.lerp(bg, const Color.fromARGB(255, 126, 98, 98), 0.45)!,
    );

    useEffect(() {
      if (!context.mounted) return;
      if (mediaQuery.lgAndUp && !controller.extended) {
        controller.setExtended(true);
      } else if (mediaQuery.mdAndDown && controller.extended) {
        controller.setExtended(false);
      }
      return null;
    }, [mediaQuery, controller]);

    useEffect(() {
      if (controller.selectedIndex != selectedIndex) {
        controller.selectIndex(selectedIndex);
      }
      return null;
    }, [selectedIndex]);

    return Row(
      children: [
        SafeArea(
          child: SidebarX(
            controller: controller,
            items: sidebarTileList.mapIndexed(
              (index, e) {
                return SidebarXItem(
                  onTap: () {
                    context.goNamed(e.name);
                  },
                  iconBuilder: (selected, hovered) {
                    return Badge(
                      backgroundColor: theme.colorScheme.primary,
                      isLabelVisible: e.title == "Home" && downloadCount > 0,
                      label: Text(
                        downloadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      child: Icon(
                        e.icon,
                        color: selected || hovered
                            ? theme.colorScheme.primary
                            : null,
                      ),
                    );
                  },
                  label: e.title,
                );
              },
            ).toList(),
            headerBuilder: (_, __) => const SidebarHeader(),
            showToggleButton: false,
            theme: SidebarXTheme(
              width: 50,
              margin: EdgeInsets.only(bottom: 10, top: kIsMacOS ? 35 : 5),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.primary.withOpacity(0.1),
              ),
              selectedIconTheme: IconThemeData(
                color: theme.colorScheme.primary,
              ),
            ),
            extendedTheme: SidebarXTheme(
              width: 250,
              margin: EdgeInsets.only(
                bottom: 10,
                left: 0,
                top: kIsMacOS ? 0 : 5,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: bgColor?.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.primary.withOpacity(0.1),
              ),
              selectedIconTheme: IconThemeData(
                color: theme.colorScheme.primary,
              ),
              selectedTextStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              itemTextPadding: const EdgeInsets.only(left: 10),
              selectedItemTextPadding: const EdgeInsets.only(left: 10),
              hoverTextStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        Expanded(child: child)
      ],
    );
  }
}

class SidebarHeader extends HookWidget {
  const SidebarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    if (mediaQuery.mdAndDown) {
      return Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.only(bottom: 5),
        child: Sidebar.brandLogo(),
      );
    }

    return DragToMoveArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (kIsMacOS) const SizedBox(height: 25),
            Row(
              children: [
                Sidebar.brandLogo(),
                const SizedBox(width: 10),
                Text(
                  "UMate",
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
