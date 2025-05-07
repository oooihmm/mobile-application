//
//  AddBucketView.swift
//  DearMyBucket
//
//  Created by 최진선 on 5/7/25.
//

import SwiftUI

struct AddBucketView_Previews: PreviewProvider {
    static var previews: some View {
        AddBucketView()
            .previewDevice("iPhone 16")
            .previewLayout(.sizeThatFits) 
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

struct AddBucketView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var detail: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Title")
                    .font(.headline)
                    .fontWeight(.medium)
                TextField("Enter up to 50 characters", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: title){
                        if title.count > 50 {
                            title = String(title.prefix(50))
                        }
                    }

                Text("Details")
                    .font(.headline)
                    .fontWeight(.medium)
                TextEditor(text: $detail)
                    .padding(8)
                    .frame(height: 120)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))

                Spacer()

                Button(action: {
                    addItem()
                    dismiss()
                }) {
                    Text("Add Bucket")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(title.isEmpty ? Color.gray.opacity(0.3) : Color("MainYellow"))
                        .cornerRadius(12)
                }
                .disabled(title.isEmpty)
            }
            .padding()
            .navigationTitle("Add New Bucket")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func addItem() {
        let newItem = BucketItem(context: viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.detail = detail
        newItem.date = Date()
        newItem.isCompleted = false

        do {
            try viewContext.save()
        } catch {
            print("❗️error: \(error.localizedDescription)")
        }
    }
}
