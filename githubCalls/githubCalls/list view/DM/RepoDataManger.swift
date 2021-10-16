//
//  RepoDataManger.swift
//  githubCalls
//
//  Created by Tonywilson Jesuraj on 14/10/21.
//

import Foundation
class RepoDataManger {
    func fetchData() {
        var finalArray = [repoModel]()
        let session = URLSession.shared
        let url = URL(string: "https://api.github.com/users/tjmode/repos")!
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("The Response is : ",json)
                if let array = json as? NSArray {
                    for obj in array {
                        let dataArray = repoModel()
                        if let dict = obj as? NSDictionary {
                            dataArray.name = dict.value(forKey: "name") as? String ?? ""
                            if let dict2 = dict.value(forKey: "owner") as? NSDictionary {
                                dataArray.avatarUrl = dict2.value(forKey: "avatar_url") as? String ?? ""
                            }
                            dataArray.cloneUrl = dict.value(forKey: "clone_url") as? String ?? ""
                            dataArray.defaultBranch = dict.value(forKey: "default_branch") as? String ?? ""
                            dataArray.details = dict.value(forKey: "description") as? String ?? ""
                            dataArray.language = dict.value(forKey: "language") as? String ?? ""
                            dataArray.openIssues = dict.value(forKey: "open_issues") as? String ?? ""
                            dataArray.repoUrl = dict.value(forKey: "repos_url") as? String ?? ""
                            dataArray.watchers = dict.value(forKey: "watchers") as? String ?? ""
                            dataArray.visibility = dict.value(forKey: "visibility") as? String ?? ""
                        }
                        finalArray.append(dataArray)
                    }
                    NotificationCenter.default.post(name: Notification.Name("dataLoaded"), object: finalArray)
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
