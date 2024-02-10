//
//  HomeView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/6/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    //MARK: - Properties
    @ObservedObject var vm = HomeVM()
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            Chart {
                
            }
            .background(.gray)
        }
    }
}

#Preview {
    HomeView()
}
