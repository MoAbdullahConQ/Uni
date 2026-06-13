import 'package:flutter/material.dart';

class CampusPhotoViewer extends StatefulWidget {
  const CampusPhotoViewer({
    super.key,
    required this.photoPaths,
    required this.initialIndex,
  });

  final List<String> photoPaths;
  final int initialIndex;

  @override
  State<CampusPhotoViewer> createState() => _CampusPhotoViewerState();
}

class _CampusPhotoViewerState extends State<CampusPhotoViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // photos
          PageView.builder(
            controller: _pageController,
            itemCount: widget.photoPaths.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (_, i) {
              return InteractiveViewer(
                child: Center(
                  child: Image.network(
                    widget.photoPaths[i],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // close button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ),
          ),

          // Photo counter
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${_currentIndex + 1} / ${widget.photoPaths.length}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
