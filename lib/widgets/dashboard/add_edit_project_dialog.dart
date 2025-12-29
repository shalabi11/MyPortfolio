import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_db_model.dart';
import 'package:my_portfolio/services/project_database_service.dart';

class AddEditProjectDialog extends StatefulWidget {
  final ProjectDb? project;
  final Function(ProjectDb) onSave;

  const AddEditProjectDialog({super.key, this.project, required this.onSave});

  @override
  State<AddEditProjectDialog> createState() => _AddEditProjectDialogState();
}

class _AddEditProjectDialogState extends State<AddEditProjectDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _projectUrlController;
  late TextEditingController _galleryUrlController;
  late TextEditingController _appDistributionUrlController;
  late TextEditingController _techController;

  List<String> _selectedTechnologies = [];
  String? _selectedImagePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.project?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.project?.description ?? '',
    );
    _projectUrlController = TextEditingController(
      text: widget.project?.projectUrl ?? '',
    );
    _galleryUrlController = TextEditingController(
      text: widget.project?.galleryUrl ?? '',
    );
    _appDistributionUrlController = TextEditingController(
      text: widget.project?.appDistributionUrl ?? '',
    );
    _techController = TextEditingController();
    _selectedTechnologies = List.from(widget.project?.technologies ?? []);
    _selectedImagePath = widget.project?.localImagePath;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _projectUrlController.dispose();
    _galleryUrlController.dispose();
    _appDistributionUrlController.dispose();
    _techController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null && mounted) {
        setState(() {
          _selectedImagePath = result.files.single.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
  }

  void _addTechnology() {
    final tech = _techController.text.trim();
    if (tech.isNotEmpty && !_selectedTechnologies.contains(tech)) {
      setState(() {
        _selectedTechnologies.add(tech);
        _techController.clear();
      });
    }
  }

  void _removeTechnology(String tech) {
    setState(() {
      _selectedTechnologies.remove(tech);
    });
  }

  bool _validateForm() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter project title')),
      );
      return false;
    }
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter project description')),
      );
      return false;
    }
    if (_projectUrlController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter project URL')));
      return false;
    }
    if (_selectedTechnologies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one technology')),
      );
      return false;
    }
    return true;
  }

  Future<void> _saveProject() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      if (widget.project != null) {
        // Update existing project
        final updated = widget.project!.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          projectUrl: _projectUrlController.text,
          galleryUrl: _galleryUrlController.text.isEmpty
              ? null
              : _galleryUrlController.text,
          appDistributionUrl: _appDistributionUrlController.text.isEmpty
              ? null
              : _appDistributionUrlController.text,
          technologies: _selectedTechnologies,
          localImagePath: _selectedImagePath,
          dateModified: DateTime.now(),
        );
        await ProjectDatabaseService.updateProject(updated);
        if (mounted) {
          widget.onSave(updated);
        }
      } else {
        // Add new project
        final project = await ProjectDatabaseService.addProject(
          title: _titleController.text,
          description: _descriptionController.text,
          projectUrl: _projectUrlController.text,
          galleryUrl: _galleryUrlController.text.isEmpty
              ? null
              : _galleryUrlController.text,
          appDistributionUrl: _appDistributionUrlController.text.isEmpty
              ? null
              : _appDistributionUrlController.text,
          technologies: _selectedTechnologies,
          localImagePath: _selectedImagePath,
        );
        if (mounted) {
          widget.onSave(project);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving project: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  widget.project != null ? 'Edit Project' : 'Add New Project',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Project Title
                _buildTextField(
                  controller: _titleController,
                  label: 'Project Title',
                  hint: 'Enter project title',
                ),
                const SizedBox(height: 16),

                // Project Description
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Enter project description',
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // Project URL
                _buildTextField(
                  controller: _projectUrlController,
                  label: 'Project URL (GitHub/Website)',
                  hint: 'https://github.com/...',
                ),
                const SizedBox(height: 16),

                // Gallery URL
                _buildTextField(
                  controller: _galleryUrlController,
                  label: 'Gallery/Demo URL (Optional)',
                  hint: 'https://...',
                ),
                const SizedBox(height: 16),

                // App Distribution URL
                _buildTextField(
                  controller: _appDistributionUrlController,
                  label: 'App Distribution URL (Optional)',
                  hint: 'https://appdistribution.firebase.dev/...',
                ),
                const SizedBox(height: 16),

                // Image Picker
                OutlinedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Pick Project Image'),
                  onPressed: _pickImage,
                ),
                if (_selectedImagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SelectableText(
                      'Selected: ${_selectedImagePath!.split('/').last}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 16),

                // Technologies
                SelectableText(
                  'Technologies',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _techController,
                        decoration: InputDecoration(
                          hintText: 'Add technology',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        onSubmitted: (_) => _addTechnology(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addTechnology,
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedTechnologies.map((tech) {
                    return Chip(
                      label: Text(tech),
                      onDeleted: () => _removeTechnology(tech),
                      backgroundColor: Colors.blueGrey[700],
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveProject,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(widget.project != null ? 'Update' : 'Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}
