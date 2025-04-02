import SwiftUI
import SDWebImageSwiftUI


struct WorkoutCard: View {
    var title: String
    var color: Color

    var body: some View {
        HStack {
            Image(systemName: "dumbbell.fill")
                .font(.title2)
                .foregroundColor(color)
                .padding(.trailing, 8)

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct ExerciseCard: View {
    @Binding var exercise: Exercise
    @State private var showInfo = false

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(exercise.name)
                            .font(.headline)
                        Text(exercise.muscle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(exercise.setsReps)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    if exercise.imageName != nil {
                        Button(action: {
                            withAnimation {
                                showInfo = true
                            }
                        }) {
                            Image(systemName: "info.circle")
                                .font(.title3)
                        }
                        .padding(.trailing, 8)
                    }

                    Image(systemName: exercise.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(exercise.isCompleted ? .green : .gray)
                        .font(.title2)
                        .onTapGesture {
                            exercise.isCompleted.toggle()
                        }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)

            // Popup sovrapposto
            if showInfo, let imageName = exercise.imageName {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)

                VStack(spacing: 16) {
                    Text(exercise.name)
                        .font(.headline)
                        .padding(.top)

                    AnimatedImage(name: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 250)
                        .cornerRadius(12)
                        .shadow(radius: 5)

                    Button("Chiudi") {
                        withAnimation {
                            showInfo = false
                        }
                    }
                    .padding(.bottom)
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: 320)
                .padding()
                .background(Material.ultraThin)
                .cornerRadius(20)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
    }

}
