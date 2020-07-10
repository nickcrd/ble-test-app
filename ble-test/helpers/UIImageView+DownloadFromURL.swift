//
//  ImageUtils.swift
//  ble-test
//
//  Created by nc on 10.07.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import UIKit

/*
 From https://stackoverflow.com/a/27712427
 */
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
