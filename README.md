# SmartKho - Intelligent Warehouse Management Application

SmartKho is a comprehensive warehouse management solution that automates inbound/outbound operations and inventory checks, aiming to optimize efficiency and reduce errors in warehouse management processes. This project includes a Web Dashboard for managers, a Mobile Application for warehouse staff, and a Backend API, developed with main technologies: NestJS, ReactJS, Flutter, and MongoDB.

## Objectives

SmartKho supports businesses in:

- Accurately and promptly tracking inventory.
- Optimizing the inbound/outbound workflow.
- Reducing the risks of stockouts and overstocking.
- Simplifying inventory checks and reporting for warehouse staff.

## Features

### 1. Web Dashboard Features (For Management)

The Web Dashboard is an administrative tool, enabling managers to control and monitor all warehouse activities with the following features:

- **User Management**:

  - Add, edit, and delete user accounts.
  - Assign user roles (Admin or Warehouse Staff).

- **Product Management**:

  - Add new products with detailed information, such as SKU, name, description, category, stock quantity, and minimum stock level.
  - Update or delete product information as needed.

- **Transaction Management**:

  - View and approve inbound/outbound transactions.
  - Track transactions by type, product, and time to monitor warehouse status.

- **Transaction History Management**:

  - Track transaction history to gain an overview of warehouse operations.

- **Supplier Management**:

  - Add, edit, and delete supplier information.

- **Reports and Analytics**:
  - View detailed inventory reports to identify products that are out of stock or need replenishment.
  - Display statistical charts of inbound/outbound history and inventory status.

### 2. Mobile Application Features (For Warehouse Staff)

The mobile application supports warehouse staff in managing daily tasks, helping to increase work efficiency and reduce errors:

- **Login**:

  - Secure login for staff members with personal accounts.

- **Barcode Scanning**:

  - Quickly scan product barcodes for inbound or outbound operations.

- **Inbound Operations**:

  - Record the quantity of products added to the warehouse after scanning the barcode, with optional notes for the transaction.

- **Outbound Operations**:

  - Confirm outbound operations by scanning the barcode and recording product quantities.

- **Inventory Check**:

  - Perform inventory checks, recording and reconciling actual quantities.

- **Product Information**:
  - Display detailed product information, including name, SKU, description, and current stock quantity after scanning.

> **Note:** The notification feature will be integrated in future versions.

## Technologies Used

- **Frontend Mobile**: Flutter
- **Frontend Web**: ReactJS
- **Backend**: NestJS
- **Database**: MongoDB
