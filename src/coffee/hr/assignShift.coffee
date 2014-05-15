app.service 'AssignShift',($http)->
  @retrieveApplications=()->
    $http
      .get(dbServer+'/retrieveShifts',params: {user:$.cookie("user")})
      .success((data,status,headers,config)->
        return data
      )
      .error((data,status,headers,config)->
      )

  @retrieveApplicationById=(ApplicationId)->
    $http
      .get(dbServer+'/retrieveShiftsId',params: {ApplicationId:ApplicationId})
      .success((data,status,headers,config)->
        return data
      )
      .error((data,status,headers,config)->
      )

  @retrieveShiftForUser=()->
    $http
    .get(dbServer+'/retrieveShiftForUser',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )

  @retrieveShiftType=()->
    $http
    .get(dbServer+'/retrieveShiftsTypes')
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )

  @changeEmployeeShift=(application,empId)->
    $http
    .post(dbServer+'/changeEmployeeShift', {application:application,empId:empId})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  return

app.controller 'AssignShiftCtrl', ($scope,AssignShift,$filter, ngTableParams)->
  AssignShift.retrieveApplications().then (data)->
    data = data.data
    $scope.dataTableHrManageShift = new ngTableParams(
      page: 1 # show first page
      count: 10 # count per page
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
  return


app.controller 'AssignShiftEmpCtrl', ($scope,$stateParams,AssignShift)->
  AssignShift.retrieveApplicationById($stateParams.ApplicationID).then (data)->
    $scope.application = {
      fromDate: data.data.from,
      shiftType: data.data.shiftType,
      shiftTimings: data.data.shiftTimings
    }
    $scope.EmpID=data.data.empId
  AssignShift.retrieveShiftType().then (data)->
    $scope.shiftTypes=data.data
  $scope.changeShiftType = () ->
    _.each $scope.shiftTypes, (shiftTypes)->
      if shiftTypes.shiftType==$scope.application.shiftType
        $scope.application.shiftTimings = shiftTypes.shiftStart+'-'+shiftTypes.shiftEnd
  AssignShift.retrieveShiftForUser().then (data)->
    $scope.applicationsOfEmployee = data.data
  $scope.Change = () ->
    AssignShift.changeEmployeeShift($scope.application,$scope.EmpID).then (data)->
      if data.data.result == true
#
      else
#
      AssignShift.retrieveShiftForUser().then (data)->
        $scope.applicationsOfEmployee = data.data


  return

