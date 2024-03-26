//
//  ScenicSpotDetailView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

import SwiftUI

struct ScenicSpotDetailView: View {
    var scenicSpot: ScenicSpot

    var body: some View {
        ScrollView {
            VStack {
                AsyncImageView(urlString: scenicSpot.imageUrl)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                
                Text(scenicSpot.title)
                    .font(.largeTitle)
                    .padding([.bottom, .top], 4)

                Text(scenicSpot.description)
                    .font(.body)
                    .padding()
            }
        }
        .navigationTitle(scenicSpot.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ScenicSpotDetailView(scenicSpot: ScenicSpot(id: 1, title: "长城", description: "中国长城是历史悠久的防御工事。", imageUrl: "https://s2.loli.net/2024/03/26/7xJZjXgoFzeMA8T.jpg"))
}
