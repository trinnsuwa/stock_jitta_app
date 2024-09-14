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

### Flow Chart

+-------------------+
|   User Opens App  |
+-------------------+
         |
         v
+-----------------------------+
|  Fetch Stocks Data (GraphQL) |
+-----------------------------+
         |
         v
+----------------------------------------+
|  Display Stock Rankings List on Screen |
+----------------------------------------+
         |
         v
+---------------------------------------+
|   Filter by Stock Market or Sector?   |
+---------------------------------------+
         |                       |
         v                       v
+----------------+         +-----------------+
|   No Filters   |         |   Apply Filter  |
| (Show All Data)|         | (Filter Stocks) |
+----------------+         +-----------------+
         |                       |
         v                       v
+----------------------------------------+
|  Display Updated Stock Rankings List  |
+----------------------------------------+
         |
         v
+---------------------------+
|   User Selects a Stock     |
+---------------------------+
         |
         v
+-------------------------------------+
|   Fetch Additional Stock Details    |
|          (from GraphQL)             |
+-------------------------------------+
         |
         v
+-------------------------------------+
|  Display Stock Details on New Screen|
+-------------------------------------+
         |
         v
+-------------------+
|   End User Flow   |
+-------------------+
