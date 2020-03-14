//
//  Article.swift
//  CompanyDetails
//
//  Created by Artyom Kudryashov on 14.03.2020.
//

import SwiftUI

public struct Article: Decodable {
    let id: Int  // As ID.

    let category: String
    let datetime: Int
    let headline: String
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}

//{
//   "category": "company news",
//   "datetime": 1569550360,
//   "headline": "More sol",
//   "id": 25286,
//   "image": "https://imictimes/photo.jpg",
//   "related": "AAPL",
//   "source": "The Economic Times India",
//   "summary": "NEW DEcentives.",
//   "url": "https://economictishow/71321308.cms"
// },
