'use strict'

# WIP: Only works for static HTML files for now.

module.exports = (g) ->
  require('matchdep').filterDev('grunt-*').forEach g.loadNpmTasks

  g.initConfig
    shell:
      server:
        command: 'make server'
        options:
          async: true

    watch:
      config:
        files: [
          'config/**/*',
          'public/**/*'
        ]
        tasks: ['shell:server']
        options:
          spawn: true
          interrupt: true
          livereload: true

  g.registerTask 'default', ['shell:server', 'watch:config']
