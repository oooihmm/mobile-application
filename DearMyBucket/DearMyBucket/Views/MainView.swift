// Views/MainView.swift
// DearMyBucket
//
// Created by 최진선 on 5/7/25.

import SwiftUI
import CoreData

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        let item = BucketItem(context: viewContext)
        item.id = UUID()
        item.title = "sample"
        item.detail = "sample details"
        item.date = Date()
        item.isCompleted = false
        try? viewContext.save()

        return MainView()
            .environment(\.managedObjectContext, viewContext)
            .previewDevice("iPhone 16")
            .previewLayout(.sizeThatFits)
    }
}

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BucketItem.date, ascending: false)],
        animation: .default)
    private var bucketItems: FetchedResults<BucketItem>

    @State private var showAddView = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("📒 My Bucket")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color("MainBrown"))
                    .padding(.leading)

                if bucketItems.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Text("🫧")
                            .font(.system(size: 40))
                        Text("No bucket list items found!")
                            .font(.system(size: 18))
                            .foregroundColor(Color(.darkGray))
                        Button(action: { showAddView = true }) {
                            Text("Add New Bucket")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(Color("MainGreen"))
                                .padding()
                                .frame(width: 200, height: 48)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color("MainGreen"), lineWidth: 2)
                                )
                                .cornerRadius(12)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(bucketItems) { item in
                            HStack {
                                Button(action: {
                                    item.isCompleted.toggle()
                                    saveContext()
                                }) {
                                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isCompleted ? .green : .gray)
                                }
                                .buttonStyle(.plain)

                                NavigationLink(destination: DetailView(bucketItem: item)) {
                                    Text(item.title ?? "")
                                        .foregroundColor(Color(.darkGray))
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddView = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color("MainBrown"))
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddBucketView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            offsets.map { bucketItems[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("❗️error: \(error.localizedDescription)")
        }
    }
}
