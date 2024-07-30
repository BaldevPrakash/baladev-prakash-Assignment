class SongsListModel {
  final List<Data>? data;
  final Meta? meta;

  SongsListModel({
    this.data,
    this.meta,
  });

  SongsListModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta = (json['meta'] as Map<String, dynamic>?) != null
            ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'data': data?.map((e) => e.toJson()).toList(), 'meta': meta?.toJson()};
}

class Data {
  final int? id;
  final Attributes? attributes;

  Data({
    this.id,
    this.attributes,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        attributes = (json['attributes'] as Map<String, dynamic>?) != null
            ? Attributes.fromJson(json['attributes'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'attributes': attributes?.toJson()};
}

class Attributes {
  final String? imageUrl;
  final String? songUrl;
  final String? createdAt;
  final String? updatedAt;

  Attributes({
    this.imageUrl,
    this.songUrl,
    this.createdAt,
    this.updatedAt,
  });

  Attributes.fromJson(Map<String, dynamic> json)
      : imageUrl = json['image_url'] as String?,
        songUrl = json['song_url'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'song_url': songUrl,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}

class Meta {
  final Pagination? pagination;

  Meta({
    this.pagination,
  });

  Meta.fromJson(Map<String, dynamic> json)
      : pagination = (json['pagination'] as Map<String, dynamic>?) != null
            ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'pagination': pagination?.toJson()};
}

class Pagination {
  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  Pagination.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        pageSize = json['pageSize'] as int?,
        pageCount = json['pageCount'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
        'page': page,
        'pageSize': pageSize,
        'pageCount': pageCount,
        'total': total
      };
}
