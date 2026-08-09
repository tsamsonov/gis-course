#let project(title: "", subtitle: none, authors: (), abstract: none, body) = {
  // Настройки страницы
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
    header: align(right, text(8pt, fill: gray, title)),
    // ИСПРАВЛЕНИЕ: Добавлен context для корректного отображения номеров страниц
    footer: context [
      #align(center, text(10pt, counter(page).display("1")))
    ]
  )
  
  // Языковые и шрифтовые настройки
  set text(font: "Liberation Serif", size: 11pt, lang: "ru")
  
  // Настройки заголовков
  set heading(numbering: "1.1")
  show heading: it => {
    v(0.5em)
    it
    v(0.5em)
  }

  // Титульная страница
  align(center + horizon)[
    #text(24pt, weight: "bold", title)
    #if subtitle != none [
      #v(0.3cm)
      #text(14pt, subtitle)
    ]
    #v(1cm)
    #for author in authors [
      #text(12pt, author.name)
      #if author.affiliation != "" [
        #text(10pt, author.affiliation)
      ]
    ]
  ]

  pagebreak()

  // Оглавление
  outline(depth: 3, indent: 1.5em)
  pagebreak()

  body
}

