# ParkingApp / Park.Me

## Installation

## USAGE

In the project folder, open the .xcworkspace version of the app. This is necessary for the Firebase methods to be loaded and used properly.

Running the app through the simulator built-in with Xcode will load the app and display a Login Screen.

This initial Login Screen view is in charge of handling user login, user registration and also provides the opportunity for logging in as an admin.
1. Admin login is accessed by pressing the custom gear icon in the top right.

	a. Login requires the use of the following account information:
		[Contact for info for testing]

	
	b. Logging in will take the user to a separate set of views which will display a table of the parking lots read from the Firestore database.
		
		i. Clicking on a cell will reveal all of the registered USERS (through generated user ids to provide anonymity).
		ii. Swiping on a cell will reveal a delete button that can be pressed to delete that specific entry.

2. User Registration can be accssed by pressing the 'Register now!' button.
	
	a. This will perform a segue to a new view which will ask a user to fill out the required fields.
		
		i. This requires entering a **valid** email address and a password.
		ii. Clicking register will authenticate the user through Firebase Authentication.

3. User login is handled by entering your email address and password into the fields and then clicking the login button.
	
	a. This will take you to a new set of views that displays a TableView with all available parking lots and a Settings page.
		
		i. The TableView displays all the parking lots. Clicking on a specifc lot will take the user to another page which will ask the user to select the time they would like.
			a. Use the stepper to adjust the time to the amount of time you want and then click Update.
		ii. The settings page has fields for the user to save their car information.
			a. Enter data related to the License Plate, Color, Make, and Model of your car and click the button.
				i. This will associate these details with your signed in user account.


## REGARDING FEATURES:


There are two tab bar controllers, one for users and one for admins. They display two unique TableViews and a settings page for 3 views total though there are many more custom views included as segues.

Navigation is handled through a custom built view that includes a navigation bar and buttons for moving back and forth between views.

Each TableView displays a custom cell. 
	
	1. The user TableView displays information about the parking lot, the location and capacity of the lot.
	2. The admin TableView displays the parking lots and then displays a second tableview on cell click that shows user ids.

Firebase (Firestore) was used as the database.
		
		1. There are three collections: user, lot, and admin.
			a. Admin stores info about the admin account for login.
			b. User stores user information. Each user has associated with it:
				a. User ID
				b. License Plate
				c. Color
				d. Make
				e. Model
				f. Time (if registered)  
				d. Valid Until (if registered)
			c. Each Lot has associated with it:
				a. Lot Name
				b. Lot Location
				c. Lot Capacity
				d. Lot Cars: An array of all the cars each lot has, associated by User ID.

Settings screen is accessed through the User view and takes information about the user's car.

Inserting into a list is done in the User views by adding their car.
Deleting from a list is done in the Admin view by swiping right on a cell after clicking on a lot and clicking "Delete."

Documentation found in each swift file.


## License

Standard MIT.
