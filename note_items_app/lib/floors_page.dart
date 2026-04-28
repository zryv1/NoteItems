import 'package:flutter/material.dart';
import 'package:note_items/projects_storage.dart';
import 'models/project_model.dart';
import 'models/floor_model.dart';

class FloorsPage extends StatefulWidget {
  const FloorsPage({super.key, required this.title});
  final String title;

  @override
  State<FloorsPage> createState() => _FloorsPageState();
}

class _FloorsPageState extends State<FloorsPage> {

  final projectsStorage = ProjectsStorage();
  late Project _project;
  late List<Widget> floorsAsButtonList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _project = ModalRoute.of(context)!.settings.arguments as Project;
  }

  Floor _createFloor(String floorNumber) {
    final Floor floor = this.projectsStorage.createFloor(floorNumber);
    return floor;
  }

  void _addFloorToProject(Floor floor) {
    this.projectsStorage.addFloorToProject(floor, _project.id);
  }

  void _deleteFloorFromProject(Floor floor) {
    this.projectsStorage.deleteFloorFromProject(floor, _project.id);
  }

  AlertDialog _getFloorCreationWindow(BuildContext context) {
    final controller = TextEditingController();
    final alertDialog = AlertDialog(
      title: Text("Новый этаж"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Номер этажа",
          border: UnderlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Создать"),
          onPressed: () {
            final floorNumber = controller.text;
            final floor = _createFloor(floorNumber);
            _addFloorToProject(floor);
            Navigator.pop(context);
            setState(() {});
          },
        ),
        TextButton(
          child: Text("Отмена"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    return alertDialog;
  }

  void openFloorCreationWindow() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _getFloorCreationWindow(context),
    );
  }

  List<Widget> getNewFloorsAsButtonList() {
    final Map<String, Floor> floorsAsMap = projectsStorage.getFloors(_project.id);
    final List<Widget> floorsAsButtonList = [];
    for (var floor in floorsAsMap.values) {
      final key = UniqueKey();
      final button = Material(
        key: key,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "/floors", arguments: floor);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text("${floor.number}"),
                ),
                IconButton(
                  onPressed: () {
                    _deleteFloorFromProject(floor);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      );
      floorsAsButtonList.add(button);
    }
    return floorsAsButtonList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> floorsAsButtonList = getNewFloorsAsButtonList();
    return Scaffold(
      appBar: AppBar(
        title: Text(_project.name),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: openFloorCreationWindow,
            child: Text("Добавить этаж"),
          ),
          Expanded(
            child: ListView(
              children: floorsAsButtonList,
            ),
          ),
        ],
      ),
    );
  }
}
