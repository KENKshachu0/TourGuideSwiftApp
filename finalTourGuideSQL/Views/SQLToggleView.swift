//
//  SQLToggleView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

import SwiftUI

struct SQLToggleView: View {
    @State private var scenicSpots: [ScenicSpot] = []
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var imageUrl: String = ""
    
    private var dbManager = DatabaseManager()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Image URL", text: $imageUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save Scenic Spot") {
                    let newSpot = ScenicSpot(id: UUID().hashValue, title: title, description: description, imageUrl: imageUrl)
                    dbManager.insertScenicSpot(spot: newSpot)
                    
                    // Optionally clear the text fields after save
                    title = ""
                    description = ""
                    imageUrl = ""
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                Divider()
                
                Button("Load Scenic Spots") {
                    self.scenicSpots = dbManager.fetchAllScenicSpots()
                }
                
                List(scenicSpots) { spot in
                    VStack(alignment: .leading) {
                        Text(spot.title)
                            .font(.headline)
                        Text(spot.description)
                            .font(.subheadline)
                            .lineLimit(3)
                    }
                }
            }
            //.navigationTitle("插入数据库")
        }
    }
}

#Preview {
    SQLToggleView()
}
