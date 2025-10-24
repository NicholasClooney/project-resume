#let cv = yaml("../data/cv.yaml")

#set page(
  paper: "a4",
  margin: (top: 1.5cm, bottom: 1.5cm, left: 2cm, right: 2cm),
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 11pt,
)

#show heading.where(level: 1): it => block[
  #set text(size: 22pt, weight: "bold")
  #set par(leading: 1.1em)
  #upper(it.body)
]

#show heading.where(level: 2): it => block[
  #set text(size: 12pt, weight: "semibold", tracking: 0.02em)
  #set par(spacing: 0.8em)
  #smallcaps(it.body)
  #rect(width: 100%, stroke: (paint: luma(0.8), thickness: 0.35pt))
]

#let gap = v(0.8em)

#let tag(label) = box(
  inset: (x: 0.4em, y: 0.2em),
  stroke: (paint: luma(0.85)),
  radius: 0.2em,
  text(
    size: 9pt,
    weight: "medium",
    fill: luma(0.4),
  )[label],
)

#let experience_entry(role) = block[
  #set par(spacing: 0.5em)
  #text(weight: "bold")[#role.title] #h(0.6em) #text(fill: luma(0.5))[#role.company]
  #text(size: 10pt, fill: luma(0.55))[#role.startDate – #role.endDate]
  #par(role.summary)
  #list(
    tight: true,
    spacing: 0.3em,
    ..role.achievements.map(it => [#par(it)]),
  )
]

#let project_entry(project) = block[
  #text(weight: "bold")[#project.name] #h(0.6em) #link(project.url)[#project.url]
  #par(project.description)
]

#let skill_group(group) = block[
  #text(weight: "semibold")[#group.label]
  #v(0.3em)
  #grid(columns: 2, column-gutter: 0.6em)[
    #for item in group.items {
      tag(item)
    }
  ]
]

#let resume_section(title, body) = block[
  #heading(level: 2)[#title]
  #body
]

= #cv.name

#set text(size: 10pt, fill: luma(0.4))
#cv.contact.email #h(0.5em) #sym.bullet #h(0.5em) #cv.contact.phone #h(0.5em) #sym.bullet #h(0.5em) #link(cv.contact.website)[#cv.contact.website]

#set text(size: 11pt, fill: luma(0.1))

#gap

#resume_section("Professional Summary")[
  #par(cv.summary)
]

#resume_section("Skills")[
  #grid(columns: 2, column-gutter: 1.2em, align: top)[
    #for group in cv.skills {
      skill_group(group)
    }
  ]
]

#resume_section("Experience")[
  #stack(spacing: 1.4em)[
    #for role in cv.experience {
      experience_entry(role)
    }
  ]
]

#resume_section("Open Source Projects")[
  #stack(spacing: 1em)[
    #for project in cv.openSourceProjects {
      project_entry(project)
    }
  ]
]

#resume_section("Interests")[
  #grid(columns: 3, column-gutter: 1em)[
    #for interest in cv.interests {
      tag(interest)
    }
  ]
]
