app.service 'OvertimeManagement',($http)->
  @retrieveApplications=()->
    $http
    .get(dbServer+'/retrieveOvertimeList',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @retrieveApplicationById=(ApplicationId)->
    $http
    .get(dbServer+'/retrieveOvertimeId',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @retrieveApplicationsForUser=(ApplicationId)->
    $http
    .get(dbServer+'/retrieveOvertimeApplicationsForUser',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @OvertimeApplicationAction=(application,action)->
    $http
    .post(dbServer+'/overtimeApplicationAction',params: {application:application,action:action})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  return

app.controller 'OvertimeCtrl', ($scope,OvertimeManagement,$filter, ngTableParams)->
  OvertimeManagement.retrieveApplications().then (data)->
    data = data.data
    $scope.dataTableHrManageOvertime = new ngTableParams(
      page: 1 # show first page
      count: 10 # count per page
      sorting: {
        applicationDate: 'asc'
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
  return


app.controller 'OvertimeEmpCtrl', ($scope,$stateParams,OvertimeManagement,$filter,ngTableParams,$window)->
  $scope.application = {}
  OvertimeManagement.retrieveApplicationById($stateParams.ApplicationID).then (data)->
    $scope.application = {
      from: data.data.from,
      to: data.data.to,
      empID: data.data.empId,
      date: data.data.date
      applicationID: data.data.applicationID
      reason:data.data.reason
      applicationDate:data.data.applicationDate
    }
  OvertimeManagement.retrieveApplicationsForUser($stateParams.ApplicationID).then (data)->
    data = data.data
    $scope.dataTableHrOvertimeEmp = new ngTableParams(
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
  $scope.Action = (action) ->
    OvertimeManagement.OvertimeApplicationAction($scope.application,action).then (data)->
      if data.data.result
        $window.location='#/hrOvertime'
  return
