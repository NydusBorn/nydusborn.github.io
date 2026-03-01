#import "@preview/basic-resume:0.2.9": *
#import "en_data.typ": *
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

== Skills
- *Languages:* Russian (Native), English (\~B)
- *Containers:* Docker, Docker‑Compose
- *Frontend:* Vue, Nuxt, Blazor
- *Backend:* FastAPI
- *Programming Languages:* C\#, Python, JS/TS
- *General:* Github

== Education

#edu(
  institution: "Tver State Technical University",
  location: data.location,
  dates: dates-helper(start-date: "Sept 2025", end-date: "June 2027"),
  degree: "Master's Degree, Software Engineering",
)

#edu(
  institution: "Tver State Technical University",
  location: data.location,
  dates: dates-helper(start-date: "Sept 2021", end-date: "June 2025"),
  degree: "Bachelor's Degree, Software Engineering",
)

== Work Experience

#work(
  title: "Full-Stack Developer",
  location: data.location,
  company: "DKC",
  dates: dates-helper(start-date: "June 2024", end-date: "July 2025"),
)
- Designed and delivered a full‑stack platform for electronic schematic processing (frontend SPA, FastAPI backend, AI‑driven detection/classification).
- Built end‑to‑end data pipeline: dataset creation → annotation in Label Studio → augmentation → model training.
- Implemented containerized deployment Docker‑Compose + Caddy) with a unified backend container to manage heavy dependencies (e.g., PyTorch), enabling scalable and maintainable releases.

#line(length: 100%)

This document is an abridged version of my resume, designed to fit on a single page. For a more detailed version, please visit my #link(data.website)[website].