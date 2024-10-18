import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildTopButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed, // Button action
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: color),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ekta Stores'),
        actions: [
          GestureDetector(
            onTap: () {
              _onShowStoreDetailsPressed(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
              ),
              child: Icon(
                Icons.person,
                color: Colors.blue.shade800,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Show the top buttons only on the Parties page
          if (_selectedIndex == 0)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTopButton('Send Money', Icons.send, Colors.red, () {
                    print('Send Money clicked');
                  }),
                  _buildTopButton(
                      'Request Money', Icons.request_page, Colors.green, () {
                    print('Request Money clicked');
                  }),
                  _buildTopButton('Payment History', Icons.history, Colors.blue,
                      () {
                    print('Payment History clicked');
                  }),
                  _buildTopButton('Apply', Icons.money, Colors.amber, () {
                    print('Apply clicked');
                  }),
                ],
              ),
            ),
          Expanded(child: _getSelectedPage()),
        ],
      ),
      // Show the Add Customer button only on the Parties page
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                _showAddCustomerDialog(context);
              },
              label: Text('Add Customer'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.deepPurple,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Parties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Bills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 1:
        return BillsPage();
      case 2:
        return InventoryPage();
      case 3:
        return MorePage();
      default:
        return PartiesPage();
    }
  }
}

// The rest of your classes like BillsPage, InventoryPage, MorePage, and PartiesPage will remain the same.

class BillsPage extends StatefulWidget {
  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  final List<Map<String, String>> bills = [
    {'id': 'B001', 'amount': '₹500', 'status': 'Paid'},
    {'id': 'B002', 'amount': '₹1,200', 'status': 'Pending'},
    {'id': 'B003', 'amount': '₹750', 'status': 'Overdue'},
  ];

  @override
  Widget build(BuildContext context) {
    return bills.isEmpty
        ? Center(
            child: Text("No bills available."),
          )
        : ListView.builder(
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final bill = bills[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(bill['id']?[0] ?? 'B'),
                ),
                title: Text('Bill ID: ${bill['id']}'),
                subtitle: Text('Amount: ${bill['amount']}'),
                trailing: Text(
                  bill['status'] ?? 'Unknown',
                  style: TextStyle(
                    color: bill['status'] == 'Paid'
                        ? Colors.green
                        : bill['status'] == 'Overdue'
                            ? Colors.red
                            : Colors.orange,
                  ),
                ),
              );
            },
          );
  }
}

class InventoryPage extends StatelessWidget {
  final List<Map<String, String>> inventoryItems = [
    {'name': 'Item A', 'quantity': '100', 'price': '₹50'},
    {'name': 'Item B', 'quantity': '200', 'price': '₹30'},
    {'name': 'Item C', 'quantity': '50', 'price': '₹150'},
  ];

  @override
  Widget build(BuildContext context) {
    return inventoryItems.isEmpty
        ? Center(
            child: Text("No inventory items available."),
          )
        : ListView.builder(
            itemCount: inventoryItems.length,
            itemBuilder: (context, index) {
              final item = inventoryItems[index];
              return ListTile(
                title: Text(item['name'] ?? 'Unknown Item'),
                subtitle: Text(
                    'Quantity: ${item['quantity']}, Price: ${item['price']}'),
              );
            },
          );
  }
}

class MorePage extends StatelessWidget {
  final List<Map<String, String>> options = [
    {'title': 'Settings', 'description': 'Manage your app settings'},
    {'title': 'Help', 'description': 'Get help with using the app'},
    {'title': 'Feedback', 'description': 'Provide feedback about the app'},
    {'title': 'About Us', 'description': 'Learn more about our company'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return ListTile(
          title: Text(option['title'] ?? 'Unknown Option'),
          subtitle: Text(option['description'] ?? ''),
          onTap: () {
            // Add your navigation or functionality here
            _onOptionTapped(option['title'], context);
          },
        );
      },
    );
  }

  void _onOptionTapped(String? title, BuildContext context) {
    // Define what happens when an option is tapped
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? 'Option'),
          content: Text('You tapped on $title.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

class PartiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarSection();
  }
}

class TabBarSection extends StatefulWidget {
  @override
  _TabBarSectionState createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Customers'),
            Tab(text: 'Suppliers'),
          ],
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              CustomerList(),
              SupplierList(),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  // List to store customer details
  final List<Map<String, String>> customers = [
    {'name': 'Ishan Sharma', 'amount': '₹4,532', 'action': 'REQUEST'},
    {'name': 'Raaghav Verma', 'amount': '₹47', 'action': 'REQUEST'},
    {'name': 'Virat', 'amount': '₹1,102', 'action': 'REQUEST'},
    {'name': 'Vyom Kushwaha', 'amount': '₹190', 'action': 'PAY'},
    {'name': 'Kartikeya', 'amount': '₹0', 'action': 'REQUEST'},
    {'name': 'Soumyajit', 'amount': '₹400', 'action': 'PAY'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddCustomerDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(customer['name']?[0] ?? 'N'), // Handle potential null
            ),
            title: Text(customer['name'] ?? 'Unknown'), // Handle potential null
            subtitle: Text('Set due date'),
            trailing: Container(
              width: 100, // Set a fixed width to avoid overflow
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Minimize the size of the Column
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      customer['amount'] ?? '₹0', // Handle potential null
                      style: TextStyle(
                        color: customer['action'] == 'PAY'
                            ? Colors.green
                            : Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        customer['action'] ??
                            'REQUEST', // Handle potential null
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SupplierList extends StatelessWidget {
  final List<Map<String, String>> suppliers = [
    {'name': 'SupplyCo Ltd.', 'amount': '₹10,000', 'action': 'PAY'},
    {'name': 'TechPro Supplies', 'amount': '₹5,750', 'action': 'REQUEST'},
    {'name': 'MaterialHub', 'amount': '₹3,200', 'action': 'PAY'},
    {'name': 'Essential Goods Ltd.', 'amount': '₹7,800', 'action': 'REQUEST'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Allows scrolling if content exceeds the available space
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true, // Ensures the ListView takes only necessary space
            physics:
                NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              return ListTile(
                  leading: CircleAvatar(
                    child: Text(supplier['name']?[0] ?? 'S'),
                  ),
                  title: Text(supplier['name'] ?? 'Unknown'),
                  subtitle: Text('Supply due date'),
                  trailing: Container(
                    width: 100,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            supplier['amount'] ?? '₹0',
                            style: TextStyle(
                              color: supplier['action'] == 'PAY'
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              supplier['action'] ?? 'REQUEST',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

void _showAddCustomerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String newCustomerName = '';
      String newCustomerAmount = '';
      String newCustomerAction = 'REQUEST';
      return AlertDialog(
        title: Text('Add New Customer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                newCustomerName = value;
              },
              decoration: InputDecoration(
                labelText: 'Customer Name',
              ),
            ),
            TextField(
              onChanged: (value) {
                newCustomerAmount = value;
              },
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: newCustomerAction,
              items: <String>['REQUEST', 'PAY']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  newCustomerAction = value;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Add customer to the list (to be implemented)
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}

void _onShowStoreDetailsPressed(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ekta Stores'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mobile: +91 9876543210'),
            SizedBox(height: 8),
            Text('Email: ekta.stores@example.com'),
            SizedBox(height: 8),
            Text('Address: 123, Moyna road, Tamluk'),
            SizedBox(height: 16),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
