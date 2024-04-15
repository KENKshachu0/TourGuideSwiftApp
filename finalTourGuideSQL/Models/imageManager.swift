//
//  imageManager.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

import Foundation
import Combine
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var cancellable: AnyCancellable?
// 从URL加载图片
    func load(fromURLString urlString: String) {
        // 从URL创建一个URL对象
        guard let url = URL(string: urlString) else { return }
// 使用URLSession加载图片
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
        // 将数据转换为UIImage
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
        // 将图片发送到主线程
            .receive(on: DispatchQueue.main)
        // 将图片发布到image属性
            .sink(receiveValue: { [weak self] in self?.image = $0 })
    }
    deinit {
        cancellable?.cancel()
    }
}


