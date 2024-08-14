import 'package:flutter/material.dart';

class TaskPrioritySelector extends StatefulWidget {
  final Function(int) onSave; // Callback to pass the selected priority

  const TaskPrioritySelector({Key? key, required this.onSave}) : super(key: key);

  @override
  _TaskPrioritySelectorState createState() => _TaskPrioritySelectorState();
}

class _TaskPrioritySelectorState extends State<TaskPrioritySelector> {
  int selectedPriority = 1; // Default selected priority

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        "Task Priority",
        style: TextStyle(color: Colors.white),
      ),
      content: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPriority = index + 1;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedPriority == index + 1 ? Colors.purple : Colors.black45,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flag, color: Colors.white),
                    Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(selectedPriority);
            Navigator.of(context).pop();
          },
          child: const Text("Save"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
        ),
      ],
    );
  }
}
