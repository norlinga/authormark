# Authormark ✍️

A ~~modern~~, ~~arcade~~, _different_, highly opinionated publishing platform built with Ruby on Rails 8, designed for long-form technical writing.

**Authormark** is tailored for solo authors who value simplicity, clarity, and total control over their content. Built as a personal project, it combines familiar Rails conventions with tooling like [Liquid](https://shopify.github.io/liquid/) and [Commonmarker](https://github.com/gjtorikian/commonmarker) for dynamic, Markdown-first content authoring. The result is a clean, focused stack that’s ideal for technical essays, guides, and reference material.

---

## 🧱 Tech Stack

- **Rails 8** with Hotwire (Turbo + Stimulus)
- **Commonmarker** for GitHub-Flavored Markdown rendering
- **Liquid** for dynamic content tags (e.g. `{% latest_essays %}`)
- **ActiveStorage** for image uploads, with `libvips` for resizing
- **Tailwind CSS** for styling, including dark mode support
- **Stimulus.js** for client-side interactivity (e.g., topic tagging)
- **Interactor** pattern for business logic
- **Kamal** for containerized deployment
- **Rspec** for comprehensive testing

---

## ✨ Key Features

- **Multi-step Markdown rendering pipeline**
  - Renders Liquid first, then Markdown via Commonmarker
  - Public-facing output is enhanced with Tailwind typography classes
- **Custom Liquid tags**
  - `latest_essays`, `next_in_topic`, and more are available
  - Extensible tag system using a shared Liquid environment
- **Essay–Topic Relationships**
  - Essays can belong to multiple topics
  - Each essay may have one _primary_ topic
  - Stimulus-based UI for dynamic tagging in the admin panel
- **System Pages ("magic essays")**
  - Pages like `index` or `about` are just special essays with a `system_slug`
  - Fully editable like any other content
- **Simple, secure authoring interface**
  - Protected with HTTP basic auth (credentials stored in Rails credentials)
  - Fast and responsive admin backed by Rails and Turbo
- **Image management**
  - Upload images directly in the authoring UI
  - Markdown shortlinks generated for easy pasting
  - Recent image modal (Stimulus-powered) available when editing essays
- **Site settings stored in DB**
  - Cached in memory for fast access
  - Includes global title and footer text

---

## 📁 Code Structure Highlights

- `app/interactors|services/` – all business logic and rendering flows
- `app/liquid/` – custom Liquid tags, loaded via a singleton `LiquidEnv`
- `app/presenters/` – optional UI presentation logic (not yet)
- `app/controllers/authoring/` – everything behind the basic auth wall
- `app/views/authoring/images/` – ActiveStorage-based image upload UI

---

## 🚀 Getting Started

Install dependencies:

```bash
bundle install
yarn install # if needed for Tailwind or Stimulus
bin/rails db:prepare
````

Start the dev server:

```bash
bin/dev
```

Set credentials:

```bash
EDITOR=nano bin/rails credentials:edit
# Add:
# authoring:
#   username: admin
#   password: yourpassword
```

---

## 🧪 Running Tests

```bash
bundle exec rspec
```

Test coverage is emphasized through unit and request specs using RSpec and Shoulda Matchers. A full testing pass includes:

* Essay and Topic validation specs
* Interactor specs for all business logic
* Controller specs for all authoring routes

---

## ⚙️ Deployment

Built for deployment with [Kamal](https://kamal-deploy.io/):

* Uses Docker with `libvips` installed for image processing
* Easy containerized setup via `kamal setup && kamal deploy`

---

## 🧭 Philosophy

* **Content first.** Markdown is the source of truth.
* **Minimalism.** No over-engineering; Hotwire, not React.
* **Stability.** Feature-complete first; polish later.
* **Author-centric.** Admin flows are fast, intuitive, and reliable.

---

## 🛠️ Future Ideas

* Extended site config options (e.g. navigation structure)
* Export formats (PDF, ePub)

---

## 🤝 About This Project

This is a developer-crafted writing platform meant to power its own documentation. Built as a learning and self-publishing exercise, it demonstrates the practical use of:

* Modern Rails 8 idioms
* Liquid and Markdown as a flexible CMS template layer
* Stimulus for seamless dynamic UIs
* Carefully composed service layers

You’re welcome to explore, fork, or adapt it.
