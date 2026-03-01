#import "@preview/basic-resume:0.2.9": *
#import "ru_data.typ": *
// Put your personal information here, replacing mine
#let name = data.name


#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  location: data.location,
  email: data.email,
  github: data.github,
  linkedin: data.telegram,
  personal-site: data.website,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
)

/*
 * Lines that start with == are formatted into section headings
 * You can use the specific formatting functions if needed
 * The following formatting functions are listed below
 * #edu(dates: "", degree: "", gpa: "", institution: "", location: "")
 * #work(company: "", dates: "", location: "", title: "")
 * #project(dates: "", name: "", role: "", url: "")
 * #extracurriculars(activity: "", dates: "")
 * There are also the following generic functions that don't apply any formatting
 * #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
 * #generic-one-by-two(left: "", right: "")
 */

== Навыки
- *Языки:* Русский (Родной), Английский (\~B)
- *Контейнеры:* Docker, Docker‑Compose
- *Frontend:* Vue, Nuxt, Blazor
- *Backend:* FastAPI
- *Языки программирования:* C\#, Python, JS/TS
- *Общие:* Github

== Образование

#edu(
  institution: "Тверской Государственный Технический Университет",
  location: data.location,
  dates: dates-helper(start-date: "Сен. 2025", end-date: "Июнь 2027"),
  degree: "Магистр, Программная Инженерия",
)

#edu(
  institution: "Тверской Государственный Технический Университет",
  location: data.location,
  dates: dates-helper(start-date: "Сен. 2021", end-date: "Июнь 2025"),
  degree: "Бакалавр, Программная Инженерия",
)

== Опыт работы

#work(
  title: "Full-Stack Разработчик",
  location: data.location,
  company: "DKC",
  dates: dates-helper(start-date: "Июнь 2024", end-date: "Июль 2025"),
)
- Разработал и реализовал Full-Stack платформу для обработки электронных схем (SPA-интерфейс, бэкенд на FastAPI, ИИ‑детекция/классификация).
- Создал end-to-end пайплайн данных: формирование датасета → разметка в Label Studio → аугментация → обучение моделей.
- Внедрил контейнеризованный деплой (Docker-Compose + Caddy) с объединённым бэкенд‑контейнером для управления тяжёлыми зависимостями (например, PyTorch), что обеспечивает масштабируемость и поддерживаемость релизов.

#line(length: 100%)

Данный документ представляет собой сокращённую версию моего резюме, разработанную для размещения на одной странице. Для более подробной версии, пожалуйста, посетите мой #link(data.website)[сайт].