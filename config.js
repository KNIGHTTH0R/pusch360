require.config({
  baseUrl: '/bower_components',
    paths: {
        jquery: "jquery/dist/jquery",
        backbone: "backbone-amd/backbone",
        underscore: "underscore-amd/underscore",
        cs: "coffee-script/index"
    },
    packages: [
      {
        name: 'less',
        location: 'require-less',
        main: 'less'
      },{
        name: 'coffee-script',
        location: 'require-cs',
        main: 'coffee-script'
      },{
        name: 'text',
        location: 'requirejs-text',
        main: 'text'
      }
    ]
});

require(['cs!/lib/main.coffee']);
