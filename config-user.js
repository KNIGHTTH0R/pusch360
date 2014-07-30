require.config({
    baseUrl: '/lib',
    packages: [
      {
        name: 'cs',
        location: '.',
        main: 'cs'
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

require(['cs!UserApp']);
