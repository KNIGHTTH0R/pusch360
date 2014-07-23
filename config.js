require.config({
  baseUrl: '/bower_components',
    paths: {
        jquery: "jquery/dist/jquery",
        "jquery.ui": "jquery-ui/jquery-ui",
        backbone: "backbone-amd/backbone",
        underscore: "underscore-amd/underscore",
    },
    packages: [
      {
        name: 'cs',
        location: 'require-cs',
        main: 'cs'
       },{
        name: 'less',
        location: 'require-less',
        main: 'less'
      },{
        name: 'coffee-script',
        location: 'coffee-script',
        main: 'index'
      },{
        name: 'text',
        location: 'requirejs-text',
        main: 'text'
      }
    ]
});

require(['cs!/lib/App.coffee']);

