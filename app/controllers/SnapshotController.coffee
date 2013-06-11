MM = require('MentorMe')
IntroView = require('views/snapshot/IntroView')
SelfAssessView = require('views/snapshot/SelfAssessView')
InteractiveQuizView = require('views/snapshot/InteractiveQuizView')

module.exports = class SnapshotController extends Marionette.Controller

  initialize: (options) ->
    console.log 'SnapshotModule:Controller:initialize'
    @region = options.region
    @model = options.model

    introView = @showIntro()
    introView.on "start", =>
      selfAssess = @startSelfAssess()
      selfAssess.on "complete", =>
        interactiveQuiz = @startInteractiveQuiz()
        interactiveQuiz.on "complete", =>
          MM.router.navigate("mentees/" + @model.id + "/tools", true)


  showIntro: ->
    view = new IntroView()
    @region.show(view)

  startSelfAssess: ->
    view = new SelfAssessView(@model)
    @region.show(view)

  startInteractiveQuiz: ->
    view = new InteractiveQuizView(@model)
    @region.show(view)