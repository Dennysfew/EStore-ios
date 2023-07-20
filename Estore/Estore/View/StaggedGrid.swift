//
//  StaggedGrid.swift
//  Estore
//
//  Created by Denys on 1/12/23.
//

import SwiftUI

struct StaggedGrid<Content: View, T: Identifiable> : View where T: Hashable {
    // It will return each object from collection to build View ...
    var content: (T) -> Content
    var list: [T]
    
    // Coloums
    var columns: Int
    // Properties
    var showsIndicators: Bool
    var spacing: CGFloat
    
    init(@ViewBuilder content: @escaping (T) -> Content, list: [T], columns: Int, showsIndicators: Bool = false, spacing: CGFloat = 10) {
        self.content = content
        self.list = list
        self.columns = columns
        self.showsIndicators = showsIndicators
        self.spacing = spacing
    }
    func setUpList() ->[[T]] {
        // creating empty sub arrays of columns count...
        var gridArray: [[T]] = Array (repeating: [], count:
                                        columns)
        //spiliting array for Vstack oriented View....
        var currentIndex: Int = 0
        for object in list {
            gridArray[currentIndex].append(object)
            // increasing index count...
            // and resetting if overbounds the columns count...
            if currentIndex == (columns - 1) {
                currentIndex = 0
            }
            else{
                currentIndex += 1
            }
        }
        return gridArray
    }
    var body: some View {
        
        HStack(alignment: .top, spacing: 20){
            ForEach (setUpList (), id: \.self) {columnsData in
                // For Optimized Using LazyStack...
                LazyVStack (spacing: spacing) {
                    ForEach (columnsData) {object in
                        content (object)
                    }
                }
                .padding(.top, getIndex(values: columnsData) == 1 ? 80 : 0)
            }
        }
        
        //only vertical padding.
        // horizontal padding will be user's optional...
        .padding(.vertical)
    }
    
    
    // Moving second row little Down ...
    
    func getIndex(values: [T]) -> Int {
        let index = setUpList().firstIndex { t in
            return t == values
        } ?? 0
        
        return index
    }
}


struct StaggedGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
