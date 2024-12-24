import 'package:flutter/material.dart';

class ImageExamplesScreen extends StatelessWidget {
  const ImageExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Examples'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Basic Image with Error Handling
              const Text('1. Basic Image with Error Handling:'),
              Image.network(
                'https://picsum.photos/800/400',
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error_outline, size: 40),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),

              // 2. Responsive Image with Container Constraints
              const Text('2. Responsive Image with Container:'),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxWidth * 0.5, // 2:1 aspect ratio
                    ),
                    child: Image.network(
                      'https://picsum.photos/800/400',
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // 3. Cached Network Image Example (requires cached_network_image package)
              const Text('3. Image with Border and Radius:'),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    'https://picsum.photos/800/400',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 4. Responsive Grid of Images
              const Text('4. Responsive Grid of Images:'),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Image.network(
                    'https://picsum.photos/400/400?random=$index',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 