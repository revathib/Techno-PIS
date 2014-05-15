app.service 'LeaveManagement',($http) ->
  @retrieveApplications = () ->
    $http
    .get(dbServer+'/retrieveEmpLeavesList',params: {user:$.cookie("user")})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )
  @retrieveApplicationById=(ApplicationId) ->
    $http
    .get(dbServer+'/retrieveLeaveId',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )
  @retrieveApplicationsForUser=(ApplicationId) ->
    $http
    .get(dbServer+'/retrieveLeaveApplicationsForUser',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )
  @LeaveApplicationAction=(application,action) ->
    $http
    .post(dbServer+'/leaveApplicationAction',params: {application:application,action:action})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )
  return

app.controller 'LeaveCtrl', ($scope,LeaveManagement,$filter, ngTableParams) ->
  LeaveManagement.retrieveApplications().then (data) ->
    data = data.data
    $scope.dataTableHrManageLeave = new ngTableParams(
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


app.controller 'LeaveEmpCtrl', ($scope,$stateParams,LeaveManagement,$filter,ngTableParams,$window)->
  $scope.application = {}
  LeaveManagement.retrieveApplicationById($stateParams.ApplicationID).then (data)->
    $scope.application = {
      fromDate: data.data.fromDate,
      toDate: data.data.toDate,
      leaveType: data.data.leaveType,
      empID: data.data.empId,
      applicationDate: data.data.applicationDate
      applicationID: data.data.applicationID
    }
  LeaveManagement.retrieveApplicationsForUser($stateParams.ApplicationID).then (data)->
    data = data.data
    $scope.dataTableHrLeaveEmp = new ngTableParams(
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
    LeaveManagement.LeaveApplicationAction($scope.application,action).then (data)->
      if data.data.result
        $window.location='#/hrLeave'
  return





