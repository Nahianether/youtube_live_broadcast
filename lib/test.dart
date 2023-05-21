// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   // Create a YouTube API client.
//   final client = http.Client();

//   // Create a request to create a live broadcast.
//   final request = http.Request('POST', Uri.parse('https://www.googleapis.com/youtube/v3/liveBroadcasts'));
//   request.headers['Authorization'] = 'Bearer AIzaSyAvLCWG2cyDCFGF1r1Fv7DelSSmgLB01IQ';
//   request.body = json.encode({
//     'snippet': {
//       'title': 'My Live Stream',
//       'description': 'This is my live stream.',
//     },
//     'status': {
//       'liveStreaming': true,
//     },
//   });

//   // Send the request and get the response.
//   final response = await client.send(request);

//   // Check the response status code.
//   if (response.statusCode != 200) {
//     throw Exception('Error creating live broadcast: ${response.statusCode}');
//   }

//   // Get the live broadcast ID.
//   final liveBroadcastId = json.decode(response.body)['id'];

//   // Create a request to start streaming video to the live broadcast.
//   final request = http.Request('POST', Uri.parse('https://www.googleapis.com/youtube/v3/liveStreams'));
//   request.headers['Authorization'] = 'Bearer AIzaSyAvLCWG2cyDCFGF1r1Fv7DelSSmgLB01IQ';
//   request.body = json.encode({
//     'snippet': {
//       'title': 'My Live Stream',
//       'description': 'This is my live stream.',
//     },
//     'status': {
//       'liveStreaming': true,
//     },
//     'cdn': {
//       'url': 'https://www.youtube.com/live_stream_url',
//       'format': 'mp4',
//       'bitrate': 1000,
//     },
//   });

//   // Send the request and get the response.
//   final response = await client.send(request);

//   // Check the response status code.
//   if (response.statusCode != 200) {
//     throw Exception('Error starting live stream: ${response.statusCode}');
//   }

//   // Start streaming video to the live broadcast.
//   final stream = Stream.fromIterable([
//      VideoFrame(
//       data:  Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
//       timestamp:  DateTime.now(),
//     ),
//      VideoFrame(
//       data:  Uint8List.fromList([11, 12, 13, 14, 15, 16, 17, 18, 19, 20]),
//       timestamp:  DateTime.now().add( Duration(seconds: 1)),
//     ),
//      VideoFrame(
//       data:  Uint8List.fromList([21, 22, 23, 24, 25, 26, 27, 28, 29, 30]),
//       timestamp:  DateTime.now().add( Duration(seconds: 2)),
//     ),
//   ]);

//   // Send the video frames to the live broadcast.
//   await stream.forEach((frame) async {
//     final request = http.Request('POST', Uri.parse('https://www.googleapis.com/youtube/v3/liveStreams/update'));
//     request.headers['Authorization'] = 'Bearer AIzaSyAvLCWG2cyDCFGF1r1Fv7DelSSmgLB01IQ';
//     request.body = json.encode({
//       'id': liveBroadcastId,
//       'cdn': {
//         'url': 'https://www.youtube.com/live_stream_url',
//         'format': 'mp4',
//       },
//       'frame': {
//         'data': base64.encode(frame.data),
//         'timestamp': frame.timestamp.toIso8601String(),
//       }
//     });
//   });
// }
