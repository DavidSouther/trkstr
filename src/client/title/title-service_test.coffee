describe 'Trkstr', ->
  describe 'Title Service', ->
    beforeEach module 'trkstr.title-service'

    it 'has a good title', inject (TitleSvc)->
      TitleSvc.title.should.equal 'TrkStr'
