import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/main_screen.dart';

class EducationalVideosScreen extends StatefulWidget {
  const EducationalVideosScreen({super.key});

  @override
  State<EducationalVideosScreen> createState() => _EducationalVideosScreenState();
}

class _EducationalVideosScreenState extends State<EducationalVideosScreen> {
  final List<Map<String, dynamic>> videos = [
    {
      'title': 'Hand Hygiene Basics',
      'url': 'https://example.com/video1.mp4',
      'downloaded': false,
      'subtitles': ['EN', 'TWI', 'GA'],
    },
    {
      'title': 'Managing Diabetes',
      'url': 'https://example.com/video2.mp4',
      'downloaded': false,
      'subtitles': ['EN', 'TWI'],
    },
    {
      'title': 'Healthy Eating Habits',
      'url': 'https://example.com/video3.mp4',
      'downloaded': true,
      'subtitles': ['EN'],
    },
  ];

  void _downloadVideo(int index) {
    setState(() {
      videos[index]['downloaded'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded "${videos[index]['title']}"')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
                                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 0)))
          },
        ),
        title: const Text("Educational Videos"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Placeholder for video player
                  Container(
                    height: 180,
                    color: Colors.black12,
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      if (video['downloaded'])
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 20),
                      if (!video['downloaded'])
                        ElevatedButton.icon(
                          onPressed: () => _downloadVideo(index),
                          icon: const Icon(Icons.download),
                          label: const Text('Download'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(100, 36),
                          ),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Subs: '),
                          const SizedBox(width: 4),
                          for (var lang in video['subtitles'])
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: _SubtitleTag(label: lang),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SubtitleTag extends StatelessWidget {
  final String label;
  const _SubtitleTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      child: Text(label),
    );
  }
}
