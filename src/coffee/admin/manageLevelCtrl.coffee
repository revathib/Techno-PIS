app.service 'levelService', ($http) ->

  @createNewLevel = (levelCode,levelName,description) ->
    console.log levelCode
    console.log levelName
    console.log description
    $http
    .post(dbServer + '/addLevel', params : {levelCode:levelCode,levelName:levelName,description:description})
    .success((data, status, headers, config) ->
#      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveLevels = () ->
    console.log "levels fetching.. "
    $http
    .get(dbServer+'/retrieveLevelsList')
    .success((data) ->
      console.log "retrieving levels..."
      return data
    )
    .error((data,status,headers,config) ->
    )
  @updateLevel = (levelID, levelCode ,level,description) ->
    $http
    .post(dbServer + '/updateLevel', params : {levelId:levelID, levelCode:levelCode ,levelName:level,description:description})
    .success((data, status, headers, config) ->
      return data
    )
    .error((data, status, headers, config) ->
    )

  @deleteLevel = (levelId) ->
    $http
    .post(dbServer+'/deleteLevel',params : {levelId:levelId})
    .success((data, status, headers, config) ->
     return data
    )
    .error((data, status, headers, config) ->
    )

  @retrieveLevelById = (levelId) ->
    $http
    .get(dbServer + '/retrieveLevelById', params:{levelId:levelId})
    .success((data)->
      data
    )
    .error((data)->
      console.log 'error in Retrieve of Level By Id'
    )
  @editLevelDetails = (levelId) ->
    $http
    .post(dbServer + 'editLevel', {levelId:levelId})
    .success((data)->
      data
    )
    .error((data)->
      console.log 'Error in Edit Level '
    )
  return

app.controller 'LevelsCtrl', ($scope,levelService,$filter,ngTableParams,$location,$stateParams,$window) ->

  levelService.retrieveLevels().then (data) ->
    console.log "level controller"
    data = data.data
    $scope.levelsTable = new ngTableParams(
      page: 1 # show first page
      count: 5 # count per page
      sorting: {
        leaveCode: 'asc'
      }
    ,
    total: data.length # length of data
    getData: ($defer, params) ->
      # use build-in angular filter
      filteredData = (if params.filter() then $filter("filter")(data, params.filter()) else data)
      orderedData = (if params.sorting() then $filter("orderBy")(filteredData, params.orderBy()) else data)
      params.total orderedData.length # set total for recalc pagination
      $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
      return
    )
    return
  $scope.createNew = ->
    console.log 'adding...'
    levelService.createNewLevel($scope.levelCode,$scope.level,$scope.description).then (data) ->
      if data.data.result
        console.log 'level added'
        console.log data
        $window.location = '#/adminLevels'
    return
#    $location.path('/adminLevel')

  $scope.LevelType = {}
  levelService.retrieveLevelById($stateParams.levelId).then (data) ->
    $scope.LevelType = {
      levelId: data.data.levelId,
      levelCode: data.data.levelCode,
      level: data.data.levelName,
      description: data.data.description
    }
    return
  $scope.update = (id) ->
#    levelService.updateLevel($scope.updatedRecord).then (data) ->
    levelService.updateLevel(id, $scope.LevelType.levelCode, $scope.LevelType.level, $scope.LevelType.description).then (data) ->
      console.log "updating data"
      $window.location = '#/adminLevels'
    return

  $scope.delete = (id) ->
    levelService.deleteLevel(id).then (data) ->
      $window.alert "1 Record Deleted Successfully"
      $window.location.reload();
  return
