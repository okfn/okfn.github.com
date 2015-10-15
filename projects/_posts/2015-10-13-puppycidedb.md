 ---
 layout: project
 title: Puppycide Database Project
 slug: puppycidedb
 permalink: /projects/puppycidedb/index.html

 type: [data, webapp, running service]
 author: Puppycide Database Project
 maintainers: jaydubya
 contributors: jaydubya
 featured: yes
 github_user: puppycidedb
 github_repo: pdb-database
 helpwanted: yes
 typeofhelp: [coding, data analysis, documenting, blogging, evangelism, project managing]
 imageurl: https://pbs.twimg.com/profile_images/512989733039792131/lVEJbvP__200x200.jpeg
 language: [php, javascript, python, nodejs]
 projecturl: https://puppycidedb.com
 stage: production
 tags: [sql, Visualization]
 tagline: The Puppycide Database Project researches and records killings of animals by police across the United States with the help of open source applications & crowd sourced research.
 ---

 `Puppycide Database Project` is the largest public compilation of records related to killings of animals by police in the United States. The failure of US law enforcement to make records of lethal force available to the public has become a widely documented issue over the last few years. Despite the publicity, the issue remains unresolved at all levels of government - state, municipal and federal - leaving a small number of private, non-profit organizations to provide such basic information as human fatalities to researchers and journalists. The `Puppycide Database Project` is one such organization. 
 
 At present, the project relies on crowd-sourcing, and has developed several forms to record data and allow volunteers to encode existing database records for the purpose of Krippendorff's alpha calculation. New records get announced via social media. We also provide a [rapidly-growing library of legal documents & research](https://puppycidedb.com/datasets.html) related to police use of force issues - everything from lawsuit decisions to CDC emergency room admissions. 
 
 All of the core functionality for our project relies on open source applications. Some examples:
 
 * Full text search capability using [Sphinx](https://github.com/sphinxsearch/sphinx)
 * Blog platform using [ghost/nodejs](https://github.com/TryGhost/Ghost)
 * Twitter connectivity using [Codebird](https://github.com/jublonet/codebird-php)
 
 Our biggest upcoming code project is the customization and implementation of a web crawler in order to accelerate the growth of our database. The crawler will seek and retrieve pages related to police use of force. In addition to adding more puppycide records, we will use the resulting information to study how news organizations report on issues of lethal force. This upcoming project could really use the input and advice of skilled developers and admins. Our biggest challenge is how to most effectively use the (very small) amount of resources available to us.