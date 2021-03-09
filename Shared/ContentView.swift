//
//  ContentView.swift
//  Shared
//
//  Created by Jaleel Akbashev on 10.03.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        try! JSONDecoder().decode(CodableView.self, from: json!).padding()
//        VStack(alignment: .leading, spacing: 8) {
//            HStack(spacing: 8) {
//                Image(systemName: "person.crop.circle")
//                    .resizable()
//                    .frame(width: 48, height: 48)
//                    .scaledToFit()
//                Text("Test text").fontWeight(.semibold).font(.body)
//            }
//            Text("It's a decription here").foregroundColor(Color(hex: "#888888")).background(Color(hex: "#ff0000"))
//        }.frame(maxWidth: .infinity, alignment: .leading).padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let json = """
{
    "type": "VStack",
    "properties": {
        "spacing": 8,
        "horizontalAlignment": "left",
        "positionFrame": {
            "maxWidth": "infinity",
            "alignment": "left"
        }
    },
    "subviews": [
        {
            "type": "HStack",
            "properties": {
                "spacing": 8,
            },
            "subviews": [
                {
                  "type": "Image",
                  "value": {
                      "imageUrl": "person.crop.circle",
                      "imageType": "system"
                  },
                  "properties": {
                    "frame": {
                        "width": 48,
                        "height": 48
                    }
                  }
                },
                {
                    "type": "Text",
                    "value": {
                        "text": "Test text"
                    },
                    "properties": {
                        "fontWeight": "semibold",
                        "font": "body"
                    }
                }
            ]
        },
        {
            "type": "Text",
            "value": {
                "text": "It's a decription here"
            },
            "properties": {
                "foregroundColor": "#888888",
                "backgroundColor": "#ff0000"
            }
        }
    ]
}
""".data(using: .utf8)
