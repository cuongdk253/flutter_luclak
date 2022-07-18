import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../services/http/cmd.dart';

DecorationImage myImageDecoration(String? url) {
  ImageProvider _imageProvider = const AssetImage('assets/imgs/logo_app.png');
  if (url != null && url != '') {
    _imageProvider = CachedNetworkImageProvider(baseUrl + url);
  }
  
  return DecorationImage(image: _imageProvider, fit: BoxFit.cover);
}
