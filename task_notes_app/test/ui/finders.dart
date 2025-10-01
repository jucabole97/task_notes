import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

class Finders {
  static Finder homeFloatingButton = find.byKey(
    WidgetConstants.homeFloatingButton,
  );
  static Finder homeNoteButton = find.byKey(WidgetConstants.homeNoteButton);
  static Finder homeTaskButton = find.byKey(WidgetConstants.homeTaskButton);
  static Finder addItemImageButton = find.byKey(
    WidgetConstants.addItemImageButton,
  );
  static Finder addItemSaveButton = find.byKey(
    WidgetConstants.addItemSaveButton,
  );
  static Finder addItemTitleTextfield = find.byKey(
    WidgetConstants.addItemTitleTextField,
  );
  static Finder addItemContentTextfield = find.byKey(
    WidgetConstants.addItemContentTextField,
  );
  static Finder addNoteBottomSheetTitle = find.text('Agregar Nota');
  static Finder addTaskBottomSheetTitle = find.text('Agregar Tarea');
  static Finder addItemTitleImageModal = find.text('Seleccionar imagen');
}
