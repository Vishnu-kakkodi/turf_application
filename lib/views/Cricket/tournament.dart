
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/Cricket/models/tournament_model.dart';
import 'package:booking_application/views/Cricket/providers/tournament_provider.dart';
import 'package:booking_application/provider/LocationProvider/location_provider.dart';
import 'package:booking_application/views/Cricket/views/tournament_detail_sccreen.dart';
import 'package:booking_application/views/LocationScreen/location_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TournamentHomeScreen extends StatefulWidget {
  @override
  _TournamentHomeScreenState createState() => _TournamentHomeScreenState();
}

class _TournamentHomeScreenState extends State<TournamentHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch tournaments when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TournamentNewProvider>(context, listen: false).fetchTournaments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Create Tournaments',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Create teams, schedule matches, and track scores live.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tournaments',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Replace 'YOUR_USER_ID' with actual user ID from your auth system
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateTournamentScreen(
                          ),
                        ),
                      ).then((_) {
                        // Refresh tournaments after returning
                        Provider.of<TournamentNewProvider>(context, listen: false)
                            .fetchTournaments();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Create Tournament',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              
              Expanded(
                child: Consumer<TournamentNewProvider>(
                  builder: (context, tournamentProvider, child) {
                    if (tournamentProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                        ),
                      );
                    }

                    if (tournamentProvider.errorMessage.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              tournamentProvider.errorMessage,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                tournamentProvider.fetchTournaments();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D32),
                              ),
                              child: const Text(
                                'Retry',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: const Color(0xFF2E7D32),
                      onRefresh: () => tournamentProvider.fetchTournaments(),
                      child: ListView(
                        children: [
                          _buildTournamentSection(
                            title: 'Registration Open',
                            color: const Color(0xFFFF9800),
                            tournaments: tournamentProvider.registrationOpenTournaments,
                            emptyText: 'No upcoming tournaments.',
                            context: context,
                          ),
                          const SizedBox(height: 30),
                          
                          _buildTournamentSection(
                            title: 'Live',
                            color: const Color(0xFFFF6B6B),
                            tournaments: tournamentProvider.liveTournaments,
                            emptyText: 'No live tournaments currently.',
                            context: context,
                          ),
                          const SizedBox(height: 30),
                          
                          _buildTournamentSection(
                            title: 'Completed',
                            color: const Color(0xFF666666),
                            tournaments: tournamentProvider.completedTournaments,
                            emptyText: 'No completed tournaments.',
                            context: context,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F5),
                    foregroundColor: const Color(0xFF333333),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentSection({
    required String title,
    required Color color,
    required List<Tournament> tournaments,
    required String emptyText,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        
        if (tournaments.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              emptyText,
              style: const TextStyle(color: Color(0xFF666666)),
            ),
          )
        else
          Column(
            children: tournaments.map((tournament) => _buildTournamentCard(tournament, context)).toList(),
          ),
      ],
    );
  }

  Widget _buildTournamentCard(Tournament tournament, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TournamentDetailScreen(tournament: tournament),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tournament.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(tournament.tournamentStatus),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _getStatusText(tournament.tournamentStatus),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              tournament.description,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Color(0xFF666666)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    tournament.locationName,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.date_range, size: 16, color: Color(0xFF666666)),
                const SizedBox(width: 4),
                Text(
                  '${_formatDate(tournament.startDate)} - ${_formatDate(tournament.endDate)}',
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.registrationOpen:
        return const Color(0xFFFF9800);
      case TournamentStatus.live:
        return const Color(0xFFFF6B6B);
      case TournamentStatus.completed:
        return const Color(0xFF666666);
    }
  }

  String _getStatusText(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.registrationOpen:
        return 'Registration Open';
      case TournamentStatus.live:
        return 'Live';
      case TournamentStatus.completed:
        return 'Completed';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
}




class CreateTournamentScreen extends StatefulWidget {

  const CreateTournamentScreen({Key? key}) : super(key: key);

  @override
  _CreateTournamentScreenState createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberOfTeamsController = TextEditingController(text: '8');
  final TextEditingController _rulesController = TextEditingController();
  final TextEditingController _prizesController = TextEditingController();
  final TextEditingController _entryFeeController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _registrationEndDate;
  String _format = 'Test';
  bool _isPaidEntry = false;

  final List<String> _formatOptions = [
    'Test',
    'T20',
    'T10',
    'ODI',
  ];

     String? userId; // Pass userId from login or previous screen


  @override
  void initState() {
    super.initState();
        _loadUserId();

    // Load location from provider when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLocationFromProvider();
    });
  }

      void _loadUserId() async {
    final user = await UserPreferences.getUser();
    if (user != null) {
      userId = user.id;
    } 
  }

  void _loadLocationFromProvider() {
    final locationProvider = Provider.of<LocationFetchProvider>(context, listen: false);
    if (locationProvider.hasLocation && locationProvider.coordinates != null) {
      setState(() {
        _locationController.text = locationProvider.address;
        _latController.text = locationProvider.coordinates![0].toString();
        _lngController.text = locationProvider.coordinates![1].toString();
      });
    }
  }

  Future<void> _navigateToLocationSearch() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationSearchScreen(userId:userId),
      ),
    );

    // If location was updated (result == true), refresh the location data
    if (result == true && mounted) {
      _loadLocationFromProvider();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location updated successfully!'),
          backgroundColor: Color(0xFF2E7D32),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create New Tournament',
          style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildLabel('Tournament Name *'),
            _buildTextField(
              controller: _nameController,
              hintText: 'Enter tournament name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter tournament name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            _buildLabel('Description *'),
            _buildTextField(
              controller: _descriptionController,
              hintText: 'Enter tournament description',
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter tournament description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Start Date *'),
                      _buildDateField(
                        date: _startDate,
                        onTap: () => _selectDate(context, true),
                        hintText: 'dd-mm-yyyy',
                      ),
                      if (_startDate == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Please select start date',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('End Date *'),
                      _buildDateField(
                        date: _endDate,
                        onTap: () => _selectDate(context, false),
                        hintText: 'dd-mm-yyyy',
                      ),
                      if (_endDate == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Please select end date',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Registration End Date *'),
                      _buildDateField(
                        date: _registrationEndDate,
                        onTap: () => _selectRegistrationEndDate(context),
                        hintText: 'dd-mm-yyyy',
                      ),
                      if (_registrationEndDate == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Please select registration end date',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            _buildLabel('Location Name *'),
            GestureDetector(
              onTap: _navigateToLocationSearch,
              child: AbsorbPointer(
                child: _buildTextField(
                  controller: _locationController,
                  hintText: 'Tap to select tournament location',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select tournament location';
                    }
                    return null;
                  },
                  suffixIcon: const Icon(
                    Icons.location_on,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Consumer<LocationFetchProvider>(
              builder: (context, locationProvider, child) {
                if (locationProvider.hasLocation && locationProvider.coordinates != null) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF2E7D32),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Location set: ${locationProvider.address}',
                            style: const TextStyle(
                              color: Color(0xFF2E7D32),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: _navigateToLocationSearch,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Number of Teams *'),
                      _buildTextField(
                        controller: _numberOfTeamsController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of teams';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          if (int.parse(value) < 2) {
                            return 'Minimum 2 teams required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Format *'),
                      _buildDropdown(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            _buildLabel('Tournament Type *'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTypeButton(
                    text: 'Free Entry',
                    isSelected: !_isPaidEntry,
                    onPressed: () => setState(() => _isPaidEntry = false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTypeButton(
                    text: 'Paid Entry',
                    isSelected: _isPaidEntry,
                    onPressed: () => setState(() => _isPaidEntry = true),
                  ),
                ),
              ],
            ),
            
            if (_isPaidEntry) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Entry Fee (₹) *'),
                    _buildTextField(
                      controller: _entryFeeController,
                      hintText: 'Enter entry fee amount',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (_isPaidEntry && (value == null || value.isEmpty)) {
                          return 'Please enter entry fee';
                        }
                        if (_isPaidEntry && double.tryParse(value!) == null) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            
            _buildLabel('Rules'),
            _buildTextField(
              controller: _rulesController,
              hintText: 'Enter tournament rules and regulations...',
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            
            _buildLabel('Prizes'),
            _buildTextField(
              controller: _prizesController,
              hintText: 'Describe winner/runner-up prizes, awards, etc...',
              maxLines: 2,
            ),
            const SizedBox(height: 30),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      foregroundColor: const Color(0xFF333333),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _createTournament,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Create Tournament',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Color(0xFF333333)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF999999)),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildDateField({
    required DateTime? date,
    required VoidCallback onTap,
    required String hintText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null
                  ? '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}'
                  : hintText,
              style: TextStyle(
                color: date != null ? const Color(0xFF333333) : const Color(0xFF999999),
              ),
            ),
            const Icon(Icons.calendar_today, color: Color(0xFF666666), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButton<String>(
        value: _format,
        isExpanded: true,
        underline: Container(),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Color(0xFF333333)),
        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF666666)),
        items: _formatOptions.map((String format) {
          return DropdownMenuItem<String>(
            value: format,
            child: Text(format),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _format = newValue;
            });
          }
        },
      ),
    );
  }

  Widget _buildTypeButton({
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFF5F5F5),
        foregroundColor: isSelected ? Colors.white : const Color(0xFF666666),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2E7D32),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF333333),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectRegistrationEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2E7D32),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF333333),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _registrationEndDate = picked;
      });
    }
  }

  void _createTournament() async {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null || _registrationEndDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select all required dates'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_endDate!.isBefore(_startDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('End date cannot be before start date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_registrationEndDate!.isAfter(_startDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration end date cannot be after tournament start date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Get coordinates from provider
      final locationProvider = Provider.of<LocationFetchProvider>(context, listen: false);
      double latitude = 19.0760;
      double longitude = 72.8777;

      if (locationProvider.hasLocation && locationProvider.coordinates != null) {
        latitude = locationProvider.coordinates![0];
        longitude = locationProvider.coordinates![1];
      } else if (_latController.text.isNotEmpty && _lngController.text.isNotEmpty) {
        latitude = double.tryParse(_latController.text) ?? 19.0760;
        longitude = double.tryParse(_lngController.text) ?? 72.8777;
      }

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
          ),
        ),
      );

      final tournamentProvider = Provider.of<TournamentNewProvider>(context, listen: false);
      
      final success = await tournamentProvider.createTournament(
        userId: userId.toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        startDate: _startDate!,
        endDate: _endDate!,
        registrationEndDate: _registrationEndDate!,
        lat: latitude,
        lng: longitude,
        numberOfTeams: int.parse(_numberOfTeamsController.text),
        format: _format,
        isPaidEntry: _isPaidEntry,
        entryFee: _isPaidEntry ? double.tryParse(_entryFeeController.text) : null,
        locationName: _locationController.text.trim(),
        rules: _rulesController.text.trim(),
        prizes: _prizesController.text.trim(),
      );

      // Close loading indicator
      Navigator.pop(context);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tournament created successfully!'),
            backgroundColor: Color(0xFF2E7D32),
            duration: Duration(seconds: 2),
          ),
        );
        
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tournamentProvider.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _numberOfTeamsController.dispose();
    _rulesController.dispose();
    _prizesController.dispose();
    _entryFeeController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }
}