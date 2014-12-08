This is jekyll-based site for running <http://okfnlabs.org/>.

## Adding a Blog Post

See <http://okfnlabs.org/blog/add/>

## Adding your member information

See <http://okfnlabs.org/members/signup/>

## Running Website Locally ##
For developers:

Clone the repository (making your own fork is recommended), requires Git and Jekyll
```bash
git clone https://github.com/okfn/okfn.github.com.git
cd okfn.github.com
jekyll serve -w
```

Building project images, requires NodeJS and NPM
```bash
sudo npm install -g grunt-cli
cd okfn.github.com
npm install
grunt dist
```
