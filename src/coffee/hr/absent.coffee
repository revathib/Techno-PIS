app.service 'AbsentManagement',($http)->
  @retrieveApplications=()->
    $http
    .get(dbServer+'/retrieveAbsentList',params: {user:$.cookie("user")})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @retrieveApplicationById=(ApplicationId)->
    $http
    .get(dbServer+'/retrieveAbsentId',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @retrieveApplicationsForUser=(ApplicationId)->
    $http
    .get(dbServer+'/retrieveAbsentApplicationsForUser',params: {ApplicationId:ApplicationId})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  @AbsentApplicationAction=(application,action)->
    $http
    .post(dbServer+'/absentApplicationAction',params: {application:application,action:action})
    .success((data,status,headers,config)->
      return data
    )
    .error((data,status,headers,config)->
    )
  return

app.controller 'AbsentCtrl', ($scope,AbsentManagement,$filter, ngTableParams)->
  AbsentManagement.retrieveApplications().then (data)->
    data = data.data
    $scope.dataTableHrManageAbsent = new ngTableParams(
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


app.controller 'AbsentEmpCtrl', ($scope,$stateParams,AbsentManagement,$filter,ngTableParams,$window)->
  $scope.application = {}
  AbsentManagement.retrieveApplicationById($stateParams.ApplicationID).then (data)->
    $scope.application = {
      fromDate: data.data.from,
      toDate: data.data.to,
      absentType: data.data.absentType,
      empID: data.data.empId,
      applicationDate: data.data.applicationDate
      applicationID: data.data.applicationID
    }
  AbsentManagement.retrieveApplicationsForUser($stateParams.ApplicationID).then (data)->
    data = data.data
    $scope.dataTableHrAbsentEmp = new ngTableParams(
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
    AbsentManagement.AbsentApplicationAction($scope.application,action).then (data)->
      if data.data.result
        $window.location='#/hrAbsent'
  return

app.controller 'substituteEmployeeCtrl', ($scope,AbsentManagement,userService,$filter,$window)->
  $scope.sub={}
  absentData = {}
  AbsentManagement.retrieveApplications().then (data)->
    absentData = data.data.LeavesList
    $scope.absentIds = data.data.LeavesList
    console.log data.data
    $scope.subEmpIds = data.data.users

  $scope.changeAbsentId = () ->
    _.each absentData, (data)->
      if ($scope.sub.absentId!=null || $scope.sub.absentId!=undefined) && data.applicationID==$scope.sub.absentId
        $scope.sub.empId = data.empId
      if ($scope.sub.absentId==null || $scope.sub.absentId==undefined)
        $scope.sub.empId = ''









