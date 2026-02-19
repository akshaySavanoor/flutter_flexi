import 'package:flutter/widgets.dart';

/// A responsive grid that automatically adjusts the number of columns based on available width.
///
/// [FlexiGrid] maintains a consistent grid layout and respects [childAspectRatio]
/// across all parent constraints, including dialogs and scroll views.
///
/// **Note**: [FlexiGrid] is recommended for small-to-medium item counts. For large,
/// scroll-heavy grids, prefer a sliver-based implementation to leverage lazy loading.
class FlexiGrid extends StatelessWidget {
  final double minItemWidth;
  final double spacing;
  final List<Widget> children;
  final double childAspectRatio;

  const FlexiGrid({
    super.key,
    required this.minItemWidth,
    this.spacing = 0.0,
    this.childAspectRatio = 1.0,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        int crossAxisCount = (width / minItemWidth).floor();
        if (crossAxisCount < 1) crossAxisCount = 1;

        final grid = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );

        // If parent width was infinite, we must constrain the child to our
        // safeWidth so GridView can calculate its item sizes.
        return constraints.maxWidth.isFinite
            ? grid
            : SizedBox(width: width, child: grid);
      },
    );
  }
}
