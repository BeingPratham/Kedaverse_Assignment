# Job Form App Documentation #
### Overview ###
The Job Form App is a Flutter application that allows users to fill out a job form with various fields such as job title, company overview, role summary, key responsibilities, skills, salary, and more. The app dynamically adjusts the form based on the selected employment type, either "Full-time", "Internship", or "Both".
<hr>

### Features ###

1. **Dynamic Field Visibility**: The app dynamically shows or hides fields based on the selected employment type. If the user selects "Internship", additional fields for internship duration and stipend are shown.
2. **PDF Generation**: After filling out the job form, users can generate a PDF document containing the entered information. The PDF is formatted to display the job details in a structured format.
3. **PDF Sharing and Viewing**: The generated PDF can be shared, saved, or viewed directly from the app using the **printing** package.
<hr>

### Approach ###

1. **Form Builder Package**: The flutter_form_builder package is used to create the dynamic form with various input fields.
2. **State Management**: State is managed using GlobalKey<FormBuilderState> to access and manipulate form fields.
3. **PDF Generation**: PDF documents are generated using the pdf package, which allows for the creation of PDF files programmatically.
4. **Field Visibility Logic**: Visibility of form fields is controlled using conditional rendering based on the selected employment type. When the user selects "Internship", the corresponding fields are displayed.
5. **Printing Package**: The printing package is utilized to display the generated PDF directly within the app. It provides functionality to layout and print PDF documents.

<hr>

### How to run the project ###

Prerequisites:
Ensure you have Flutter installed on your machine.

1. Clone the repository to your local machine:
```
git clone https://github.com/BeingPratham/Kedaverse_Assignment.git
```
2. Navigate to the project directory.
```
cd Kedaverse_Assignment
```
3. Install dependencies.
```
flutter pub get
```
4. Connect your device or emulator.
5. Run the app.
```
flutter run
```

<hr>

### Dependencies ###

1. flutter_form_builder: ^9.2.1 : https://pub.dev/packages/flutter_form_builder
2. form_builder_validators: ^9.1.0 : https://pub.dev/packages/form_builder_validators
3. pdf: ^3.10.8 : https://pub.dev/packages/pdf
4. printing: ^5.12.0 : https://pub.dev/packages/printing

<hr>

# Thank You #
  
  
  


