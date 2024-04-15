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
    @State private var longitudeString: String = ""
    @State private var latitudeString: String = ""

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

                TextField("Longitude", text: $longitudeString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Latitude", text: $latitudeString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("保存景点数据") {
                    let longitude = Double(longitudeString) ?? 0.0
                    let latitude = Double(latitudeString) ?? 0.0

                    let newSpot = ScenicSpot(id: UUID().hashValue, title: title, description: description, imageUrl: imageUrl, longitude: longitude, latitude: latitude)
                    dbManager.insertScenicSpot(spot: newSpot)

                    // Optionally clear the text fields after save
                    title = ""
                    description = ""
                    imageUrl = ""
                    longitudeString = ""
                    latitudeString = ""
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)

                Divider()

                Button("加载景点数据") {
                    self.scenicSpots = dbManager.fetchAllScenicSpots()
                }

                List {
                    ForEach(scenicSpots) { spot in
                        VStack(alignment: .leading) {
                            Text(spot.title)
                                .font(.headline)
                            Text(spot.description)
                                .font(.subheadline)
                                .lineLimit(3)
                            Text("Longitude: \(spot.longitude), Latitude: \(spot.latitude)")
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: deleteSpot)
                }
            }
            .navigationTitle("插入数据库")
        }
    }

    func deleteSpot(at offsets: IndexSet) {
        offsets.forEach { index in
            let spotId = scenicSpots[index].id
            dbManager.deleteScenicSpot(byId: spotId)
        }
        scenicSpots.remove(atOffsets: offsets)
    }
}



#Preview {
    SQLToggleView()
}

