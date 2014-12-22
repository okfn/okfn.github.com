var fs   = require('fs');
var yaml = require('js-yaml');
var yamlFront = require('yaml-front-matter');

module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    curl: {},
    imagemin: {
      options: {
        optimizationLevel: 3,
        progressive: true
      },
      projects: {
        files: [{
          expand: true,                  // Enable dynamic expansion
          cwd: 'img/projects',                   // Src matches are relative to this path
          src: ['*'],   // Actual patterns to match
          dest: 'img/projects'                  // Destination path prefix
        }]
      }
    }
  });

  // Load the plugins
  grunt.loadNpmTasks('grunt-curl');
  grunt.loadNpmTasks('grunt-contrib-imagemin');

  // Default task(s).
  grunt.registerTask('default', []);
    
  grunt.registerTask('dist', 'prepare site for distribution', function() {
    // run all the tasks in order  
    grunt.task.run(['projectimg', 'imagemin']);
  });
  
  grunt.registerTask('projectimg', 'generate json list of project images', function(arg) {
    // reads yaml frontmatter from each jekyll post in the projects folder
    var dirpath = "projects/_posts";
    var filenames = fs.readdirSync(dirpath);
    var imageurls = {};
    var projectlist = [];
    filenames.map(function(filename){
      // read frontmatter
      var fileyaml = yamlFront.loadFront(fs.readFileSync(dirpath + "/" + filename, 'utf8')); 
      // check if imageurl exists
      if (fileyaml.imageurl){ 
        // check if external image url
        if (fileyaml.imageurl.indexOf("http") >= 0 ){
            imageurls["img/projects/"+fileyaml.slug] = fileyaml.imageurl;
            projectlist[projectlist.length] = fileyaml.slug;
        }
      }
    });
    fs.writeFileSync("_data/projectimgs.json", JSON.stringify(projectlist), 'utf8');
    grunt.config('curl', imageurls);
  });

};
