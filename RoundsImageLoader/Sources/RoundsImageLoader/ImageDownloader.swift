//
//  ImageDownloader.swift
//  Created by Rexhep Kelmendi on 26.7.24.
//

import UIKit

public class ImageDownloader {
    public static let shared = ImageDownloader()
    private var tasks: [URL: URLSessionDataTask] = [:]

    public func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorDialog(message: error.localizedDescription)
                    completion(nil)
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.tasks.removeValue(forKey: url)
                completion(image)
            }
        }
        tasks[url] = task
        task.resume()
    }

    private func showErrorDialog(message: String) {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }

        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        rootViewController.present(alertController, animated: true, completion: nil)
    }
}


