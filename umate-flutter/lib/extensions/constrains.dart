import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum Breakpoint {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl;

  bool operator <=(Breakpoint other) => index <= other.index;
  bool operator <(Breakpoint other) => index < other.index;
  bool operator >(Breakpoint other) => index > other.index;
  bool operator >=(Breakpoint other) => index >= other.index;
}

extension SliverBreakpoints on SliverConstraints {
  bool get isXs => crossAxisExtent <= Breakpoints.xs;
  bool get isSm =>
      crossAxisExtent > Breakpoints.xs && crossAxisExtent <= Breakpoints.sm;
  bool get isMd =>
      crossAxisExtent > Breakpoints.sm && crossAxisExtent <= Breakpoints.md;
  bool get isLg =>
      crossAxisExtent > Breakpoints.md && crossAxisExtent <= Breakpoints.lg;
  bool get isXl =>
      crossAxisExtent > Breakpoints.lg && crossAxisExtent <= Breakpoints.xl;
  bool get is2Xl => crossAxisExtent > Breakpoints.xl;

  Breakpoint get breakpoint {
    if (isXs) return Breakpoint.xs;
    if (isSm) return Breakpoint.sm;
    if (isMd) return Breakpoint.md;
    if (isLg) return Breakpoint.lg;
    if (isXl) return Breakpoint.xl;
    return Breakpoint.xxl;
  }

  bool get smAndUp => isSm || isMd || isLg || isXl || is2Xl;
  bool get mdAndUp => isMd || isLg || isXl || is2Xl;
  bool get lgAndUp => isLg || isXl || is2Xl;
  bool get xlAndUp => isXl || is2Xl;

  bool get smAndDown => isXs || isSm;
  bool get mdAndDown => isXs || isSm || isMd;
  bool get lgAndDown => isXs || isSm || isMd || isLg;
  bool get xlAndDown => isXs || isSm || isMd || isLg || isXl;
}

// ignore: constant_identifier_names
const Breakpoints = (
  xs: 480.0,
  sm: 640.0,
  md: 820.0,
  lg: 1024.0,
  xl: 1280.0,
);

extension ScreenBreakpoints on MediaQueryData {
  bool get isXs => size.width <= Breakpoints.xs;
  bool get isSm => size.width > Breakpoints.xs && size.width <= Breakpoints.sm;
  bool get isMd => size.width > Breakpoints.sm && size.width <= Breakpoints.md;
  bool get isLg => size.width > Breakpoints.md && size.width <= Breakpoints.lg;
  bool get isXl => size.width > Breakpoints.lg && size.width <= Breakpoints.xl;
  bool get is2Xl => size.width > Breakpoints.xl;

  bool get smAndUp => isSm || isMd || isLg || isXl || is2Xl;
  bool get mdAndUp => isMd || isLg || isXl || is2Xl;
  bool get lgAndUp => isLg || isXl || is2Xl;
  bool get xlAndUp => isXl || is2Xl;

  bool get smAndDown => isXs || isSm;
  bool get mdAndDown => isXs || isSm || isMd;
  bool get lgAndDown => isXs || isSm || isMd || isLg;
  bool get xlAndDown => isXs || isSm || isMd || isLg || isXl;
}
