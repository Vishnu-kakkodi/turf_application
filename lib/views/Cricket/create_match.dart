
import 'package:booking_application/views/Cricket/match_history.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateMatchForm extends StatefulWidget {
  final String userId;
  
  const CreateMatchForm({super.key, required this.userId});

  @override
  State<CreateMatchForm> createState() => _CreateMatchFormState();
}

class _CreateMatchFormState extends State<CreateMatchForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  
  // Controllers
  final _matchNameController = TextEditingController();
  final _matchTypeController = TextEditingController();
  final _maxParticipantsController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // Dropdown values
  String? _selectedCategoryId;
  String? _selectedTournamentId;
  String? _selectedTeam1Id;
  String? _selectedTeam2Id;
  String? _selectedMatchMode;
  
  // Date and Time
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  // Data lists
  List<dynamic> _categories = [];
  List<dynamic> _tournaments = [];
  List<dynamic> _teams = [];
  
  // Loading states
  bool _isLoadingCategories = false;
  bool _isLoadingTournaments = false;
  bool _isLoadingTeams = false;
  bool _isCreatingMatch = false;
  
  final List<String> _matchModes = ['Team', 'Individual', 'Mixed'];
  final List<String> _matchTypes = ['T20', 'ODI', 'Test', 'League', 'Knockout', "Friendly"];

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadTournaments();
  }

  @override
  void dispose() {
    _matchNameController.dispose();
    _matchTypeController.dispose();
    _maxParticipantsController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    try {
      final response = await http.get(Uri.parse('http://31.97.206.144:3081/category/categories'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _categories = data['categories'] ?? [];
        });
      }
    } catch (e) {
      _showSnackBar('Error loading categories: $e', isError: true);
    } finally {
      setState(() => _isLoadingCategories = false);
    }
  }

Future<void> _loadTournaments() async {
  setState(() => _isLoadingTournaments = true);
  try {
    final response = await http.get(
      Uri.parse('http://31.97.206.144:3081/turnament/gettournaments'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] == true && data['tournaments'] != null) {
        setState(() {
          _tournaments = List<Map<String, dynamic>>.from(data['tournaments']);
        });
      } else {
        _showSnackBar('No tournaments found', isError: true);
      }
    } else {
      _showSnackBar('Failed to load tournaments (status: ${response.statusCode})',
          isError: true);
    }
  } catch (e) {
    _showSnackBar('Error loading tournaments: $e', isError: true);
  } finally {
    setState(() => _isLoadingTournaments = false);
  }
}


  Future<void> _loadTeamsForTournament(String tournamentId) async {
    setState(() => _isLoadingTeams = true);
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/users/tournamentsteams/$tournamentId')
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _teams = data['tournament']['teams'] ?? [];
          _selectedTeam1Id = null;
          _selectedTeam2Id = null;
        });
      }
    } catch (e) {
      _showSnackBar('Error loading teams: $e', isError: true);
    } finally {
      setState(() => _isLoadingTeams = false);
    }
  }

  Future<void> _CreateMatchForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (_selectedDate == null || _selectedTime == null) {
      _showSnackBar('Please select date and time', isError: true);
      return;
    }

    setState(() => _isCreatingMatch = true);
    
    try {
      final matchData = {
        'matchName': _matchNameController.text.trim(),
        'categoryId': _selectedCategoryId,
        'matchType': _matchTypeController.text.trim(),
        'tournamentId': _selectedTournamentId,
        'schedule': {
          'date': '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
          'time': '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        },
        'teams': [_selectedTeam1Id, _selectedTeam2Id],
        'maxParticipants': int.parse(_maxParticipantsController.text),
        'location': _locationController.text.trim(),
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text.trim(),
        'matchMode': _selectedMatchMode,
      };

      final response = await http.post(
        Uri.parse('http://31.97.206.144:3081/users/creatematch/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(matchData),
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar('Match created successfully!');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MatchesScreen()));
      } else {
        _showSnackBar('Failed to create match', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error creating match: $e', isError: true);
    } finally {
      setState(() => _isCreatingMatch = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Create Match',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionCard(
                  title: 'Basic Information',
                  icon: Icons.info_outline,
                  children: [
                    _buildTextField(
                      controller: _matchNameController,
                      label: 'Match Name',
                      hint: 'Enter match name',
                      icon: Icons.sports_cricket,
                      validator: (value) => value?.isEmpty == true ? 'Match name is required' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildDropdownField<String>(
                      value: _selectedCategoryId,
                      label: 'Category',
                      hint: 'Select category',
                      icon: Icons.category,
                      items: _categories.map((category) => DropdownMenuItem<String>(
                        value: category['_id'],
                        child: Text(category['name']),
                      )).toList(),
                      onChanged: (value) => setState(() => _selectedCategoryId = value),
                      validator: (value) => value == null ? 'Category is required' : null,
                      isLoading: _isLoadingCategories,
                    ),
                    const SizedBox(height: 20),
                    _buildDropdownField<String>(
                      value: _matchTypeController.text.isEmpty ? null : _matchTypeController.text,
                      label: 'Match Type',
                      hint: 'Select match type',
                      icon: Icons.sports,
                      items: _matchTypes.map((type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      )).toList(),
                      onChanged: (value) => setState(() => _matchTypeController.text = value ?? ''),
                      validator: (value) => value == null ? 'Match type is required' : null,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSectionCard(
                  title: 'Tournament & Teams',
                  icon: Icons.group,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField<String>(
                            value: _selectedTournamentId,
                            label: 'Tournament',
                            hint: 'Select tournament',
                            icon: Icons.emoji_events,
                            items: _tournaments.map((tournament) => DropdownMenuItem<String>(
                              value: tournament['_id'],
                              child: Text(tournament['name']),
                            )).toList(),
                            onChanged: (value) {
                              setState(() => _selectedTournamentId = value);
                              if (value != null) {
                                _loadTeamsForTournament(value);
                              }
                            },
                            validator: (value) => value == null ? 'Tournament is required' : null,
                            isLoading: _isLoadingTournaments,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField<String>(
                            value: _selectedTeam1Id,
                            label: 'Team 1',
                            hint: 'Select first team',
                            icon: Icons.group,
                            items: _teams.map((team) => DropdownMenuItem<String>(
                              value: team['_id'],
                              child: Text(team['teamName']),
                            )).toList(),
                            onChanged: (value) => setState(() => _selectedTeam1Id = value),
                            validator: (value) => value == null ? 'Team 1 is required' : null,
                            isLoading: _isLoadingTeams,
                          ),
                        ),
                      ],
                    ),
                                      Row(
                      children: [
    
                        Expanded(
                          child: _buildDropdownField<String>(
                            value: _selectedTeam2Id,
                            label: 'Team 2',
                            hint: 'Select second team',
                            icon: Icons.group,
                            items: _teams.where((team) => team['_id'] != _selectedTeam1Id).map((team) => DropdownMenuItem<String>(
                              value: team['_id'],
                              child: Text(team['teamName']),
                            )).toList(),
                            onChanged: (value) => setState(() => _selectedTeam2Id = value),
                            validator: (value) => value == null ? 'Team 2 is required' : null,
                            isLoading: _isLoadingTeams,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSectionCard(
                  title: 'Schedule',
                  icon: Icons.schedule,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateTimeField(
                            label: 'Date',
                            value: _selectedDate != null 
                                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                : null,
                            hint: 'Select date',
                            icon: Icons.calendar_today,
                            onTap: _selectDate,
                          ),
                        ),
      
                      ],
                    ),

                                        Row(
                      children: [

                        Expanded(
                          child: _buildDateTimeField(
                            label: 'Time',
                            value: _selectedTime != null 
                                ? _selectedTime!.format(context)
                                : null,
                            hint: 'Select time',
                            icon: Icons.access_time,
                            onTap: _selectTime,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSectionCard(
                  title: 'Match Details',
                  icon: Icons.settings,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _maxParticipantsController,
                            label: 'Max Participants',
                            hint: 'Enter max participants',
                            icon: Icons.people,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty == true) return 'Max participants is required';
                              final num = int.tryParse(value!);
                              if (num == null || num <= 0) return 'Enter valid number';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _priceController,
                            label: 'Price (₹)',
                            hint: 'Enter price',
                            icon: Icons.currency_rupee,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty == true) return 'Price is required';
                              final num = double.tryParse(value!);
                              if (num == null || num < 0) return 'Enter valid price';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _locationController,
                      label: 'Location',
                      hint: 'Enter match location',
                      icon: Icons.location_on,
                      validator: (value) => value?.isEmpty == true ? 'Location is required' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildDropdownField<String>(
                      value: _selectedMatchMode,
                      label: 'Match Mode',
                      hint: 'Select match mode',
                      icon: Icons.sports_motorsports,
                      items: _matchModes.map((mode) => DropdownMenuItem<String>(
                        value: mode,
                        child: Text(mode),
                      )).toList(),
                      onChanged: (value) => setState(() => _selectedMatchMode = value),
                      validator: (value) => value == null ? 'Match mode is required' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      hint: 'Enter match description',
                      icon: Icons.description,
                      maxLines: 3,
                      validator: (value) => value?.isEmpty == true ? 'Description is required' : null,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildCreateButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField<T>({
    required T? value,
    required String label,
    required String hint,
    required IconData icon,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    String? Function(T?)? validator,
    bool isLoading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: isLoading ? null : onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: isLoading 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : Icon(icon, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required String? value,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade50,
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: Colors.grey.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value ?? hint,
                    style: TextStyle(
                      color: value != null ? Colors.black87 : Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: _isCreatingMatch ? null : _CreateMatchForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Theme.of(context).primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isCreatingMatch
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Create Match',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}