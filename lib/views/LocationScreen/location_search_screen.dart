
import 'package:booking_application/provider/LocationProvider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationSearchScreen extends StatefulWidget {
  final String? userId;
  const LocationSearchScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> 
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isLoadingCurrentLocation = false;
  String? userId;
  bool _hasSearchStarted = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadUserData();
    _searchController.addListener(_onSearchChanged);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _focusNode.requestFocus();
        });
      }
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _onSearchChanged() {
    setState(() {
      _hasSearchStarted = _searchController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    print("Loading user data in LocationSearchScreen...");
    try {
      print('Current widget userId: ${widget.userId}');
      userId = "68da44599d96d329b6169526";
      print('StorageHelper userId: $userId');

      if (userId != null) {
        setState(() {
          userId = userId;
        });
      }
    } catch (e) {
      setState(() {
        userId = widget.userId ?? '';
      });

      if (mounted) {
        _showSnackBar('Failed to load user ID: ${e.toString()}', isError: true);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? const Color(0xFFE53E3E) : const Color(0xFF38A169),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  Future<void> _handleCurrentLocation() async {
    setState(() {
      _isLoadingCurrentLocation = true;
    });

    try {
      final locationProvider = Provider.of<LocationFetchProvider>(context, listen: false);
      await locationProvider.initLocation(userId ?? widget.userId.toString());

      if (mounted) {
        if (locationProvider.hasError) {
          _showSnackBar(locationProvider.errorMessage, isError: true);
        } else {
          _showSnackBar('Current location detected successfully!');
          
          await Future.delayed(const Duration(milliseconds: 800));
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar("Failed to get current location: ${e.toString()}", isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCurrentLocation = false;
        });
      }
    }
  }

  Future<void> _handleLocationSelection(Prediction prediction) async {
    try {
      final latStr = prediction.lat ?? '0';
      final lngStr = prediction.lng ?? '0';
      final latitude = double.tryParse(latStr) ?? 0.0;
      final longitude = double.tryParse(lngStr) ?? 0.0;
      final address = prediction.description ?? 'Unknown location';

      if (latitude == 0.0 && longitude == 0.0) {
        throw Exception('Invalid coordinates received');
      }

      if (mounted) {
        final locationProvider = Provider.of<LocationFetchProvider>(context, listen: false);

        List<String> parts = address.split(',');
        String trimmedAddress = parts.length > 1
            ? parts.sublist(0, 2).join(',').trim()
            : address;

        await locationProvider.updateLocation(
          trimmedAddress,
          [latitude, longitude],
          userId ?? widget.userId.toString(),
        );

        _showSnackBar('Location updated to: ${trimmedAddress.split(',')[0]}');

        await Future.delayed(const Duration(milliseconds: 800));
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint("Error parsing coordinates: $e");
      if (mounted) {
        _showSnackBar("Error selecting location. Please try again.", isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0A) : const Color(0xFFFAFBFC),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isDark 
                              ? const Color(0xFF2D2D2D) 
                              : const Color(0xFFF7F8FA),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDark 
                                ? const Color(0xFF3D3D3D) 
                                : const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: isDark ? Colors.white : const Color(0xFF374151),
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose Location",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : const Color(0xFF111827),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Select your delivery address",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Location Card
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _isLoadingCurrentLocation ? null : _handleCurrentLocation,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFF3B82F6),
                                      const Color(0xFF1D4ED8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: const Icon(
                                        Icons.my_location_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Use Current Location",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "We'll detect your location automatically",
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_isLoadingCurrentLocation)
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    else
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Search Section Header
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3B82F6),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Search for a location",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : const Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Search Field
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: GooglePlaceAutoCompleteTextField(
                            textEditingController: _searchController,
                            focusNode: _focusNode,
                            googleAPIKey: "AIzaSyBAgjZGzhUBDznc-wI5eGRHyjVTfENnLSs",
                            inputDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                              hintText: "Enter area, street, or landmark...",
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: isDark 
                                    ? const Color(0xFF6B7280) 
                                    : const Color(0xFF9CA3AF),
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.search_rounded,
                                  color: _hasSearchStarted 
                                      ? const Color(0xFF3B82F6)
                                      : (isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF)),
                                  size: 22,
                                ),
                              ),
                              suffixIcon: _hasSearchStarted
                                  ? GestureDetector(
                                      onTap: () {
                                        _searchController.clear();
                                        setState(() {
                                          _hasSearchStarted = false;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: const Color(0xFF6B7280),
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  : null,
                              filled: true,
                              fillColor: isDark 
                                  ? const Color(0xFF1F2937) 
                                  : Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: isDark 
                                      ? const Color(0xFF374151) 
                                      : const Color(0xFFE5E7EB),
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: isDark 
                                      ? const Color(0xFF374151) 
                                      : const Color(0xFFE5E7EB),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3B82F6),
                                  width: 2,
                                ),
                              ),
                            ),
                            debounceTime: 600,
                            countries: const ["in"],
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) async {
                              await _handleLocationSelection(prediction);
                            },
                            itemClick: (Prediction prediction) {
                              _searchController.text = prediction.description ?? "";
                              _searchController.selection = TextSelection.fromPosition(
                                TextPosition(offset: prediction.description?.length ?? 0),
                              );
                            },
                            seperatedBuilder: Divider(
                              height: 1,
                              color: isDark 
                                  ? const Color(0xFF374151) 
                                  : const Color(0xFFF3F4F6),
                            ),
                            itemBuilder: (context, index, Prediction prediction) {
                              return Container(
                                color: isDark 
                                    ? const Color(0xFF1F2937) 
                                    : Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.location_on_rounded,
                                        color: const Color(0xFF3B82F6),
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            prediction.description ?? "Unknown location",
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: isDark 
                                                  ? Colors.white 
                                                  : const Color(0xFF111827),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (prediction.structuredFormatting?.secondaryText != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(
                                                prediction.structuredFormatting!.secondaryText!,
                                                style: GoogleFonts.inter(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: isDark 
                                                      ? const Color(0xFF9CA3AF) 
                                                      : const Color(0xFF6B7280),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.north_east_rounded,
                                      size: 16,
                                      color: isDark 
                                          ? const Color(0xFF6B7280) 
                                          : const Color(0xFF9CA3AF),
                                    ),
                                  ],
                                ),
                              );
                            },
                            isCrossBtnShown: false,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Popular locations or recent searches could go here
                    if (!_hasSearchStarted)
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? const Color(0xFF1F2937) 
                                  : const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark 
                                    ? const Color(0xFF374151) 
                                    : const Color(0xFFE2E8F0),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.location_searching_rounded,
                                  size: 48,
                                  color: isDark 
                                      ? const Color(0xFF6B7280) 
                                      : const Color(0xFF9CA3AF),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Start typing to search",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isDark 
                                        ? const Color(0xFF9CA3AF) 
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "We'll help you find the perfect location",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: isDark 
                                        ? const Color(0xFF6B7280) 
                                        : const Color(0xFF9CA3AF),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




