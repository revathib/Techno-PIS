app.controller 'AddShiftCtrl', ($scope, Shifts, $location) ->
  $scope.createShift = ->
    Shifts.add $scope
    $location.path('/admin/showShifts')

app.factory 'Shifts', ->
  shifts = [
    {
      id:"1"
      name:"abc"
      description:"fdhgdth"
    }
    {
      id:"2"
      name:"xyz"
      description:"fdhgdth"
    }
  ]

  pick_shifts = (s) -> _.pick s, ['name', 'description']
  get: (id) -> shift[id]
  index: -> shifts
  update: (s) -> _.assign (get s.id), (pick_shifts s)
  add: (s) -> shifts.push (_.assign { id: shifts.length }, (pick_shifts s))
