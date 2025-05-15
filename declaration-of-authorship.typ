#import "locale.typ": *

#let declaration-of-authorship(
  authors,
  title,
  declaration-of-authorship-content,
  date,
  language,
  many-authors,
  at-university,
  city,
  date-format,
) = {
  v(2em)
  text(size: 20pt, weight: "bold", DECLARATION_OF_AUTHORSHIP_TITLE.at(language))
  v(1em)

  if (declaration-of-authorship-content != none) {
    declaration-of-authorship-content
  } else {
    if (authors.len() == 1) {
      par(justify: true, DECLARATION_OF_AUTHORSHIP_SECTION_A_SINGLE)
      v(1em)
      align(center, text(weight: "bold", title))
      v(1em)
      par(justify: true, DECLARATION_OF_AUTHORSHIP_SECTION_B_SINGLE)
    } else {
      par(justify: true, DECLARATION_OF_AUTHORSHIP_SECTION_A_PLURAL)
      v(1em)
      align(center, text(weight: "bold", title))
      v(1em)
      par(justify: true, DECLARATION_OF_AUTHORSHIP_SECTION_B_PLURAL)
    }
  }

  let end-date = if (type(date) == datetime) {
    date
  } else {
    date.at(1)
  }

  v(2em)
  if (at-university) {
    text(city + [, ] + end-date.display(date-format))
  } else {
    let authors-by-city = authors.map(author => author.company.city).dedup()

    text(authors-by-city.join(", ", last: AND.at(language)) + [ ] + end-date.display(date-format))
  }

  v(1em)
  if (many-authors) {
    grid(
      columns: (1fr, 1fr),
      gutter: 20pt,
      ..authors.map(author => {
       v(1em)
       "gez. "
        author.name
      })
    )
  } else {
    for author in authors {
      v(1em)
    "gez. "
      author.name
    }
  }
}
