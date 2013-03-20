LoginView = require 'views/LoginView'

describe 'LoginView', ->
  beforeEach ->
    @view = new LoginView
    @view.render()
  it 'should render two inputs',  ->
    expect(@view.$el.find 'input').to.have.length 2