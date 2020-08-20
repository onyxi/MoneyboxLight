# MoneyboxLight
Moneybox iOS Technical Challenge

# Moneybox Light

This project is a light-weight version of the Moneybox app - intended to demonstrate some of its core concepts. The app enables users to view the current state of all their investments, inspect individual accounts and to make deposits into each account's Moneybox - ready for investment by the Moneybox team. 

## Authorization
The app requires the user to log in and obtain an auth token in order to view their accounts and make any Moneybox deposits. Auth tokens expire after 5 minutes without use, requiring the user to log in again before fetching account data or making Moneybox deposits. 

To try out the app, use the following credentials to log in:
 
 - Email: `test+ios@moneyboxapp.com`
 - Password `P455word12`

## Usage
To view a summary of all accounts, simply login with the credentials above and you will be presented with a greeting, the user's total plan value, and a list of the user's individual accounts. Tap on an account in the list to view that account's details.

When viewing an account's details, as well as the account's name, current value and current Moneybox amount, the 'Add £10' button can be tapped to add that amount to the user's Moneybox ready for investment.

If at any time the auth token expires, the app will automatically present the login screen - just re-enter the credentials above to get a new token, dismiss the screen and continue using the app.

### Security
To improve the security of auth token storage on the device, the token is stored in the iOS Keychain, rather than in UserDefaults. The Keychain is an encrypted key-value store, whereas UserDefaults is not. However, Keychain values persist on the user's device even after the app is uninstalled. To avoid the possibility of a different user installing the app and finding that a previous user's auth token is still available there, the reference to the bearer token in the Keychain is stored as a universally unique identifier (UUID) in UserDefaults. This way, if the app is uninstalled then the reference to the bearer token in the Keychain will be cleared and not available to future users.

### Technical Specifications
Moneybox Light was developed for iPhone with Xcode 11.3 and Swift 5, and requires deployment on iOS 11.0 or later.
