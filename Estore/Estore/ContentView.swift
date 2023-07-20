//
//  ContentView.swift
//  Estore
//
//  Created by Denys on 1/4/23.
//

import SwiftUI

struct ContentView: View {
    // Log status
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group  {
            if log_Status {
                MainPage()
            } else {
                OnBoardingPage()
            }
        }
  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
