Bun.serve({
    async fetch(req) {
      return new Response(JSON.stringify({ 
        username: req.headers.get('X-Auth-Username'),
        userId: req.headers.get('X-Auth-ID') 
      }))
    },
    port: 8081
  })