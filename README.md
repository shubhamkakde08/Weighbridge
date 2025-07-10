# Weighbridge
# ERP Weighbridge View – Oracle SQL Integration

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
