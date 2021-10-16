//
//  RepoViewModel.swift
//  githubCalls
//
//  Created by Tonywilson Jesuraj on 14/10/21.
//

import Foundation
class RepoViewModel {
    var repoData = [repoModel]()
    func fetchData() {
        RepoDataManger().fetchData()
    }
    func load(data: [repoModel]) {
        repoData = data
    }
    func isDataAvailable() -> Bool {
        if repoData.count == 0 {
            return false
        }
        return true
    }
}
