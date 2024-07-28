import XCTest
@testable import RoundsImageLoader

final class RoundsImageLoaderTests: XCTestCase {

    func testSetImage() {
        let cache = ImageCache.shared
        let key = NSURL(string: "https://via.placeholder.com/150")!
        let image = UIImage()

        cache.cacheImage(image, forKey: key.absoluteString ?? "")

        XCTAssertEqual(cache.getImage(forKey: key.absoluteString ?? ""), image, "Image should be set and retrieved correctly.")
    }

    func testGetImage() {
        let cache = ImageCache.shared
        let key = NSURL(string: "https://via.placeholder.com/150")!
        let image = UIImage()

        cache.cacheImage(image, forKey: key.absoluteString ?? "")

        XCTAssertNotNil(cache.getImage(forKey: key.absoluteString ?? ""), "Image should be retrieved from cache.")
    }

    func testDownloadImage() {
         let expectation = self.expectation(description: "Image should be downloaded")

         let url = URL(string: "https://via.placeholder.com/150")!
         ImageDownloader.shared.downloadImage(from: url) { image in
             XCTAssertNotNil(image, "Image should be downloaded successfully.")
             expectation.fulfill()
         }

         waitForExpectations(timeout: 5, handler: nil)
     }
}
