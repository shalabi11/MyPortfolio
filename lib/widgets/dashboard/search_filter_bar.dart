import 'package:flutter/material.dart';

class SearchFilterBar extends StatefulWidget {
  final Function(String) onSearch;
  final Function(String?) onTechnologyChanged;
  final List<String> technologies;

  const SearchFilterBar({
    super.key,
    required this.onSearch,
    required this.onTechnologyChanged,
    required this.technologies,
  });

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  late TextEditingController _searchController;
  String? _selectedTechnology;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onSearch('');
  }

  void _clearTechnology() {
    setState(() => _selectedTechnology = null);
    widget.onTechnologyChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search projects by title or description...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearSearch,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white30),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: (value) {
            widget.onSearch(value);
            setState(() {});
          },
        ),
        const SizedBox(height: 16),

        // Technology Filter
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Text(
                  'Filter by Technology:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_selectedTechnology != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(_selectedTechnology!),
                    onDeleted: _clearTechnology,
                    backgroundColor: Colors.blueGrey[700],
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              if (_selectedTechnology == null)
                Chip(
                  label: const Text('All Technologies'),
                  backgroundColor: Colors.blueGrey[900],
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              if (_selectedTechnology == null)
                const SizedBox(width: 8),
              if (_selectedTechnology == null)
                ...widget.technologies
                    .take(5)
                    .map((tech) => Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FilterChip(
                            label: Text(tech),
                            selected: _selectedTechnology == tech,
                            onSelected: (selected) {
                              setState(() {
                                _selectedTechnology = selected ? tech : null;
                              });
                              widget.onTechnologyChanged(
                                selected ? tech : null,
                              );
                            },
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.white30),
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        )),
              if (_selectedTechnology == null && widget.technologies.length > 5)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: PopupMenuButton<String>(
                    child: Chip(
                      label: const Text('More...'),
                      backgroundColor: Colors.blueGrey[700],
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    onSelected: (tech) {
                      setState(() => _selectedTechnology = tech);
                      widget.onTechnologyChanged(tech);
                    },
                    itemBuilder: (BuildContext context) =>
                        widget.technologies.skip(5).map((tech) {
                      return PopupMenuItem(
                        value: tech,
                        child: Text(tech),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
