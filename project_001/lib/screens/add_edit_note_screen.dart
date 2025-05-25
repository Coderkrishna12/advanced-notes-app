import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

@RoutePage()
class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen>
    with TickerProviderStateMixin {
  late final FormGroup form;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<CategoryOption> categories = [
    CategoryOption('Work', Icons.work_outline, const Color(0xFF64FFDA)),
    CategoryOption('Personal', Icons.person_outline, const Color(0xFFFF6B9D)),
    CategoryOption('Ideas', Icons.lightbulb_outline, const Color(0xFFFFA726)),
    CategoryOption('Archive', Icons.archive_outlined, const Color(0xFF9C27B0)),
    CategoryOption('Study', Icons.school_outlined, const Color(0xFF42A5F5)),
    CategoryOption('Travel', Icons.flight_outlined, const Color(0xFF26C6DA)),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    form = FormGroup({
      'title': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(100),
        ],
      ),
      'content': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      ),
      'category': FormControl<String>(),
    });

    // Pre-fill form if editing
    if (widget.note != null) {
      form.control('title').value = widget.note!.title;
      form.control('content').value = widget.note!.content;
      form.control('category').value = widget.note!.category;
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.read<NotesProvider>();
    final isEditing = widget.note != null;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0A0A0B),
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E).withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF64FFDA),
                ),
                onPressed: () => context.router.pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                isEditing ? 'Edit Note' : 'Create Note',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1A1A2E),
                      Color(0xFF16213E),
                      Color(0xFF0F3460),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              if (isEditing)
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B9D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Color(0xFFFF6B9D),
                    ),
                    onPressed: () => _showDeleteDialog(context, notesProvider),
                  ),
                ),
            ],
          ),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ReactiveForm(
                  formGroup: form,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Title'),
                        const SizedBox(height: 12),
                        _buildTitleField(),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Content'),
                        const SizedBox(height: 12),
                        _buildContentField(),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Category'),
                        const SizedBox(height: 12),
                        _buildCategorySelector(),
                        const SizedBox(height: 32),
                        _buildSaveButton(notesProvider, isEditing),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTitleField() {
    return ReactiveTextField<String>(
      formControlName: 'title',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: 'Enter note title...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
        ),
        filled: true,
        fillColor: const Color(0xFF1A1A2E).withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF64FFDA),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFFF6B9D),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF64FFDA).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.title,
            color: Color(0xFF64FFDA),
            size: 20,
          ),
        ),
      ),
      validationMessages: {
        ValidationMessage.required: (_) => 'Title is required',
        ValidationMessage.minLength: (_) => 'Must be at least 3 characters',
        ValidationMessage.maxLength: (_) => 'Must not exceed 100 characters',
      },
    );
  }

  Widget _buildContentField() {
    return ReactiveTextField<String>(
      formControlName: 'content',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        height: 1.5,
      ),
      maxLines: 8,
      decoration: InputDecoration(
        hintText: 'Write your note content here...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
        ),
        filled: true,
        fillColor: const Color(0xFF1A1A2E).withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF64FFDA),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFFF6B9D),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
        alignLabelWithHint: true,
      ),
      validationMessages: {
        ValidationMessage.required: (_) => 'Content is required',
        ValidationMessage.minLength: (_) => 'Must be at least 5 characters',
      },
    );
  }

  Widget _buildCategorySelector() {
    return ReactiveValueListenableBuilder<String?>(
      formControlName: 'category',
      builder: (context, control, child) {
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // None option
            _buildCategoryChip(
              'None',
              Icons.clear,
              Colors.grey,
              control.value == null,
              () => control.value = null,
            ),
            // Category options
            ...categories.map((category) => _buildCategoryChip(
                  category.name,
                  category.icon,
                  category.color,
                  control.value == category.name,
                  () => control.value = category.name,
                )),
          ],
        );
      },
    );
  }

  Widget _buildCategoryChip(
    String label,
    IconData icon,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.2)
              : const Color(0xFF1A1A2E).withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.white.withOpacity(0.6),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.white.withOpacity(0.8),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(NotesProvider notesProvider, bool isEditing) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: form.valid
                ? const LinearGradient(
                    colors: [Color(0xFF64FFDA), Color(0xFF1DE9B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: form.valid ? null : const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(16),
            boxShadow: form.valid
                ? [
                    BoxShadow(
                      color: const Color(0xFF64FFDA).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: ElevatedButton(
            onPressed:
                form.valid ? () => _saveNote(notesProvider, isEditing) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isEditing ? Icons.edit : Icons.save,
                  color: form.valid
                      ? const Color(0xFF0A0A0B)
                      : Colors.white.withOpacity(0.4),
                ),
                const SizedBox(width: 8),
                Text(
                  isEditing ? 'Update Note' : 'Save Note',
                  style: TextStyle(
                    color: form.valid
                        ? const Color(0xFF0A0A0B)
                        : Colors.white.withOpacity(0.4),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveNote(NotesProvider notesProvider, bool isEditing) async {
    try {
      final newNote = Note(
        id: widget.note?.id ?? const Uuid().v4(),
        title: form.control('title').value!,
        content: form.control('content').value!,
        category: form.control('category').value,
        createdAt: widget.note?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (isEditing) {
        await notesProvider.updateNote(newNote);
      } else {
        await notesProvider.addNote(newNote);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF64FFDA)),
                const SizedBox(width: 8),
                Text(
                  isEditing
                      ? 'Note updated successfully!'
                      : 'Note saved successfully!',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF1A1A2E),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        context.router.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Color(0xFFFF6B9D)),
                const SizedBox(width: 8),
                Text('Error: $e'),
              ],
            ),
            backgroundColor: const Color(0xFF1A1A2E),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  void _showDeleteDialog(BuildContext context, NotesProvider notesProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Note',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to delete this note? This action cannot be undone.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF64FFDA)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await notesProvider.deleteNote(widget.note!.id);
                  if (mounted) {
                    Navigator.of(context).pop();
                    context.router.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Note deleted successfully'),
                        backgroundColor: Color(0xFF1A1A2E),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error deleting note: $e'),
                        backgroundColor: Color(0xFFFF6B9D),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B9D),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class CategoryOption {
  final String name;
  final IconData icon;
  final Color color;

  CategoryOption(this.name, this.icon, this.color);
}
