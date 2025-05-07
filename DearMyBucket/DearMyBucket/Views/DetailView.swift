// Views/DetailView.swift
// DearMyBucket
//
// Created by 최진선 on 5/7/25.

import SwiftUI

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        let sampleItem = BucketItem(context: viewContext)
        sampleItem.id = UUID()
        sampleItem.title = "sample"
        sampleItem.detail = "sample details"
        sampleItem.date = Date()
        sampleItem.isCompleted = false
        try? viewContext.save()

        return NavigationView {
            DetailView(bucketItem: sampleItem)
                .environment(\.managedObjectContext, viewContext)
        }
        .previewDevice("iPhone 16")
    }
}

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var bucketItem: BucketItem
    @State private var isEditing = false
    @State private var draftTitle: String = ""
    @State private var draftDetail: String = ""

    private var isInvalidTitle: Bool {
        draftTitle.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if isEditing {
                TextField("Enter title", text: $draftTitle)
                    .font(.title2)
                    .padding(12)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(Color(.darkGray))
                    .cornerRadius(8)

                TextEditor(text: $draftDetail)
                    .frame(height: 120)
                    .padding(8)
                    .foregroundColor(Color(.darkGray))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
            } else {
                Text(bucketItem.title ?? "")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color("MainBrown"))

                HStack {
                    Text(formattedDate(bucketItem.date))
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Spacer()

                    Button(action: {
                        bucketItem.isCompleted.toggle()
                        saveContext()
                    }) {
                        Image(systemName: bucketItem.isCompleted ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(bucketItem.isCompleted ? .green : .gray)
                    }
                    .buttonStyle(.plain)
                }

                if let detail = bucketItem.detail, !detail.isEmpty {
                    Text(detail)
                        .font(.body)
                        .foregroundColor(Color(.darkGray))
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle(isEditing ? "edit" : "details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isEditing {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing = false
                    }) {
                        Text("cancle")
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("save") {
                        saveChanges()
                    }
                    .disabled(isInvalidTitle)
                } else {
                    Button("edit") {
                        draftTitle = bucketItem.title ?? ""
                        draftDetail = bucketItem.detail ?? ""
                        isEditing = true
                    }
                }
            }
        }
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: date)
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("❗️error: \(error.localizedDescription)")
        }
    }

    private func saveChanges() {
        bucketItem.title = draftTitle
        bucketItem.detail = draftDetail.trimmingCharacters(in: .whitespacesAndNewlines)
        saveContext()
        isEditing = false
    }
}
