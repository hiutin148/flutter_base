enum MovieCategory {
  trending,
  upcoming,
}

extension HomeSectionExtension on MovieCategory {
  String get title {
    switch (this) {
      case MovieCategory.trending:
        return 'Trending';
      case MovieCategory.upcoming:
        return 'Upcoming';
    }
  }

  String get typeName {
    switch (this) {
      case MovieCategory.trending:
        return 'Movies';
      case MovieCategory.upcoming:
        return 'Movies';
    }
  }
}
