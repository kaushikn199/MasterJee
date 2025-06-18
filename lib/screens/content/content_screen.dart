import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/content/content_model.dart';
import 'package:masterjee/providers/content_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/from_youtube.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/webview_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  static String routeName = 'contentScreen';

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ContentProvider>(context, listen: false).fetchContents().then((_) {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final contentData = Provider.of<ContentProvider>(context);
    final contents = contentData.contents;

    return Scaffold(
      appBar: AppBarTwo(title: AppTags.content),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : contents.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty_outlined, size: 100.sp),
            CommonText.medium('No Record Found',
                size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
          ],
        ),
      )
          : ListView.builder(
        itemCount: contents.length,
        itemBuilder: (ctx, i) {
          final item = contents[i];
          final isVideo = item.fileType == 'video';
          final isPdf = item.fileType == 'pdf';
          final isImage = item.fileType == 'png' || item.fileType == 'jpg';

          String? thumbUrl;
          if (item.thumbName != null && item.thumbName!.isNotEmpty) {
            thumbUrl = "https://one2.in/p99/${item.thumbPath}${item.thumbName}";
          } else if (isImage && item.fileUrl != null) {
            thumbUrl = item.fileUrl!;
          }

          return Card(
            child: ListTile(
              leading: isVideo
                  ? const Icon(Icons.play_circle_fill, color: Colors.red)
                  : isPdf
                  ? const Icon(Icons.picture_as_pdf, color: Colors.red)
                  : isImage
                  ? Image.network(thumbUrl ?? '', width: 50, fit: BoxFit.cover)
                  : const Icon(Icons.insert_drive_file),
              title: Text(item.realName),
              onTap: () {
                final url = item.fileUrl ?? item.vidUrl ?? item.frameUrl;
                print(url);
                if (url != null) _launchURL(isVideo,url, item.realName);
              },
            ),
          );
        },
      ),
    );
  }


  void _launchURL(bool isVideo,String thumbUrl,String name) async {
    if (isVideo) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlayVideoFromYoutube(courseId: 0, videoUrl: thumbUrl ?? "",),
          ));
    }else if(thumbUrl.contains(".pdf")){
      launchUrl(Uri.parse(thumbUrl));
    }
    else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewScreen(url: thumbUrl, title: name)),
      );
    }
  }

}
