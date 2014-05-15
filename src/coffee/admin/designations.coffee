app.factory 'Designations', ->
#  departments = _.map _.range(10), (id) ->
#    id: id
#    name: Faker.Lorem.words(2).join ' '
#    description: Faker.Lorem.sentence()

  designations = [
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

  pick_designation = (desig) -> _.pick desig, ['name', 'description']
  get: (id) -> designations[id]
  index: -> designations
  update: (desig) -> _.assign (get desig.id), (pick_designation desig)
  add: (desig) -> designations.push (_.assign { id: designations.length }, (pick_designation desig))
