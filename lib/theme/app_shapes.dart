import 'package:flutter/material.dart';

/// Class that contains shapes that are used throughout the app.
class AppShapes {
  /// A <code>RoundedRectangleBorder</code> with the corners rounded
  /// by a circular radius of <b>15</b>.
  static const roundedShapeRadius15 = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  );

  /// A <code>RoundedRectangleBorder</code> with the corners rounded
  /// by a circular radius of <b>10</b>.
  static const roundedShapeRadius10 = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  );

  /// A <code>RoundedRectangleBorder</code> with only the top corners rounded
  /// by a circular radius of <b>10</b>.
  static const roundedShapeTopRadius10 = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    ),
  );
}
