# Created by Amit on 18/3/14.
gulp = require 'gulp'
gulpUtil = require 'gulp-util'
coffee = require 'gulp-coffee'
connect = require 'gulp-connect'
jade = require 'gulp-jade'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'
bower = require 'gulp-bower'
watch = require 'gulp-watch'
cssmin = require 'gulp-cssmin'
connect = require 'gulp-connect'
jshint = require 'gulp-jshint'
plumber = require 'gulp-plumber'
livereload = require 'gulp-livereload'
rename = require 'gulp-rename'


sources =
  libjsfiles:['vendor/lodash.js', 'vendor/jquery-2.1.0.js', 'vendor/angular/js/angular.js', 'vendor/angular/js/ng-table.js', 'vendor/angular/js/angular-resource.js', 'vendor/angular/js/angular-ui-router.js', 'vendor/bootstrap/js/froogaloop2.min.js', 'vendor/bootstrap/js/analytics.js', 'vendor/bootstrap/js/modernizr.min.js', 'vendor/bootstrap/js/jquery.easing.1.3.js', 'vendor/bootstrap/js/jquery.cookie.js', 'vendor/bootstrap/js/jquery.appear.js', 'vendor/bootstrap/js/jquery.isotope.js', 'vendor/bootstrap/js/masonry.js', 'vendor/bootstrap/js/bootstrap.min.js', 'vendor/bootstrap/js/jquery.magnific-popup.min.js', 'vendor/bootstrap/js/owl.carousel.min.js', 'vendor/bootstrap/js/jquery.stellar.min.js', 'vendor/bootstrap/js/jquery.knob.js', 'vendor/bootstrap/js/jquery.backstretch.min.js', 'vendor/bootstrap/js/jquery.superslides.min.js', 'vendor/bootstrap/js/styleswitcher.js', 'vendor/bootstrap/js/mediaelement-and-player.min.js', 'vendor/bootstrap/js/jquery.themepunch.plugins.min.js', 'vendor/bootstrap/js/jquery.themepunch.revolution.min.js', 'vendor/bootstrap/js/slider_revolution.js', 'vendor/bootstrap/js/scripts.js', 'vendor/bootstrap/js/bootstrap1.min.js', 'vendor/bootstrap/js/jquery.bootstrap.wizard.js', 'vendor/bootstrap/js/jquery.metisMenu.js', 'vendor/bootstrap/js/jquery.dataTables.js', 'vendor/bootstrap/js/dataTables.bootstrap.js', 'vendor/fuelux/js/loader.min.js','vendor/calender/js/responsive-calendar.js']
  libcssfiles:['vendor/bootstrap/css/css.css', 'vendor/bootstrap/css/bootstrap.min.css', 'vendor/bootstrap/css/font-awesome.css', 'vendor/bootstrap/css/owl.carousel.css', 'vendor/bootstrap/css/owl.theme.css', 'vendor/bootstrap/css/owl.theme.css', 'vendor/bootstrap/css/owl.transitions.css', 'vendor/bootstrap/css/magnific-popup.css', 'vendor/bootstrap/css/animate.css', 'vendor/bootstrap/css/superslides.css', 'vendor/bootstrap/css/settings.css', 'vendor/bootstrap/css/essentials.css', 'vendor/bootstrap/css/layout.css', 'vendor/bootstrap/css/layout-responsive.css', 'vendor/bootstrap/css/yellow.css', 'vendor/bootstrap/css/dataTables.bootstrap.css', 'vendor/fuelux/css/fuelux.css', 'vendor/fuelux/css/fuelux-responsive.css','vendor/calender/css/responsive-calendar.css','vendor/angular/css/ng-table.css']
  coffee: ['src/coffee/**/*.coffee','!src/coffee/app.coffee']
  jade:['src/jade/**/*.jade']
  css:['src/css/**/*.css']

gulp.task 'connect', connect.server({
  root: ['build/html','build/js','build/css','build/other']
  port: 4444
  liveReload: true
})

gulp.task 'coffee', ->
  gulp.src('src/coffee/app.coffee')
    .pipe watch (files) ->
      files.pipe(plumber())
      .pipe(coffee({bare: true}))
      .pipe(uglify({mangle:false}))
      .pipe(rename({ suffix: '.min' }))
      .pipe(gulp.dest('build/js/'))
  watch {glob: sources.coffee, emit:'all'}, (files) ->
    files.pipe(plumber())
    .pipe(coffee({bare: true}))
    .pipe(uglify({mangle:false}))
    .pipe(concat('all.min.js'))
    .pipe(gulp.dest('build/js/'))
  return

gulp.task 'script', ->
  watch {glob: sources.libjsfiles}, (files) ->
    files.pipe(plumber())
    .pipe(uglify())
    .pipe(concat('lib.min.js'))
    .pipe(gulp.dest('build/js/'))

gulp.task 'bootstrap', ->
  gulp.src('vendor/bootstrap/fonts/*.*')
  .pipe(gulp.dest('build/other/fonts/'))
  watch {glob: ['vendor/bootstrap/images/*.*','vendor/fuelux/images/*.*','src/images/*.*']}, (files) ->
    files.pipe(plumber())
    .pipe(gulp.dest('build/other/images/'))

gulp.task 'jade',->
  watch {glob: sources.jade}, (files) ->
    files.pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest('build/html/'))

gulp.task 'vendor/bootstrap/cssmin', ->
  watch {glob: sources.css}, (files) ->
    files.pipe(plumber())
    .pipe(cssmin())
    .pipe(concat('all.min.css'))
    .pipe(gulp.dest('build/css/'))
  watch {glob: sources.libcssfiles}, (files) ->
    files.pipe(plumber())
    .pipe(cssmin())
    .pipe(concat('lib.min.css'))
    .pipe(gulp.dest('build/css/'))

gulp.task 'default', ['vendor/bootstrap/cssmin','coffee','bootstrap', 'jade', 'connect', 'script'], ->
  console.log 'gulp started..'