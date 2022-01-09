//
//  ViewController.swift
//  Project1
//
//  Created by Barkha Maheshwari on 15/05/21.
//

import UIKit

class ParentVC: UITableViewController {

    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        sendNotification()

        let fm = FileManager.default
        let resPath = Bundle.main.resourcePath!

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareApp)
        )

        let images = try! fm.contentsOfDirectory(atPath: resPath)
        for image in images {
            if image.hasPrefix("nssl") {
                pictures.append(image)
            }
        }

        pictures.sort()
        print(pictures)
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "Please don't mind this one. This is just for test purpose."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)

        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageCount = pictures.count
            vc.selectedImageCount = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func shareApp() {
        let shareAbleItem = "Highly recommed this app! You see amazing pictured here :D"
        let vc = UIActivityViewController(activityItems: [shareAbleItem], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }

}

