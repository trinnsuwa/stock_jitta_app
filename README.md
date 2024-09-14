### **Requirements**

- Flutter SDK (>= 3.0.0)
- Dart (>= 2.17.0)
- GraphQL API (ensure you have access)
- Any specific tools or dependencies like Realm, Hive, etc.

### **Step-by-Step Installation**

1. Clone the repository:

    ```bash
    git clone https://github.com/trinnsuwa/stock_jitta_app.git
    ```

2. Navigate to the project directory:

    ```bash
    cd stock-market-app
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

### User Flow

1. **User Opens App**
   - User opens the app to start exploring stocks.

2. **Fetch Stocks Data (GraphQL)**
   - The app fetches the stock ranking data from the GraphQL API.

3. **Display Stock Rankings List on Screen**
   - The fetched data is displayed on the screen as a list of stock rankings.

4. **Filter by Stock Market or Sector?**
   - User can filter the stock list by selecting a specific market or sector.
   - If no filter is applied, all data is shown.
   - If filters are applied, the list is updated based on the user's selection.

5. **Display Updated Stock Rankings List**
   - Show the stock rankings list after applying the filter (if any).

6. **User Selects a Stock**
   - User taps on a stock to view more details.

7. **Fetch Additional Stock Details**
   - The app fetches more detailed information about the selected stock from the GraphQL API.

8. **Display Stock Details on New Screen**
   - The detailed information about the stock is displayed on a new screen.

9. **End User Flow**
   - The user completes the exploration process.
