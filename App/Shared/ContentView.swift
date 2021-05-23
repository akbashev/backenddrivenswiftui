//
//  ContentView.swift
//  Shared
//
//  Created by Jaleel Akbashev on 10.03.21.
//

import SwiftUI
import CodableView

struct ContentView: View {
    var body: some View {
        URLView(url: URL(string: "http://127.0.0.1:8080/dummy")!)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.sizeThatFits)
    }
}

let json = """
{
    "type": "NavigationView",
    "content": [
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
                    "type": "NavigationLink",
                    "destination": [
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
                    ],
                    "label": [
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
                },
                {
                    "type": "Spacer"
                },
            ]
        }
    ]
}
""".data(using: .utf8)
