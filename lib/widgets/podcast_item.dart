import 'package:devel_app/api/pdf_api.dart';
import 'package:devel_app/providers/podcasts.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

Widget PodcastItem(BuildContext context, String id) {
  var size = MediaQuery.of(context).size;
  var file;
  var podcast = Provider.of<Podcasts>(context, listen: true).findById(id);
  return GestureDetector(
    onTap: () async {
      // Navigator.of(context).pop();
      // final player = AudioPlayer();
      // var duration = await player.setFilePath(file.path);
      // player.play();
      // print("PATH=== ${reading.path}");
      print("Current podcast>>> ${podcast.title} and path >> ${podcast.path}");
      if (podcast.path.isEmpty) {
        Provider.of<Podcasts>(context, listen: false).notify();
        print("EMPTY >>>>");
        showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text("Loading")),
                    ],
                  ),
                ),
              );
            });
        file = await PDFApi.loadNetwork(podcast.url, podcast.title, true);
        Navigator.of(context).pop();
        print("file path >>>> ${file.path}");
        Provider.of<Podcasts>(context, listen: false)
            .addPodcastPath(podcast.id, file.path);

        OpenFile.open(file.path);
      } else {
        print("path >>> ${podcast.path}");
        OpenFile.open(podcast.path);
      }
      // print("navigator before");
      if (file == null) {
        // Navigator.of(context).pushNamed(PdfViewerScreen.routeName, arguments: {
        //   "title": reading.title,
        //   "path": reading.path,
        //   "file": null
        // });
      } else {
        // Navigator.of(context).pushNamed(PdfViewerScreen.routeName, arguments: {
        //   "title": reading.title,
        //   "path": null,
        //   "file": file,
        // });
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: EdgeInsets.only(bottom: 16, left: 5, right: 5, top: 1),
      width: size.width - 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFD3D3D3).withOpacity(.8),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          podcast.title,
          maxLines: 2,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF393939),
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            "",
            style: TextStyle(color: Color(0xFF8F8F8F)),
          ),
        ),
        // Spacer(),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
          onPressed: () async {
            // print("PATH=== $reading.path");
            // if (reading.path.isEmpty) {
            //   print("EMPTY >>>>");
            //   final file = await PDFApi.loadNetwork(reading.url, reading.title);
            //   print("file path >>>> ${file.path}");
            //   Provider.of<Readings>(context, listen: false)
            //       .addReadingPath(reading.id, file.path);
            // }
            // Navigator.of(context).pushNamed(PdfViewerScreen.routeName,
            //     arguments: {"title": reading.title, "path": reading.path});
          },
        ),
      ),
    ),
  );
}
