

class SearchResultModel {
    SearchResultModel({
       required this.data,
    });

    List<Datum> data;

    factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
        data: json["data"] == [] ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

 
}
class Relationships {
    Relationships({
        this.domains,
        this.childContents,
        this.progression,
        this.bookmark,
    });

    SearchResultModel? domains;
    ChildContents? childContents;
    SearchResultModel? progression;
    SearchResultModel? bookmark;

    factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        domains: SearchResultModel.fromJson(json["domains"]),
        childContents: ChildContents.fromJson(json["child_contents"]),
        progression: SearchResultModel.fromJson(json["progression"]),
        bookmark: SearchResultModel.fromJson(json["bookmark"]),
    );
}

class Datum {
    Datum({
        this.id,
        this.type,
       // this.attributes,
       // this.relationships,
       // this.links,
    });

    String? id;
    String? type;
   // Attributes? attributes;
   // Relationships? relationships;
    Links? links;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
     //   attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
     //   relationships: json["relationships"] == null ? null : Relationships.fromJson(json["relationships"]),
     //   links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );
}



class ChildContents {
    ChildContents({
        this.meta,
    });

    Meta? meta;

    factory ChildContents.fromJson(Map<String, dynamic> json) => ChildContents(
        meta: Meta.fromJson(json["meta"]),
    );


}

class Meta {
    Meta({
        this.count,
    });

    int? count;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}

class Attributes {
    Attributes({
        this.uri,
        this.name,
        this.description,
        this.releasedAt,
        this.free,
        this.difficulty,
        this.contentType,
        this.duration,
        this.popularity,
        this.technologyTripleString,
        this.contributorString,
        this.ordinal,
        this.professional,
        this.descriptionPlainText,
        this.videoIdentifier,
        this.parentName,
        this.accessible,
        this.cardArtworkUrl,
    });

    String? uri;
    String? name;
    String? description;
    DateTime? releasedAt;
    bool? free;
    dynamic difficulty;
    String? contentType;
    int? duration;
    double? popularity;
    String? technologyTripleString;
    String? contributorString;
    dynamic ordinal;
    bool? professional;
    String? descriptionPlainText;
    dynamic videoIdentifier;
    dynamic parentName;
    bool? accessible;
    String? cardArtworkUrl;

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        uri: json["uri"],
        name: json["name"],
        description: json["description"],
        releasedAt: DateTime.parse(json["released_at"]),
        free: json["free"],
        difficulty: json["difficulty"],
        contentType: json["content_type"],
        duration: json["duration"],
        popularity: json["popularity"],
        technologyTripleString: json["technology_triple_string"],
        contributorString: json["contributor_string"],
        ordinal: json["ordinal"],
        professional: json["professional"],
        descriptionPlainText: json["description_plain_text"],
        videoIdentifier: json["video_identifier"],
        parentName: json["parent_name"],
        accessible: json["accessible"],
        cardArtworkUrl: json["card_artwork_url"],
    );

}

class Links {
    Links({
        this.self,
    });

    String? self;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
    );

    Map<String, dynamic> toJson() => {
        "self": self,
    };
}
