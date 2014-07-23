require.config({
    baseUrl: '/lib',
    packages: [
      {
        name: 'cs',
        location: '.',
        main: 'cs'
       },{
        name: 'less',
        location: '.',
        main: 'less'
      },{
        name: 'coffee-script',
        location: '.',
        main: 'coffee-script'
      },{
        name: 'text',
        location: '.',
        main: 'text'
      }
    ]
});

require(['app']);

