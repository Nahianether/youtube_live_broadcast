import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/youtube/v3.dart' as youtube;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Live Broadcast API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  youtube.YouTubeApi? youtubeClient;
  List<youtube.LiveBroadcast> liveBroadcasts = [];

  @override
  void initState() {
    super.initState();
    initYoutubeApiClient();
  }

  Future<void> initYoutubeApiClient() async {
    final credentials = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      [youtube.YouTubeApi.youtubeReadonlyScope],
      // [youtube.YoutubeApi.youtubeReadonlyScope],
    );

    youtubeClient = youtube.YouTubeApi(credentials);

    // Fetch live broadcasts
    await getLiveBroadcasts();
  }

  Future<void> getLiveBroadcasts() async {
    final broadcasts = await youtubeClient!.liveBroadcasts.list(
      ['snippet'],
      mine: true,
    );

    setState(() {
      liveBroadcasts = broadcasts.items!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Live Broadcasts'),
      ),
      body: ListView.builder(
        itemCount: liveBroadcasts.length,
        itemBuilder: (context, index) {
          final broadcast = liveBroadcasts[index];
          return ListTile(
            title: Text(broadcast.snippet!.title.toString()),
            subtitle: Text(broadcast.snippet!.publishedAt.toString()),
          );
        },
      ),
    );
  }
}

const serviceAccountJson = '''
{
  "type": "service_account",
  "project_id": "your-project-id",
  "private_key_id": "your-private-key-id",
  "private_key": "-----BEGIN PRIVATE KEY-----\nyour-private-key\n-----END PRIVATE KEY-----\n",
  "client_email": "your-client-email",
  "client_id": "your-client-id",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "your-client-x509-cert-url"
}
''';
