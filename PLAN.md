Below are the instructions for an AI agent to create a data-driven CV template using 11ty and CSS, with the content managed in a YAML file. The final output should replicate the provided CV image, formatted for A4 paper size with well-chosen fonts and a predominantly left-aligned layout, except for dates.

### **Project Goal**

To create a CV generator using the static site generator 11ty. The CV's content will be sourced from a YAML file, and its appearance will be styled with CSS to match the provided example. The final output will be an HTML page styled to look like an A4 document.

### **Core Technologies**

*   **11ty (Eleventy):** A simpler static site generator.
*   **YAML:** A human-readable data serialization language.
*   **Nunjucks:** A templating engine (used by default in 11ty) to render the data into HTML.
*   **CSS:** For styling the CV to A4 size and matching the visual layout.

---

### **Step-by-Step Implementation Guide**

#### **1. Project Setup and Dependencies**

First, set up a new project and install the necessary npm packages.

*   **Initialize a new Node.js project:**
    ```bash
    mkdir 11ty-cv-template
    cd 11ty-cv-template
    npm init -y
    ```

*   **Install 11ty and the YAML parser:**
    ```bash
    npm install @11ty/eleventy js-yaml --save-dev
    ```

#### **2. Configure 11ty to Support YAML**

You need to tell 11ty how to process `.yml` or `.yaml` files. Create a configuration file for 11ty.

*   **Create a file named `.eleventy.js` in the root of your project and add the following code:**
    ```javascript
    const yaml = require("js-yaml");

    module.exports = function(eleventyConfig) {
      eleventyConfig.addDataExtension("yaml", contents => yaml.load(contents));
      eleventyConfig.addPassthroughCopy("css");
    };
    ```
    This configuration does two things:
    1.  It tells 11ty to use the `js-yaml` library to parse any files with a `.yaml` extension in the `_data` directory.
    2.  It copies the `css` directory to the output folder (`_site`) so the stylesheet can be linked.

#### **3. Structure Your Project Directory**

Organize your files and folders as follows to keep the project clean:

```
11ty-cv-template/
├── .eleventy.js
├── _data/
│   └── cv.yaml
├── _includes/
│   └── layout.njk
├── css/
│   └── style.css
├── index.njk
└── package.json
```

#### **4. Create the Data Source (`cv.yaml`)**

This file will contain all the content for your CV. Populate `_data/cv.yaml` with the data from the example CV.

```yaml
name: "Chris Burnell"
contact:
  email: "me@chrisburnell.com"
  phone: "+1 902 580-3688"
  website: "chrisburnell.com"
summary: "Front End Developer and Software Engineer with 17 years of experience, specialising in CSS, design systems, developer relations and education, and technical writing and speaking. Passionate about the open web, having published over 150 technical articles, and author of open-source software used by thousands of developers worldwide. Actively involved in the web community with many years of experience in organising conferences and meet-ups."
professionalExperience:
  - title: "Software Engineer"
    company: "Squizz"
    location: "London, UK"
    startDate: "Jan. 2023"
    endDate: "Dec. 2023"
    responsibilities:
      - "Built, maintained, and published a library of React components to enable developers to build accessible and customised client websites quickly that have been fully-tested and are production-ready."
      - "Responsible for keeping track of web standards and keeping my team up-to-date on how we can leverage stable, new technologies to simplify and enhance the library of components."
  - title: "Lead Developer & Chapter Lead"
    company: "Squizz"
    location: "London, UK"
    startDate: "May 2022"
    endDate: "Jan. 2023"
    responsibilities:
      - "Lead Developer and primary technical contact for 8 key clients, defining their complete technical implementation and standard of quality, with a focus on higher-education and government websites."
      - "Formulated learning packages as Chapter Lead to grow the front end knowledge of over 30 developers, which catalysed adoption of best practices and expertise."
      - "Managed a team of two developers, enabling them to pursue and succeed in career goals and"
communityExperience:
  - title: "Conference Organiser"
    organization: "State of the Browser"
    startDate: "May 2018"
    endDate: "present"
    responsibilities:
      - "Organised 8 annual, not-for-profit conferences, showcasing over 60 speakers with 150+ in-person attendees each year."
      - "Liaised with speakers, sponsors, venues, and handled the logistics of running an in-person and online conference."
      - "Sourced sponsorship to fund the events and enable under-represented groups to attend for free."
      - "Built and maintained the conference websites, including a design refresh in 2018 and codebase refresh in 2021, as well as extensive work with APIs to automate many organisational tasks for the conference."
  - title: "Technical Writer & Software Author"
    organization: "chrisburnell.com"
    startDate: "2013"
    endDate: "present"
    responsibilities:
      - "Launched a blog about web development in 2008 and have published 25 web projects and over 150 technical articles about accessibility, design systems, CSS, JavaScript, and thoughts on the web."
      - "Author of numerous open-source software packages, accumulating over 46,000 downloads and having been used on many enterprise client websites across my professional career, including CSS libraries, design system tools, and native web components."
```

#### **5. Create the Base Layout (`_includes/layout.njk`)**

This file will be the main HTML structure for your CV page.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ cv.name }} - CV</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="page">
        {{ content | safe }}
    </div>
</body>
</html>
```

#### **6. Create the Main CV Template (`index.njk`)**

This file will pull the data from `cv.yaml` and structure the CV content. It uses the Nunjucks templating language to loop through the experience sections.

```nunjucks
---
layout: layout.njk
---

<header>
    <h1>{{ cv.name }}</h1>
    <div class="contact-info">
        <span>{{ cv.contact.email }}</span>
        <span>{{ cv.contact.phone }}</span>
        <span>{{ cv.contact.website }}</span>
    </div>
</header>

<section class="summary">
    <p>{{ cv.summary }}</p>
</section>

<section class="professional-experience">
    <h2>Professional Experience</h2>
    {% for job in cv.professionalExperience %}
    <div class="job">
        <div class="job-header">
            <h3>{{ job.title }} &middot; {{ job.company }} &middot; {{ job.location }}</h3>
            <span class="dates">{{ job.startDate }} – {{ job.endDate }}</span>
        </div>
        <ul>
            {% for item in job.responsibilities %}
            <li>{{ item }}</li>
            {% endfor %}
        </ul>
    </div>
    {% endfor %}
</section>

<section class="community-experience">
    <h2>Community Experience</h2>
    {% for role in cv.communityExperience %}
    <div class="role">
        <div class="role-header">
            <h3>{{ role.title }} &middot; {{ role.organization }}</h3>
            <span class="dates">{{ role.startDate }} – {{ role.endDate }}</span>
        </div>
        <ul>
            {% for item in role.responsibilities %}
            <li>{{ item }}</li>
            {% endfor %}
        </ul>
    </div>
    {% endfor %}
</section>
```

#### **7. Style the CV with CSS (`css/style.css`)**

This CSS will style the HTML to match the provided image, including A4 sizing and font choices. Good font choices for a CV include sans-serif fonts like Roboto, Arial, or Calibri for readability.

```css
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

body {
    background-color: #f0f0f0;
    font-family: 'Roboto', sans-serif;
    color: #333;
    line-height: 1.6;
    margin: 0;
    padding: 2rem;
}

.page {
    background: white;
    width: 210mm;
    height: 297mm;
    margin: 0 auto;
    padding: 20mm;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

h1 {
    font-size: 2.5rem;
    margin-bottom: 0.5rem;
    font-weight: 700;
}

h2 {
    font-size: 1.5rem;
    border-bottom: 2px solid #ddd;
    padding-bottom: 0.5rem;
    margin-top: 2rem;
    margin-bottom: 1.5rem;
    font-weight: 500;
}

h3 {
    font-size: 1.1rem;
    margin: 0;
    font-weight: 700;
}

.contact-info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 2rem;
    color: #555;
}

.job-header, .role-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
}

.dates {
    text-align: right;
    font-weight: 500;
    color: #555;
}

ul {
    padding-left: 20px;
    list-style-type: disc;
}

li {
    margin-bottom: 0.5rem;
}

a {
    color: #007bff;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

/* Print specific styles */
@media print {
    body {
        background-color: white;
        padding: 0;
    }

    .page {
        box-shadow: none;
        margin: 0;
        padding: 0;
    }
}
```

#### **8. Run 11ty and View the Result**

You are now ready to build and serve your CV.

*   **Run the 11ty development server:**
    ```bash
    npx @11ty/eleventy --serve
    ```

*   **Open your browser** and navigate to `http://localhost:8080`. You should see the CV rendered with the data from your `cv.yaml` file, styled to look like the example.

This set of instructions provides a complete workflow for another AI agent to create the requested CV template. The agent will have all the necessary code, file structures, and commands to complete the task successfully.
