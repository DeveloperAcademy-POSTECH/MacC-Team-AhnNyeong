
//  ManagerTargetView.swift
//  backUpMacC
//
//  Created by qwd on 10/14/23.

import SwiftUI

struct ManagerListView: View {
    @State private var isAddMode = false
    @State private var items: [String] = []
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: DetailView(item: item)) {
                            Text(item)
                                .font(.system(size: 30, weight: .bold))
                                .frame(width: 180, height: 110)
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }.padding()
            }
            .navigationTitle("Target list")
            .navigationBarItems(trailing: trailingButton)
            .sheet(isPresented: $isAddMode) {
                AddItemView(items: $items, isAddMode: $isAddMode)
            }
        }
    }

    private var trailingButton: some View {
        Button(action: {
            isAddMode = true
        }){
            Image(systemName: "plus")
        }
    }
}

struct DetailView: View {
    let item: String

    var body: some View {
        Text("Detail View for \(item)")
            .navigationBarTitle(item)
        
    }
}

struct AddItemView: View {
    @Binding var items: [String]
    @Binding var isAddMode: Bool
    @State private var newItem = ""

    var body: some View {
        VStack {
            TextField("New Item", text: $newItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                items.append(newItem)
                newItem = ""
                isAddMode = false
            }){
                Text("Add")
                    .font(.title)
                    .foregroundColor(.pink)
            }
            .padding()
        }
        .navigationBarItems(trailing:
            Button("Cancel") {
                isAddMode = false
            }
        )
    }
}

#Preview {
    ManagerListView()
}

