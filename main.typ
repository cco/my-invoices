#import "/templates/invoice.typ": conf
// Set your date, invoice numbering, and work description here.
#let invoice_date = "February 4, 2026"
#let invoice_number = "INV-26-A0001"
#let work_summary = "Project work for the Q1 system migration."


#show: doc => conf(
  title: invoice_number,
  date: invoice_date,
  // Add your billing and client information.
  invoice: (
    (name: "Jane Doe", business: "Big Brain Industries LLC", email: "jane@bigbrainindustries.com"),
    (name: "John Smith", business: "Smug Cat Law Firm", email: "john@smugcatlawfirm.com"),
  ),
  // Add your line items to the invoice.
  items: (
    (service: "Database Migration", hours: 6, rate: 80),
    (service: "Inventory Cleanup", hours: 3, rate: 80),
  ),
  // set your abstract (work summary) here.
  abstract: work_summary,
  doc
)

// Payment terms etc.
== Terms and Conditions
Net 30 Days payment.