import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  const MainState({
    this.selectedIndex = 0,
    this.showBottomNav = true,
  });

  final int selectedIndex;
  final bool showBottomNav;

  MainState copyWith({
    int? selectedIndex,
    bool? showBottomNav,
  }) {
    return MainState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      showBottomNav: showBottomNav ?? this.showBottomNav,
    );
  }

  @override
  List<Object?> get props => [
        selectedIndex,
        showBottomNav,
      ];
}
