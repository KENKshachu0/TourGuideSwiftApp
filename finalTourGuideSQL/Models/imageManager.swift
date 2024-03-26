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

    func load(fromURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in self?.image = $0 })
    }

    deinit {
        cancellable?.cancel()
    }
}
