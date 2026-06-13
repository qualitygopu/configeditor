import 'package:flutter/material.dart';

class ScheduleEditor extends StatelessWidget {
  final List<dynamic> tim;
  final VoidCallback refresh;

  const ScheduleEditor({super.key, required this.tim, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Schedule", style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 20),

        _minuteEditor(),

        const SizedBox(height: 20),

        _hourEditor(),

        _dateEditor(),

        _monthEditor(),

        _specialEditor(),

        const SizedBox(height: 20),

        _weekDayEditor(),
      ],
    );
  }

  Widget _minuteEditor() {
    return Row(
      children: [
        const SizedBox(width: 120, child: Text("Minute")),

        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: tim[0][0].toString(),
            onChanged: (v) {
              tim[0][0] = int.tryParse(v) ?? 0;
              refresh();
            },
          ),
        ),
      ],
    );
  }

  Widget _hourEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text("Hour Ranges"),

        const SizedBox(height: 10),

        ...List.generate(tim[1].length, (index) {
          return Row(
            children: [
              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[1][index][0].toString(),

                  onChanged: (v) {
                    tim[1][index][0] = int.tryParse(v) ?? 0;

                    refresh();
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("-"),
              ),

              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[1][index][1].toString(),

                  onChanged: (v) {
                    tim[1][index][1] = int.tryParse(v) ?? 0;

                    refresh();
                  },
                ),
              ),

              IconButton(
                onPressed: () {
                  tim[1].removeAt(index);

                  refresh();
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          );
        }),

        FilledButton.icon(
          onPressed: () {
            tim[1].add([6, 6]);

            refresh();
          },

          icon: const Icon(Icons.add),

          label: const Text("Add Hour"),
        ),
      ],
    );
  }

  Widget _weekDayEditor() {
    const names = {
      1: "Sun",
      2: "Mon",
      3: "Tue",
      4: "Wed",
      5: "Thu",
      6: "Fri",
      7: "Sat",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text("Week Days"),

        Wrap(
          children: [
            for (final day in names.keys)
              SizedBox(
                width: 120,

                child: CheckboxListTile(
                  title: Text(names[day]!),

                  value: tim[4].contains(day),

                  onChanged: (v) {
                    if (v == true) {
                      tim[4].add(day);
                    } else {
                      tim[4].remove(day);
                    }

                    refresh();
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _dateEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text("Date Ranges"),

        ...List.generate(tim[2].length, (index) {
          return Row(
            children: [
              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[2][index][0].toString(),
                  onChanged: (v) {
                    tim[2][index][0] = int.tryParse(v) ?? 1;

                    refresh();
                  },
                ),
              ),

              const Text(" - "),

              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[2][index][1].toString(),

                  onChanged: (v) {
                    tim[2][index][1] = int.tryParse(v) ?? 31;

                    refresh();
                  },
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _monthEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text("Month Ranges"),

        ...List.generate(tim[3].length, (index) {
          return Row(
            children: [
              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[3][index][0].toString(),

                  onChanged: (v) {
                    tim[3][index][0] = int.tryParse(v) ?? 1;

                    refresh();
                  },
                ),
              ),

              const Text(" - "),

              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[3][index][1].toString(),

                  onChanged: (v) {
                    tim[3][index][1] = int.tryParse(v) ?? 12;

                    refresh();
                  },
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _specialEditor() {
    const specialMap = {
      0: "Normal",
      1: "Festival",

      2: "Amavasai",
      3: "Pournami",

      4: "Ekadasi",
      5: "Pradosham",
    };

    return DropdownButton<int>(
      value: tim[5].first,

      items: specialMap.entries.map((e) {
        return DropdownMenuItem(value: e.key, child: Text(e.value));
      }).toList(),

      onChanged: (v) {
        tim[5] = [v];

        refresh();
      },
    );
  }
}
