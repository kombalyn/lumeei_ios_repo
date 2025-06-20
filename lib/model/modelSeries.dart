// ignore_for_file: unnecessary_this, file_names

class Series1 {
  int? channelId;
  int? categoryId;
  String? channelName;
  String? channelImage;
  String? channelUrl;
  String? channelDescription;
  String? channelType;
  String? videoId;
  String? categoryName;
  String? userAgent;

  Series1(
      {this.channelId,
      this.categoryId,
      this.channelName,
      this.channelImage,
      this.channelUrl,
      this.channelDescription,
      this.channelType,
      this.videoId,
      this.categoryName,
      this.userAgent});

  Series1.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    categoryId = json['category_id'];
    channelName = json['channel_name'];
    channelImage = json['channel_image'];
    channelUrl = json['channel_url'];
    channelDescription = json['channel_description'];
    channelType = json['channel_type'];
    videoId = json['video_id'];
    categoryName = json['category_name'];
    userAgent = json['user_agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel_id'] = this.channelId;
    data['category_id'] = this.categoryId;
    data['channel_name'] = this.channelName;
    data['channel_image'] = this.channelImage;
    data['channel_url'] = this.channelUrl;
    data['channel_description'] = this.channelDescription;
    data['channel_type'] = this.channelType;
    data['video_id'] = this.videoId;
    data['category_name'] = this.categoryName;
    data['user_agent'] = this.userAgent;
    return data;
  }
}
