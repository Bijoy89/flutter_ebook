import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final String initialAudioFilter; // e.g., "All", "<1", "1-2", ">2"

  const FilterPage({super.key, required this.initialAudioFilter});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late String selectedAudioFilter;

  final List<String> audioLengthOptions = [
    'All',
    '<1 Hr',
    '1-2 Hrs',
    '>2 Hrs',
  ];


  @override
  void initState() {
    super.initState();
    selectedAudioFilter = widget.initialAudioFilter;
  }

  void _applyFilters() {
    Navigator.pop(context, selectedAudioFilter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          TextButton(
            onPressed: _applyFilters,
            child: const Text(
              "Apply",
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Audio Length", style: theme.textTheme.titleMedium),
            const SizedBox(height: 10),
            Column(
              children: audioLengthOptions.map((option) {
                return RadioListTile<String>(
                  value: option,
                  groupValue: selectedAudioFilter,
                  title: Text(option),
                  onChanged: (val) {
                    setState(() {
                      selectedAudioFilter = val!;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
