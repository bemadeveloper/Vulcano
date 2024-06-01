//
//  CompositionalModel.swift
//  Vulcano
//
//  Created by Bema on 1/6/24.
//

import Foundation

struct CompositionalModel: Hashable {
    var mainTitle: String?
    var description: String?
    var image: String
    var numberOfItem: Int?
}

extension CompositionalModel {
    static let modelsArray = [
        [CompositionalModel(mainTitle: "Featured Collection", description: "Biography", image: "allBooks"),
         CompositionalModel(mainTitle: "Featured Collection", description: "Short Stories", image: "allBooks"),
         CompositionalModel(mainTitle: "Featured Collection", description: "History", image: "allBooks"),
         CompositionalModel(mainTitle: "Featured Collection", description: "Philosophy", image: "allBooks"),
         CompositionalModel(mainTitle: "Featured Collection", description: "Poetry", image: "allBooks")
        ],
        [CompositionalModel(mainTitle: nil, description: nil, image: "book1"),
         CompositionalModel(mainTitle: nil, description: nil, image: "book2"),
         CompositionalModel(mainTitle: nil, description: nil, image: "book3"),
         CompositionalModel(mainTitle: nil, description: nil, image: "book4"),
         CompositionalModel(mainTitle: nil, description: nil, image: "book5")
        ],
        [CompositionalModel(mainTitle: "Book Six", description: "Description of book six", image: "book6", numberOfItem: 6),
         CompositionalModel(mainTitle: "Book Seven", description: "Description of book seven", image: "book7", numberOfItem: 7),
         CompositionalModel(mainTitle: "Book Eight", description: "Description of book eight", image: "book8", numberOfItem: 8),
         CompositionalModel(mainTitle: "Book Nine", description: "Description of book nine", image: "book9", numberOfItem: 9),
         CompositionalModel(mainTitle: "Book Ten", description: "Description of book ten", image: "book10", numberOfItem: 10),
         CompositionalModel(mainTitle: "Book Eleven", description: "Description of book eleven", image: "book11", numberOfItem: 11),
         CompositionalModel(mainTitle: "Book Twelve", description: "Description of book twelve", image: "book12", numberOfItem: 12),
         CompositionalModel(mainTitle: "Book Thirteen", description: "Description of book thirteen", image: "book13", numberOfItem: 13),
         CompositionalModel(mainTitle: "Book Fourteen", description: "Description of book fourteen", image: "book14", numberOfItem: 14)
        ]
    ]
}
