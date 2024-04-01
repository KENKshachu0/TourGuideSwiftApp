//
//  AsyncImageView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

import Foundation
import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let urlString: String

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                // 在图片加载时显示的占位符
                Color.gray
            }
        }
        .onAppear {
            loader.load(fromURLString: urlString)
        }
    }
}

