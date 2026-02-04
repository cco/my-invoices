#let money(n) = {
  let rounded = calc.round(n * 100) / 100
  let s = str(rounded)

  if s.contains(".") {
    let parts = s.split(".")
    let frac = parts.at(1)
    if frac.len() == 1 {
      "$" + s + "0"
    } else {
      "$" + s
    }
  } else {
    "$" + s + ".00"
  }
}

#let conf(
  title: "Invoice",
  date: none,
  invoice: (), 
  items: (),   
  abstract: [],
  doc,
) = {
  
  // Document formatting.
  set page(
    paper: "us-letter",
    header: align(right + horizon, title),
    margin: (top: 1.25in, rest: .25in)
  )
  set par(justify: true)
  set text(font: "Noto Sans", size: 11pt)

  // Biller and client information in header.
  place(
    top,
    float: true,
    scope: "parent",
    clearance: 2em,
    {
      let count = invoice.len()
      let ncols = calc.min(count, 3)

      block(text(weight: "bold", date))
      v(1em)

      grid(
        columns: (1fr,) * ncols,
        row-gutter: 24pt,
        ..invoice.enumerate().map(((i, inv)) => [
          #text(weight: "bold",
            if i == 0 [Biller]
            else if i == 1 [Client]
            else [Contact]
          ) \
          #inv.name \
          #inv.business \
          #link("mailto:" + inv.email)
        ]),
      )
    
      v(1em)
      par(justify: false)[
        *Description* \
        #abstract
      ]

      v(2em)

      // Iterate line item array and calculate totals.
      if items.len() > 0 {
        table(
          columns: (1fr, auto, auto),
          inset: 10pt,
          stroke: (x, y) =>
            if y == 0 { (bottom: 1pt + black) }
            else { (bottom: 0.5pt + gray) },
          align: (left, center, right),

          [*Service Rendered*], [*Hours*], [*Total Cost*],

          ..items.map(item => (
            item.service,
            str(item.hours),
            money(item.hours * item.rate)
          )).flatten(),

          table.cell(colspan: 2, align: right)[*Grand Total:*],
          [*#money(items.map(i => i.hours * i.rate).sum())*]
        )
      }
    }
  )

  doc
}
