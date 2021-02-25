//
//  PreviouslyViewedItems.swift
//  projectretailstoreclient
//
//  Created by Wendell Rodrigues on 1/13/21.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct RecentlyViewedItems: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var currentBeacon = CurrentBeacon()
    @State var items: [ShelfBrief] = []
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ForEach(items) { item in
                    HStack {
                        ViewedItem(item: item)
                            .padding(.leading, 10)
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 80, height: 95)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onAppear {
            loadRecentlyViewedProducts()
        }
        
    }


    //Loads recently viewed products and attaches them to state
    func loadRecentlyViewedProducts() {
        //Loop through user object styles array for uids
        let styles = session.userSession?.styles ?? []

            for style in styles {
                print(style)
                //Assign placeholder shelf to received shelf object
                Ref.FIRESTORE_COLLECTION_BEACONS
                    .whereField("uid", isEqualTo: style)
                    .getDocuments() { (snapshot, err) in
                        if let err = err {
                            print (err)
                        } else {
                            for doc in snapshot!.documents {
                                print("we have a document")
                                let data = doc.data()
                                let image = data["image"] as? String ?? ""
                                
                                loadFirebaseImage(url: "gs://projectretail-4dd60.appspot.com/\(image)") { image in
                                    //Create shelf brief using items
                                    let viewedItem = ShelfBrief(id: UUID(), uid: style, image: image)
                                    //Append to recentlyViewedItems
                                    items.append(viewedItem)
                                }
                            }
                        }
                    }
            }
    }
    
    
}


struct ViewedItem: View {
    
    @State var item: ShelfBrief
    
    var body: some View {
        VStack {
            Image(uiImage: item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 75)
                .padding(2)
        }
        .frame(width: 50, height: 70)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
