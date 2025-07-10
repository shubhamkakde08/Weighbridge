# Weighbridge
# ERP Weighbridge View – Oracle SQL Integration

ERP-Weighbridge-View/
├── VIEW_WEIGHBRIDGE_ENGINE.sql     # Oracle SQL View for Weighbridge transactions
└── README.md                       # Project Documentation


## 🚛 Overview

This project provides a specialized **Oracle SQL View** named `VIEW_WEIGHBRIDGE_ENGINE`, designed to extract and analyze Weighbridge transaction data from an ERP system. The view supports comprehensive tracking of vehicle weights, item-level data, transport details, and associated gate or order references.

---

## 📄 File Included

| File Name                   | Description                                      |
|----------------------------|--------------------------------------------------|
| `VIEW_WEIGHBRIDGE_ENGINE.sql` | SQL View for handling weighbridge transaction records |

---

## 📦 Key Features of the View

- **Gross, Tare, and Net Weight Capture** (`firstwt`, `secondwt`, `netwt`)
- **Auto VARAI Calculation** using custom item and account logic:
  ```sql
  CASE
    WHEN container_vehicle THEN NETWT * 80
    WHEN item_code IN (...) THEN NETWT * 160
    WHEN specific account_code THEN NETWT * 40
    ELSE NETWT * 160
  END
Gate Entry Integration – fetches GATE_INDATE and OUTDATE using gate_vrno.

Order and Contract Linkage – connects weighbridge entry to ORDER_BODY for contract and quantity comparison.

Item Master Join – enriches view with item_name, item_group, item_nature, etc.

Used Flag – detects whether weighbridge slip is already used in itemtran_head.

Dynamic Fiscal Year Identification – via acc_year_mast.

Weighbridge Purpose Indicator – derived from view_weighbridge_tcode.

📊 Use Cases
Vehicle in/out weight tracking

Quantity validation vs contract/order

Freight and gate pass verification

Power BI dashboards or Excel reports

Base for automated validations or RPA workflows

🛠️ Technology Stack
Oracle SQL / PL/SQL

ERP Views: view_weighbridge_tran, view_item_mast, gatetran_head, etc.

Custom Logic Integration for transport and freight tracking
