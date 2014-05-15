app.service 'leavesService', ($http) ->
#  @LeavsList = []
  @createNewLeave = (leaveCode, leaveType, leaveCategory, leaveCount, gender) ->
    console.log leaveCount
    $http
    .post(dbServer + '/addLeave', params : {leaveCode:leaveCode,leaveType:leaveType,leaveCategory:leaveCategory, leaveCount:leaveCount, gender:gender})
    .success((data, status, headers, config) ->
#      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @updateAbsent = (leaveId, leaveCode, leaveType, leaveCategory, leaveCount) ->
    $http
    .post(dbServer + '/updateLeave', params : {leaveId:leaveId,leaveCode:leaveCode,leaveType:leaveType,leaveCategory:leaveCategory,leaveCount:leaveCount})
    .success((data, status, headers, config) ->
      return data
    )
    .error((data, status, headers, config) ->
    )

  @deleteAbsent = (leaveId) ->
    $http
    .post(dbServer + '/deleteLeave', params : {leaveId:leaveId})
    .success((data, status, headers, config) ->
      return data
    )
    .error((data, status, headers, config) ->
    )

  @createNewCategory = (categoryCode, categoryName) ->
    $http
    .post(dbServer + '/addAbsentCategory', params : {categoryCode:categoryCode, categoryName:categoryName})
    .success((data, status, headers, config) ->
      console.log "dataSaved Success"
      return data
    )
    .error((data, status, headers, config) ->
      console.log "Data not Saved"
    )

  @retrieveLeaves = () ->
    console.log "leaves"
    $http
    .get(dbServer+'/retrieveLeaveList')
    .success((data,status,headers,config) ->
      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveLeaveById = (leaveId) ->
    $http
    .get(dbServer + '/retrieveLeaveById', params: {leaveId:leaveId})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  @editLeaveDetails = (application, leaveId) ->
    $http
    .post(dbServer + 'editLeaves', {application:application, leaveId:leaveId})
    .success((data, status, headers, config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveAbsentCategories = () ->
    console.log "categories"
    $http
    .get(dbServer+'/retrieveAbsentCategories')
    .success((data,status,headers,config) ->
      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )
  return


app.controller 'AbsentsCtrl', ($scope,leavesService,$filter,ngTableParams,$location,$stateParams,$window) ->

  leavesService.retrieveLeaves().then (data) ->
#    if leavesService.LeavsList.length == 0
#      leavesService.LeavsList.push i for i in data.data
    data = data.data
    $scope.leavesTable = new ngTableParams(
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
    leavesService.createNewLeave($scope.absent.code, $scope.absent.type, $scope.absent.category, $scope.absent.count, $scope.absent.gender).then (data) ->
      if data.data.result
        console.log "saved data"
        $scope.absentAdded=true;
        $window.location = '#/adminAbsents'
#      if data.data.result
#      $location.path '#/adminAbsents'
    return


  $scope.LeaveById = {}
  leavesService.retrieveLeaveById($stateParams.leaveId).then (data) ->
    console.log "LeaveById"
    $scope.LeaveById = {
      leaveId: data.data.leaveId,
      leaveCode: data.data.leaveCode,
      leaveCategory: data.data.leaveCategory,
      leaveType: data.data.leaveType,
      leaveCount: data.data.leaveCount
    }
    return

  $scope.update = (id) ->
    leavesService.updateAbsent(id, $scope.LeaveById.leaveCode, $scope.LeaveById.leaveType, $scope.LeaveById.leaveCategory, $scope.LeaveById.leaveCount).then (data) ->
      console.log "updating data"
      $window.location = '#/adminAbsents'
    #      if data.data.result
    #      $location.path '#/adminAbsents'
    return

  $scope.delete = (id) ->
    leavesService.deleteAbsent(id).then (data) ->
      console.log "deleting..."
      console.log data
      $window.alert "1 Record Deleted Suscces!"
      $window.location.reload();
#      $window.location='#/adminAbsents'

#    for i in leavesService.LeavsList
##      console.log i.leaveId
##      console.log typeof i
#      if i.leaveId == id
#        ele = leavesService.LeavsList.indexOf(i)
#        leavesService.LeavsList.splice(ele,1)
#        #        $location.path('#/adminAbsents')
#        $window.alert "Deleted"
#        $window.location='#/adminAbsents'
#    #        $window.location.href = '/#/adminAbsents'
#    return

  $scope.absentCategories = []
  leavesService.retrieveAbsentCategories().then (data) ->
    $scope.absentCategories = data.data
    console.log $scope.absentCategories
    return

  $scope.cancelEdit = ->
    $location.url('#/adminLeaves')
#    $location.href = '#/adminLeaves'
    return

  return

app.controller 'AbsentCategoriesCtrl', ($scope,leavesService,$filter,ngTableParams) ->
  leavesService.retrieveAbsentCategories().then (data) ->
    data = data.data
    console.log data
    $scope.absentCategoriesTable = new ngTableParams(
      page: 1 # show first page
      count: 5 # count per page
      sorting: {
        categoryId: 'asc'
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
    leavesService.createNewCategory($scope.category.code, $scope.category.name).then (data) ->
      if data.data.result
        $window.location='#/adminAbsentCategories'
    return
    $location.path('/adminLeaves')

  return

