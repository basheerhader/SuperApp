//
//  MainListSwiftUIView.swift
//  SuperApp
//
//  Created by Basheer AlHader on 17/12/2022.
//

import SwiftUI

struct MainListSwiftUIView: View {
    
    var presenter: MainListDelegate!
    @State var selectedItem = ""
    
    var body: some View {
            Picker("Pick a job provider", selection: $selectedItem) {
                ForEach(0 ..< presenter.jobProviderCount, id:\.self) { item in
                    Text(presenter.getProviderItem(at: item))
            }
        }
    }
}

struct MainListSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainListSwiftUIView()
    }
}

//// MARK: - Main List Representation
//extension MainListSwiftUIView: MainListRepresentation {
//    func updateList() {
//
//    }
//}

extension ViewDisplayable where Self: View {
    func showLoading() { }
    func hideLoading() { }
    func present(to viewCoreoller: UIViewController) { }
    func showAlert(with message: String) { }
}

extension MainListRouter where Self: View {
    func openSFSafari(with link: URL) { }
}
