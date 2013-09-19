describe '{%= name %} Tests', ->

  {%= name %} = require '{%= name %}'

  it 'Should be a class', (done)->
    instance = new {%= name %}()
    expect( instance instanceof {%= name %}).to.equal( true )
    done()

  it 'Should be awesome', ( done )->
    instance = new {%= name %}()
    expect( instance.awesome() ).to.equal( 'awesome' )
    done()

  it 'using chai assert should be awesome', ( done )->
    instance = new {%= name %}()
    assert( instance.awesome() is 'awesome', 'Should be awesome yo!')
    done()