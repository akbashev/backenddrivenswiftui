import Vapor
import CodableView

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("dummy") { req -> CodableView in
        let view = CodableView(
            type: .VStack,
            subviews: [
                CodableView(
                    type: .HStack,
                    subviews: [
                        CodableView(
                            type: .Text,
                            value: CodableView.Value(
                                text: "Dummy text"
                            )
                        ),
                        CodableView(
                            type: .Text,
                            value: CodableView.Value(
                                text: "Other data"
                            )
                        ),
                        CodableView(
                            type: .Spacer
                        )
                    ]
                ),
                CodableView(
                    type: .Text,
                    value: CodableView.Value(
                        text: "Description"
                    )
                )
            ]
        )
        return view
    }
    
}

extension CodableView: Content {}
extension URLView: Content {}
